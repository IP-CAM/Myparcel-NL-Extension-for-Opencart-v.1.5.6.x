<?php
require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';

class ControllerTotalMyparcelTotal extends Controller {
	public function index()
	{
		$this->data = array();
		$this->data['myparcel'] = MyParcel($this->registry);

		$this->load->language(MyParcel()->getTotalPath() . 'myparcel_total');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			if (isset($this->request->post['myparcel_total_sort_order'])) {
				if (!is_numeric($this->request->post['myparcel_total_sort_order'])) {
					MyParcel()->notice->add(MyParcel()->lang->get('error_sort_order_must_be_numeric'), 'warning');
				}
			}

			if (!MyParcel()->notice->count('warning')) {
				$this->model_setting_setting->editSetting('myparcel_total', $this->request->post);

				$this->session->data['success'] = $this->language->get('text_success');

				$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

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
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/total', 'token=' . $this->session->data['token'] . '&type=total', true),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/total/myparcel_total', 'token=' . $this->session->data['token'], true),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('total/myparcel_total', 'token=' . $this->session->data['token'], true);

		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'] . '&type=total', true);

		if (isset($this->request->post['myparcel_total_status'])) {
			$this->data['myparcel_total_status'] = $this->request->post['myparcel_total_status'];
		} else {
			$this->data['myparcel_total_status'] = $this->config->get('myparcel_total_status');
		}

		if (isset($this->request->post['myparcel_total_sort_order'])) {
			$this->data['myparcel_total_sort_order'] = $this->request->post['myparcel_total_sort_order'];
		} else {
			$this->data['myparcel_total_sort_order'] = $this->config->get('myparcel_total_sort_order');
		}

		$this->template = 'total/myparcel_total.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	function validate()
	{
		return true;
	}

	function install()
	{
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('myparcel_total', array(
			'myparcel_total_status' => 1,
			'myparcel_total_sort_order' => 2
		));
	}
}