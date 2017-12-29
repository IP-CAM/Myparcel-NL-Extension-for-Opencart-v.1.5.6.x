<?php
require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';
class ControllerModulemyparcelnl extends Controller {
	private $error = array(); 

    private function setup(){
        MyParcel($this->registry);
        $this->load->language(MyParcel()->getMyparcelModulePath());
        $this->load->model('setting/extension');
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
         * Remember that there is no function called "This->load->controller()" in Opencart 1x
         * GetChild is the only way to call an "outside" controller function
         **/
        $this->getChild('total/myparcel_total/install');
        $this->getChild('shipping/myparcel_shipping/install');

        /**
         * Need to remove vqmod file for default / aqc
         **/
        if (MyParcel()->helper->isModuleExist('d_quickcheckout', true)) {
            $file_to_remove = MyParcel()->getRootDir() . 'vqmod/xml/vqmod_myparcel.checkout.xml';
        } else {
            $file_to_remove = MyParcel()->getRootDir() . 'vqmod/xml/vqmod_myparcel.aqc.xml';
        }
        @unlink($file_to_remove);
    }

    /**
     * Create Myparcel tables when the module is uninstalled
     **/
    public function uninstall()
    {
        $this->setup();
        $this->model_myparcelnl_init->uninstallMyParcelTotal();
        $this->model_myparcelnl_init->uninstallMyParcelShipping();
    }

    /**
     * Render the form of Myparcel configurations when a merchant clicks "Edit module"
     **/
	public function index() {
	    $this->language->load('module/myparcelnl');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');
        $this->setup();

        // Get text label general settings
        $this->data = $this->_setText();
        $this->_setBreadscrumbs();
        $this->data['myparcel'] = MyParcel();
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->_validate()) {

            $this->_validateInput();

            if (!MyParcel()->notice->count('warning')) {
                if (!empty($this->request->post['myparcelnl_fields_export']['insured_amount_selectbox'])) {
                    unset($this->request->post['myparcelnl_fields_export']['insured_amount_custom']);
                }

                $this->model_setting_setting->editSetting('myparcelnl', $this->request->post);
                $this->session->data['success'] = $this->language->get('text_success');
            }
        }

        if (isset($this->request->post['myparcelnl_fields_general']) && isset($this->request->post['myparcelnl_fields_export']) && isset($this->request->post['myparcelnl_fields_checkout'])) {
            $this->data['myparcelnl_fields_general'] = $this->request->post['myparcelnl_fields_general'];
            $this->data['myparcelnl_fields_export'] = $this->request->post['myparcelnl_fields_export'];
            $this->data['myparcelnl_fields_checkout'] = $this->request->post['myparcelnl_fields_checkout'];
        } else {
            $this->data['myparcelnl_fields_general'] = $this->_getSettings('myparcelnl_fields_general');
            $this->data['myparcelnl_fields_export'] = $this->_getSettings('myparcelnl_fields_export');
            $this->data['myparcelnl_fields_checkout'] = $this->_getSettings('myparcelnl_fields_checkout');
        }

        $this->data['myparcel'] = MyParcel();

        $this->data['insured_amounts'] = array(
            '49' => $this->language->get('entry_tab_2_select_insured_up_to_50'),
            '249' => $this->language->get('entry_tab_2_select_insured_up_to_250'),
            '499' => $this->language->get('entry_tab_2_select_insured_up_to_500'),
            '' => $this->language->get('entry_tab_2_select_insured_500'),
        );

        // Get status orders
        $this->load->model('localisation/order_status');
        $this->data['order_status'] = array();
        $this->data['order_status'] = $this->model_localisation_order_status->getOrderStatuses();

        $this->data['package_types'] = $this->_getPackageTypes();
        $this->data['shipping_methods'] = $this->model_myparcelnl_shipping->getShippingMethods();

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['image'])) {
            $this->data['error_image'] = $this->error['image'];
        } else {
            $this->data['error_image'] = array();
        }

        $this->data['action'] = $this->url->link('module/myparcelnl', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token'] = $this->session->data['token'];

        $this->data['modules'] = array();
        $this->load->model('design/layout');

        $this->data['layouts'] = $this->model_design_layout->getLayouts();

        $this->template = 'module/myparcelnl.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
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
        $shipment->add($params, true);
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
     * Get Myparcel settings from database
     * @return array of setting key - value pairs
     **/
    private function _getSettings($tab_name)
    {
        return $this->config->get($tab_name);
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
        $data = array();
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/myparcelnl', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        return $data;
    }

    /**
     * Validate the form of Myparcel configurations
     * @return array of error messages (empty if no errors)
     **/
	protected function _validate() {
        if (!$this->user->hasPermission('modify', 'module/myparcelnl')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
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

        /*validate cut off time fomat hh:mm*/
        if (!empty($this->request->post['myparcelnl_fields_checkout']['cut_off_time']) && !MyParcel()->helper->validate_cutoff_time($this->request->post['myparcelnl_fields_checkout']['cut_off_time'])) {
            MyParcel()->notice->add($this->language->get('error_cut_off_time'), 'warning');
        }

        if (!empty($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) && !is_numeric($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) || intval($this->request->post['myparcelnl_fields_checkout']['delivery_days_window'])<0) {
            MyParcel()->notice->add($this->language->get('error_delivery_days_window'), 'warning');
        }

        /*if ( (isset($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) && !is_numeric($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) ) || (!empty($this->request->post['myparcelnl_fields_export']['empty_parcel_weight']) && intval($this->request->post['myparcelnl_fields_export']['empty_parcel_weight'])<0) ) {
            MyParcel()->notice->add($this->language->get('error_empty_parcel_weight'), 'warning');
        }*/

        if (($this->request->post['myparcelnl_fields_checkout']['only_recipient_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['only_recipient_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_only_recipient_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['signed_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['signed_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_signed_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['night_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['night_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_night_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['morning_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['morning_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_morning_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['pickup_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['pickup_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_pickup_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['pickup_express_enabled']==1) && (!is_numeric($this->request->post['myparcelnl_fields_checkout']['pickup_express_fee'])) ) {
            MyParcel()->notice->add($this->language->get('error_pickup_express_fee'), 'warning');
        }

        if (($this->request->post['myparcelnl_fields_checkout']['mailbox_enabled']==1) ) {
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

        if (empty($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) || (empty($this->request->post['myparcelnl_fields_checkout']['delivery_days_window']) && !is_numeric($this->request->post['myparcelnl_fields_checkout']['delivery_days_window'])) ) {
            MyParcel()->notice->add($this->language->get('error_delivery_windows'), 'warning');
        }
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
}
?>