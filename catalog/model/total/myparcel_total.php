<?php
class ModelTotalMyparcelTotal extends Model
{
	public function getTotal(&$total_data, &$total, &$taxes)
	{
		if ($this->cart->hasShipping() && isset($this->session->data['shipping_method'])) {

			if (!class_exists('MyParcel')) {
				require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';
				MyParcel($this->registry);
			}

			if (MyParcel()->shipment->checkout->checkValidShippingMethod()) {

				if (!empty($this->session->data['myparcel']['data'])) {

					/** @var MyParcel_Shipment_Checkout $checkout_helper * */
					$checkout_helper = MyParcel()->shipment->checkout;
					$data = $this->session->data['myparcel'];
					$total_array = $checkout_helper->getTotalArray($data);
					$total_price = 0;

					foreach ($total_array as $total_code => $total_item) {
						$total_price += $total_item['price'];
					}

					if ($total_price > 0) {
						$total_data[] = array(
							'code' => 'myparcel_total',
							'title' => $this->config->get('myparcel_shipping_title') .
								'
							<a class="button-myparcel-total-details" data-collapse="1">'
								. MyParcel()->lang->get('entry_details') .
								'<i class="fa fa-caret-down"></i>
							</a>
						',
							'text' => $this->currency->format($total_price),
							'value' => $total_price,
							'sort_order' => $this->config->get('myparcel_total_sort_order')
						);

						$total += $total_price;
					}
				}
			}
		}
	}
}