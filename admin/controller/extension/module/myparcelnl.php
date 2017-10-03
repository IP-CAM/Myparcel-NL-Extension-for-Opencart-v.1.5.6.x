<?php
require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';
class ControllerExtensionModuleMyparcelnl extends Controller
{
    protected $version = '1.0.6';

    private $error = array();

    /**
     * Load all required models and classes
     **/
    private function setup()
    {
        MyParcel($this->registry);
        $this->load->language(MyParcel()->getMyparcelModulePath());
        $this->load->model('extension/extension');
        $this->load->model('setting/setting');
        $this->load->model('design/layout');
        $this->load->model('myparcelnl/shipping');
        $this->load->model('myparcelnl/init');

        $this->document->addScript(MyParcel()->getJsUrl() . 'select2.min.js');
        $this->document->addScript(MyParcel()->getJsUrl() . 'myparcelnl.js');
        $this->document->addScript(MyParcel()->getJsUrl() . 'colorpicker.js');
        $this->document->addStyle(MyParcel()->getCssUrl() . 'select2.css');
        $this->document->addStyle(MyParcel()->getCssUrl() . 'myparcelnl.css');
        $this->document->addStyle(MyParcel()->getCssUrl() . 'colorpicker.css');
    }

    /**
     * Create Myparcel tables when the module is installed
    **/
    public function install()
    {
        $this->setup();
        $this->model_myparcelnl_init->installDatabase();
        $this->model_myparcelnl_init->installMyParcelTotal();
        $this->model_myparcelnl_init->installMyParcelShipping();
        /**
         * Install core ocmod file
        **/
        $core_ocmod_file = MyParcel()->getCoreDir() . 'myparcel.ocmod.xml';
        MyParcel()->helper->install_ocmod($core_ocmod_file);

        /**
         * Install checkout ocmod file base on system requirement
         **/
        // TODO Check if Ajax Quick Check is installed
        // Use suitable ocmod for each condition
        if (MyParcel()->helper->isModuleExist('d_quickcheckout', true)) {
            $ocmod_file = MyParcel()->getCoreDir() . 'myparcel.aqc.ocmod.xml';
        } else {
            $ocmod_file = MyParcel()->getCoreDir() . 'myparcel.checkout.ocmod.xml';
        }
        if (is_file($ocmod_file)) {
            MyParcel()->helper->install_ocmod($ocmod_file);
        }
    }

    /**
     * Create Myparcel tables when the module is uninstalled
     **/
    public function uninstall()
    {
        $this->setup();
        //$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "orders_myparcel`;");
        $this->model_myparcelnl_init->uninstallMyParcelTotal();
        $this->model_myparcelnl_init->uninstallMyParcelShipping();
        MyParcel()->helper->uninstall_ocmod();
    }

    /**
     * Render the form of Myparcel configurations when a merchant clicks "Edit module"
     **/
    public function index()
    {
        $this->setup();

        $data = $this->_setText();
        $data['myparcel'] = MyParcel();
        /** @var MyParcel_Helper $helper **/

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->_validate()) { // Start If: Validates and check if data is coming by save (POST) method

            $this->_validateInput();

            if (!MyParcel()->notice->count('warning')) {
                if (!empty($this->request->post['myparcelnl_fields_export']['insured_amount_selectbox'])) {
                    unset($this->request->post['myparcelnl_fields_export']['insured_amount_custom']);
                }
                $this->model_setting_setting->editSetting('myparcelnl', $this->request->post);      // Parse all the coming data to Setting Model to save it in database.
                $this->session->data['success'] = $this->language->get('text_success'); // To display the success text on data save

                MyParcel()->notice->add($this->language->get('text_success'), 'success');

                $this->response->redirect($this->url->link(MyParcel()->getMyparcelModulePath(), 'token=' . $this->session->data['token'], true)); // Redirect to the Module Listing
            }
        }

        $data['action'] = $this->url->link(MyParcel()->getMyparcelModulePath(), 'token=' . $this->session->data['token'], true); // URL to be directed when the save button is pressed
        $data['cancel'] = $this->url->link(MyParcel()->getModuleListPath(), 'token=' . $this->session->data['token'], true); // URL to be redirected when cancel button is pressed

        $data['package_types'] = $this->_getPackageTypes();

        // ******* Get all enabled shipping methods
        $data['shipping_methods'] = $this->model_myparcelnl_shipping->getShippingMethods();

        if (isset($this->request->post['myparcelnl_fields_general']) && isset($this->request->post['myparcelnl_fields_export']) && isset($this->request->post['myparcelnl_fields_checkout'])) {
            $data['myparcelnl_fields_general'] = $this->request->post['myparcelnl_fields_general'];
            $data['myparcelnl_fields_export'] = $this->request->post['myparcelnl_fields_export'];
            $data['myparcelnl_fields_checkout'] = $this->request->post['myparcelnl_fields_checkout'];
        } else {
            $data['myparcelnl_fields_general'] = $this->_getSettings('myparcelnl_fields_general');
            $data['myparcelnl_fields_export'] = $this->_getSettings('myparcelnl_fields_export');
            $data['myparcelnl_fields_checkout'] = $this->_getSettings('myparcelnl_fields_checkout');
        }

        $data['layouts'] = $this->model_design_layout->getLayouts(); // Getting all the Layouts available on system
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->load->model('localisation/order_status');
        $data['order_status'] = array();
        $data['order_status'] = $this->model_localisation_order_status->getOrderStatuses();

        $this->response->setOutput($this->load->view(MyParcel()->getMyparcelModulePath() . '.tpl', $data));
    }

    /**
     * Ajax action
     * Executed when admin clicks on one of the action buttons in Order Overview or Order Details
     **/
    public function shipment()
    {
        $action = isset($_REQUEST['action']) ? $_REQUEST['action'] : null;

        switch($_SERVER['REQUEST_METHOD'])
        {
            case 'GET': $request = &$_GET; break;
            case 'POST': $request = &$_POST; break;
            default:
                $request = $_REQUEST;
        }

        if (!empty($action)) {

            /** @var MyParcel_Shipment $shipment **/
            $shipment = MyParcel($this->registry)->shipment;

            switch ($action) {
                case 'add_shipment':
                    $shipment->add($request);
                    break;
                case 'get_labels':
                    $order_ids = isset($request['order_ids']) ? $request['order_ids'] : null;
                    $shipment->printPdf($order_ids);
                    break;
                case 'add_return':
                    $shipment->addReturn($request); // Get return form and show in a popup
                    break;
                case 'send_return':
                    $shipment->sendReturn($request); // Create return shipment and send email to customer
                    break;
            }
        }
    }


    /**
     * Ajax action
     * Executed when admin clicks button print in header right
     **/
    public function printBatch()
    {
        $shipment = MyParcel($this->registry)->shipment;
        $orders = array();
        if (isset($this->request->post['selected'])) {
            $orders = $this->request->post['selected'];
        } elseif (isset($this->request->get['order_id'])) {
            $orders[] = $this->request->get['order_id'];
        }
        $shipment->printPdf($orders);
    }

    public function exportBatch()
    {
        $shipment = MyParcel($this->registry)->shipment;
        $orders = array();
        if (!empty($_POST['order_ids'])) {
            $orders = $_POST['order_ids'];
        }

        $params = array();
        $params['order_ids'] = $orders;
        $shipment->add($params);
    }

    public function exportPrintBatch()
    {
        $shipment = MyParcel($this->registry)->shipment;
        $orders = array();
        if (!empty($_POST['order_ids'])) {
            $orders = $_POST['order_ids'];
        }

        $params = array();
        $params['order_ids'] = $orders;
        $shipment->add($params);
    }

    /**
     * Ajax action
     * Return HTML of checkboxes named "selected"
     * Only used in Opencart 1x
     **/
    public function exportPrintBatchHelper()
    {
        $html = '';
        if (isset($this->request->post['selected'])) {
            foreach ($this->request->post['selected'] as $order_id) {
                $html .= '<input name="selected[]" style="display:none;" checked="checked" value="' . $order_id . '" type="checkbox">';
            }
        }
        echo json_encode(
            array(
                'status' => 'success',
                'html' => $html
            )
        );
        die;
    }

    /**
     * Ajax action
     * Save shipment options in order overview or order details
     **/
    public function shipToMyParcel()
    {
        MyParcel($this->registry);
        /** @var MyParcel_Shipment_Helper $shipment_helper **/
        $shipment_helper = MyParcel()->shipment->shipment_helper;
        $shipment_helper->saveOptions();
    }

    /**
     * Get text from language file and pass translated text to template file
     * Also set breadscrumbs links
     **/
    private function _setText()
    {
        $this->document->setTitle($this->language->get('heading_title')); // Set the title of the page to the heading title in the Language file i.e., Hello World
        $data = MyParcel()->helper->set_module_text($this->language);

        /*This Block returns the warning if any*/
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
        /*End Block*/

        /*This Block returns the error code if any*/
        if (isset($this->error['code'])) {
            $data['error_code'] = $this->error['code'];
        } else {
            $data['error_code'] = '';
        }
        /*End Block*/

        return array_merge($data, $this->_setBreadscrumbs());
    }

    private function _setBreadscrumbs()
    {
        /* Making of Breadcrumbs to be displayed on site*/
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], true),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link(MyParcel()->getModulePath(), 'token=' . $this->session->data['token'], true),
            'separator' => ' :: '
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link(MyParcel()->getMyparcelModulePath(), 'token=' . $this->session->data['token'], true),
            'separator' => ' :: '
        );

        /* End Breadcrumb Block*/
        return $data;
    }

    /**
     * Get Myparcel settings from database
     * @return array of setting key - value pairs
     **/
    private function _getSettings($tab_name)
    {
        return $this->config->get($tab_name);
    }

    /**
     * Retrieve Myparcel package types
     * @return array of package type key - value pairs
     **/
    private function _getPackageTypes()
    {
        return array(
            1 => $this->language->get('package_type_parcel'),
            2 => $this->language->get('package_type_mailbox'),
            3 => $this->language->get('package_type_unpaid_letter'),
        );
    }

    /**
     * Validate the form of Myparcel configurations
     * @return array of error messages (empty if no errors)
     **/
    private function _validate()
    {
        if (!$this->user->hasPermission('modify', MyParcel()->getMyparcelModulePath())) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        // form error checking
        return !$this->error;
    }

    /**
     * Validate Input Settings
     **/
    private function _validateInput()
    {
        $insured_amount_custom = isset($this->request->post['myparcelnl_fields_export']['insured_amount_custom'])?$this->request->post['myparcelnl_fields_export']['insured_amount_custom']:'';

        if ( !empty($this->request->post['myparcelnl_fields_export']['insured']) && empty($this->request->post['myparcelnl_fields_export']['insured_amount_selectbox']) && (!is_numeric($insured_amount_custom) || intval($insured_amount_custom)  <= 500)) {
            // array_push($messagesError, $this->language->get('error_amount'));
            MyParcel()->notice->add($this->language->get('error_amount'), 'warning');
        }

        if (!empty($this->request->post['myparcelnl_fields_checkout']['enable_delivery'])) {
            /*validate cut off time fomat hh:mm*/
            if (!empty($this->request->post['myparcelnl_fields_checkout']['cut_off_time']) && !MyParcel()->helper->validate_cutoff_time($this->request->post['myparcelnl_fields_checkout']['cut_off_time'])) {
                MyParcel()->notice->add($this->language->get('error_cut_off_time'), 'warning');
            }

            /*if (!empty($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) && !is_numeric($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) || intval($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) < 0) {
                MyParcel()->notice->add($this->language->get('error_delivery_days_window'), 'warning');
            }*/

            /*if ( (isset($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) && !is_numeric($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) ) || (!empty($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) && intval($this->request->post['myparcelnl_fields_export']['empty_parcel_weight'])<0) ) {
                MyParcel()->notice->add($this->language->get('error_empty_parcel_weight'), 'warning');
            }*/

            if (($this->request->post['myparcelnl_fields_checkout']['only_recipient_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['only_recipient_fee']))) {
                MyParcel()->notice->add($this->language->get('error_only_recipient_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['signed_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['signed_fee']))) {
                MyParcel()->notice->add($this->language->get('error_signed_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['night_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['night_fee']))) {
                MyParcel()->notice->add($this->language->get('error_night_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['morning_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['morning_fee']))) {
                MyParcel()->notice->add($this->language->get('error_morning_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['pickup_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['pickup_fee']))) {
                MyParcel()->notice->add($this->language->get('error_pickup_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['pickup_express_enabled'] == 1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['pickup_express_fee']))) {
                MyParcel()->notice->add($this->language->get('error_pickup_express_fee'), 'warning');
            }

            if (($this->request->post['myparcelnl_fields_checkout']['mailbox_enabled'] == 1)) {
                if (empty($this->request->post['myparcelnl_fields_checkout']['mailbox_title'])) {
                    MyParcel()->notice->add($this->language->get('error_mailbox_title_empty'), 'warning');
                }

                if (
                    empty($this->request->post['myparcelnl_fields_checkout']['mailbox_fee']) ||
                    !is_numeric($this->request->post['myparcelnl_fields_checkout']['mailbox_fee'])
                ) {

                    MyParcel()->notice->add($this->language->get('error_mailbox_fee_empty'), 'warning');
                }

                if (
                    empty($this->request->post['myparcelnl_fields_checkout']['mailbox_weight']) ||
                    !is_numeric($this->request->post['myparcelnl_fields_checkout']['mailbox_fee'])
                ) {

                    MyParcel()->notice->add($this->language->get('error_mailbox_weight_empty'), 'warning');
                }
            }

            if (!empty($this->request->post['myparcelnl_fields_checkout']['dropoff_delay'])) {
                if (!is_numeric($this->request->post['myparcelnl_fields_checkout']['dropoff_delay'])) {
                    MyParcel()->notice->add($this->language->get('error_dropoff_delay'), 'warning');
                } else {
                    if ($this->request->post['myparcelnl_fields_checkout']['dropoff_delay'] < 0 || $this->request->post['myparcelnl_fields_checkout']['dropoff_delay'] > 14) {
                        MyParcel()->notice->add($this->language->get('error_dropoff_delay_wrong_range'), 'warning');
                    }
                }
            }

           /* if ((trim($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) == '') || (!empty($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) && !is_numeric($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']))) {
                MyParcel()->notice->add($this->language->get('error_delivery_windows'), 'warning');
            }*/
        }
    }
}
