<?php
/** @var MyParcel_Shipment $checkout_helper **/
$shipment_class = MyParcel()->shipment;
/** @var MyParcel_Shipment_Checkout $checkout_helper **/
$checkout_helper = $shipment_class->checkout;
$frontend_api_url = 'https://api.myparcel.nl/delivery_options';

// delivery types
$delivery_types = $checkout_helper::$delivery_types;
// delivery options
$delivery_options = $checkout_helper::$delivery_extra_options;

// get delivery option fees/prices
$registry = MyParcel::$registry;
$cart = $registry->get('cart');
$config = $registry->get('config');
$session = $registry->get('session');
/** @var \Cart\Currency $currency **/
$currency = $registry->get('currency');

if (isset($session->data['myparcel'])) {
    unset($session->data['myparcel']);
}

$checkout_settings          = $config->get('myparcelnl_fields_checkout');
$export_default_settings    = $config->get('myparcelnl_fields_export');
$price_options = array_merge( $delivery_options, $delivery_types );

if (MyParcel()->helper->isModuleExist('d_quickcheckout', true)) {
    $prices = $checkout_helper->getDeliveryPrices(true, false, '+ ');
} else {
    $prices = $checkout_helper->getDeliveryPrices();
}

// exclude delivery types
$exclude_delivery_types = array();
foreach ($checkout_helper::$delivery_types_as_value as $delivery_type => $key) {
    // JS API correction
    if ($delivery_type == 'standard' || $delivery_type == 'mailbox') {
        continue;
    }
    if (!isset($checkout_settings[$delivery_type.'_enabled']) || (isset($checkout_settings[$delivery_type.'_enabled']) && empty(intval($checkout_settings[$delivery_type.'_enabled']))) ) {
        $exclude_delivery_types[] = $key;
    }
}
$exclude_delivery_types = implode(';', $exclude_delivery_types);

// combine settings
$settings = array(
    'base_url'				=> $frontend_api_url,
    'exclude_delivery_type'	=> $exclude_delivery_types,
    'price'					=> $prices,
    'cutoff_time'			=> !empty($checkout_settings['cutoff_time']) ? $checkout_settings['cutoff_time'] : '',
    'deliverydays_window'	=> !empty($checkout_settings['delivery_days_window']) ? max(1,$checkout_settings['delivery_days_window']) : 'disabled',
    'dropoff_delay'			=> !empty($checkout_settings['dropoff_delay']) ? $checkout_settings['dropoff_delay'] : '',
    'dropoff_days'			=> !empty($checkout_settings['dropoff_days']) ? implode(';', $checkout_settings['dropoff_days'] ): '',
);

// remove empty options
$settings = array_filter($settings);

// Get shipping methods that the delivery iframe will display
// These shipping methods are retrieved from Admin Settings \ Default Export \ Package types \ Type "Parcel"
// If cart shipping method is empty, delivery iframe will surely display
if (!empty( $export_default_settings['shipping_methods_package_types'][1] ) ) {
    // Shipping methods associated with parcels = enable delivery options
    //$delivery_options_shipping_methods = $export_default_settings['shipping_methods_package_types'][1];
    $delivery_options_shipping_methods = array('myparcel_shipping');
} else {
    $delivery_options_shipping_methods = array('myparcel_shipping');
}
$delivery_options_shipping_methods = json_encode($delivery_options_shipping_methods);

$country_code = '';

if (version_compare(VERSION, '2.0.0.0', '>=')) {
    // Get shipping address from session data if possible
    if (!empty($session->data['shipping_address'])) {
        $shipping_address = $session->data['shipping_address'];
        $country_code = $shipping_address['iso_code_2'];
        $address_parts = MyParcel()->helper->getAddressComponents($shipping_address['address_1']);
        $settings['number'] = isset($address_parts['house_number']) ? $address_parts['house_number'] : '';
        $settings['street'] = isset($address_parts['street']) ? $address_parts['street'] : '';
        $settings['postal_code'] = $shipping_address['postcode'];
    }
} else {
    if (!empty($session->data['shipping_country_id'])) {
        $registry = MyParcel::$registry;
        $loader = $registry->get('load');
        $address_1 = '';

        if (!empty($session->data['shipping_address_id'])) {
            $address_id = $session->data['shipping_address_id'];
            $loader->model('account/address');
            $model_address = $registry->get('model_account_address');
            $address_data = $model_address->getAddress($address_id);
            $address_1 = $address_data['address_1'];
            $country_code = $address_data['iso_code_2'];
        } else {
            if (!empty($session->data['guest']['shipping']['address_1'])) {
                $address_1 = $session->data['guest']['shipping']['address_1'];
                $country_code = $session->data['guest']['shipping']['iso_code_2'];
            }
        }

        $address_parts = MyParcel()->helper->getAddressComponents($address_1);
        $settings['number'] = isset($address_parts['house_number']) ? $address_parts['house_number'] : '';
        $settings['street'] = isset($address_parts['street']) ? $address_parts['street'] : '';
        $settings['postal_code'] = $session->data['shipping_postcode'];
    }
}

// encode settings for JS object
$settings = json_encode($settings);

$iframe_url =  MyParcel()->helper->add_query_arg(
    array(
        'route'             => 'myparcelnl/myparcel_delivery/index',
        'mypa_settings'     => urlencode($settings),
        'mailbox_enabled'   => MyParcel()->shipment->checkout->isMailboxAvailable(),
        'var'               => ''
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_address_url =  MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/address',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_address_components_url =  MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/address_components',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_address_reset_delivery =  MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/reset',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_address_from_session =  MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/address_session',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_total_details =  MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/total_details',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$myparcel_ajax_get_delivery_iframe_content = MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/iframe_content',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$myparcel_ajax_set_session = MyParcel()->helper->add_query_arg(
    array(
        'route'         => 'myparcelnl/myparcel_delivery/set_session',
    ),
    MyParcel()->getHomeUrl() . 'index.php'
);

$ajax_get_loading_icon =  MyParcel()->getImageUrl() . 'myparcel-spin.gif';

?>

<script>
    jQuery( function( $ ) {
        window.mypa = {};
        window.mypa.settings = <?php echo $settings; ?>;
        window.myparcel_oc_version = "<?php echo VERSION; ?>";
        window.myparcel_aqc_enabled = <?php echo (MyParcel()->helper->isModuleExist('d_quickcheckout', true) ? 'true' : 'false'); ?>;
        window.myparcel_delivery_options_shipping_methods = <?php echo $delivery_options_shipping_methods; ?>;
        window.myparcel_delivery_iframe_url = "<?php echo $iframe_url ?>";
        window.myparcel_delivery_iframe_loading_icon = "<?php echo '<div style=\'margin:auto;\'><img src=\'' . MyParcel()->getImageUrl() . 'loading.gif' . '\'></div>'  ?>";
        window.enable_delivery = <?php echo (!empty($checkout_settings['enable_delivery']) ? 'true' : 'false') ?>;
        window.myparcel_country = "<?php echo $country_code ?>";
        window.myparcel_ajax_get_address_url = "<?php echo $ajax_get_address_url ?>";
        window.myparcel_ajax_get_address_components_url = "<?php echo $ajax_get_address_components_url ?>";
        window.myparcel_ajax_get_reset_delivery_url = "<?php echo $ajax_get_address_reset_delivery ?>";
        window.myparcel_ajax_get_address_from_session_url = "<?php echo $ajax_get_address_from_session ?>";
        window.myparcel_ajax_get_total_details_url = "<?php echo $ajax_get_total_details ?>";
        window.myparcel_ajax_set_session = "<?php echo $myparcel_ajax_set_session ?>";
        window.myparcel_ajax_get_delivery_iframe_content = "<?php echo $myparcel_ajax_get_delivery_iframe_content ?>";
        window.myparcel_loading_icon = "<?php echo $ajax_get_loading_icon ?>";
        window.entry_loading = "<?php echo MyParcel()->lang->get('entry_loading') . '...' ?>";
    });
</script>
