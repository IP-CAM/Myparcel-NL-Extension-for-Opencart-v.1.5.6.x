<?php
require_once DIR_SYSTEM . 'myparcelnl/class_myparcel.php';

class ModelMyparcelnlHelper extends Model
{
    function getContent($template_name, $params = array(), $echo = false)
    {
        $content = call_user_func_array( array( MyParcel($this->registry)->view, $template_name ), $params );

        if ($echo) {
            echo $content;
        } else {
            return $content;
        }
    }

    function initMyParcel()
    {
        MyParcel($this->registry);
    }

    function getCssUrl()
    {
        return MyParcel($this->registry)->getCssUrl();
    }

    function getJsUrl()
    {
        return MyParcel($this->registry)->getJsUrl();
    }

    function addCompatibleScript($script_name, $document)
    {
        return MyParcel($this->registry)->addCompatibleScript($script_name, $document);
    }

    function saveDeliveryOptionsInCheckout()
    {
        return MyParcel($this->registry)->shipment->shipment_helper->saveDeliveryOptionsInCheckout($this->request->post);
    }

    function addDeliveryDataIntoOrder($order_info)
    {
        return MyParcel($this->registry)->shipment->checkout->addDeliveryDataIntoOrder($order_info);
    }
}