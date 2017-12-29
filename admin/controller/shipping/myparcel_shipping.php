<?php
require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';

class ControllerShippingMyparcelShipping extends Controller {
	private $error = array(); 

	public function index()
	{
		$this->data = array();
		$this->data['myparcel'] = MyParcel($this->registry);

		$this->language->load('shipping/myparcel_shipping');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('myparcel_shipping', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_cost'] = $this->language->get('entry_cost');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_shipping'),
			'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('shipping/myparcel_shipping', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('shipping/myparcel_shipping', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['myparcel_shipping_title'])) {
			$this->data['myparcel_shipping_title'] = $this->request->post['myparcel_shipping_title'];
		} else {
			$this->data['myparcel_shipping_title'] = $this->config->get('myparcel_shipping_title');
		}

		if (isset($this->request->post['myparcel_shipping_cost'])) {
			$this->data['myparcel_shipping_cost'] = $this->request->post['myparcel_shipping_cost'];
		} else {
			$this->data['myparcel_shipping_cost'] = $this->config->get('myparcel_shipping_cost');
		}

		if (isset($this->request->post['myparcel_shipping_status'])) {
			$this->data['myparcel_shipping_status'] = $this->request->post['myparcel_shipping_status'];
		} else {
			$this->data['myparcel_shipping_status'] = $this->config->get('myparcel_shipping_status');
		}

		if (isset($this->request->post['myparcel_shipping_sort_order'])) {
			$this->data['myparcel_shipping_sort_order'] = $this->request->post['myparcel_shipping_sort_order'];
		} else {
			$this->data['myparcel_shipping_sort_order'] = $this->config->get('myparcel_shipping_sort_order');
		}				

		$this->template = 'shipping/myparcel_shipping.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'shipping/myparcel_shipping')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	function install()
	{
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('myparcel_shipping', array(
			'myparcel_shipping_title' => 'Shipping & Handling',
			'myparcel_shipping_cost' => 0,
			'myparcel_shipping_status' => 1,
			'myparcel_shipping_sort_order' => 0
		));
	}
}
?>