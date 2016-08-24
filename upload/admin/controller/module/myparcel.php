<?php
class ControllerModuleMyParcel extends Controller {
    private $error = array();

    public function index() {
        $this->language->load('module/myparcel');

        $this->document->setTitle($this->language->get('heading_title'));
        //$this->document->addScript('view/javascript/openbay/faq.js');
        //$this->document->addStyle('view/stylesheet/openbay.css');

        $this->load->model('setting/setting');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('myparcel', $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->cache->delete('myparcel');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_remove'] = $this->language->get('button_remove');

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

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/myparcel', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/myparcel', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token'] = $this->session->data['token'];


        $this->data['modules'] = array();

        if (isset($this->request->post['myparcel_module'])) {
            $this->data['modules'] = $this->request->post['myparcel_module'];
        } elseif ($this->config->get('myparcel_module')) {
            $this->data['modules'] = $this->config->get('myparcel_module');
        }else{
            $this->data['modules'] = array();
        }
        if (isset($this->request->post['myparcel_module_username'])) {
            $this->data['myparcel_module_username'] = $this->request->post['myparcel_module_username'];
        } elseif ($this->config->get('myparcel_module_username')) {
            $this->data['myparcel_module_username'] = $this->config->get('myparcel_module_username');
        }else{
            $this->data['myparcel_module_username'] = '';
        }
        if (isset($this->request->post['myparcel_module_api_key'])) {
            $this->data['myparcel_module_api_key'] = $this->request->post['myparcel_module_api_key'];
        } elseif ($this->config->get('myparcel_module_api_key')) {
            $this->data['myparcel_module_api_key'] = $this->config->get('myparcel_module_api_key');
        }else{
            $this->data['myparcel_module_api_key'] = '';
        }
        if (isset($this->request->post['myparcel_module_frontend'])) {
            $this->data['myparcel_module_frontend'] = $this->request->post['myparcel_module_frontend'];
        } elseif ($this->config->get('myparcel_module_frontend')) {
            $this->data['myparcel_module_frontend'] = $this->config->get('myparcel_module_frontend');
        }else{
            $this->data['myparcel_module_frontend'] = 0;
        }

        $this->load->model('design/layout');

        $this->data['layouts'] = $this->model_design_layout->getLayouts();

        $this->template = 'module/myparcel.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/myparcel')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}
?>