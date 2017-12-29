<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>


    <div class="box">
        <?php $myparcel->notice->print_notices(); ?>
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
        <div class="content">
            <div id="tabs" class="htabs">
                <a href="#tab-general" ><?php echo $entry_tab_general_title; ?></a>
                <a href="#tab-default-export" ><?php echo $entry_tab_export_title; ?></a>
                <a href="#tab-checkout" ><?php echo $entry_tab_checkout_title; ?></a>
            </div>

            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div id="tab-general">
                    <h2><?php echo $entry_tab_1_api_setting; ?></h2>

                    <table class="form">
                        <tr>
                            <td><?php echo $entry_tab_1_api; ?></td>
                            <td><input type="text" name="myparcelnl_fields_general[api]" value="<?php echo isset($myparcelnl_fields_general['api'])?$myparcelnl_fields_general['api']:''; ?>" class="form-control"/>
                                <?php if (isset($error['api'])) { ?>
                                    <span class="error"><?php echo $error['api']; ?></span>
                                <?php } ?>
                            </td>
                        </tr>

                    </table>
                    <h2><?php echo $entry_tab_1_generel_setting; ?></h2>

                    <table class="form">

                        <tr>
                            <td><?php echo $entry_tab_1_label_display; ?></td>
                            <td>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="myparcelnl_fields_general[pdf]" value="1" <?php echo (isset($myparcelnl_fields_general['pdf']) && $myparcelnl_fields_general['pdf']==1) ? "checked" : "";?>> <?php echo $entry_tab_1_radio_download_pdf; ?>
                                    </label>
                                </div>
                                <div class="radio">
                                  <label><input type="radio" name="myparcelnl_fields_general[pdf]" value="0" <?php echo ( (isset($myparcelnl_fields_general['pdf']) && $myparcelnl_fields_general['pdf']==0) || !isset($myparcelnl_fields_general['pdf']) ) ? "checked" : "";?>> <?php echo $entry_tab_1_radio_open_pdf; ?></label>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_tab_1_trackandtrace_email; ?></td>
                            <td>
                                <div class="checkbox">
                                <label>

                                    <?php 
                                        $checked = (isset($myparcelnl_fields_general['trackandtrace_email']) && ($myparcelnl_fields_general['trackandtrace_email']==1))?'checked="checked"':'';
                                    ?>
                                    <input type="hidden" name="myparcelnl_fields_general[trackandtrace_email]" value="0" />
                                    <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[trackandtrace_email]"> <?php echo $entry_tab_1_checkbox_trackandtrace_email; ?>
                                    
                                </label> 
                            </div>
                            </td>
                        </tr>

                        <tr>
                            <td><?php echo $entry_tab_1_add_trackandtrace_account; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_general['trackandtrace_myaccount']) && ($myparcelnl_fields_general['trackandtrace_myaccount']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_general[trackandtrace_myaccount]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[trackandtrace_myaccount]"> <?php echo $entry_tab_1_checkbox_trackandtrace_myaccount; ?>
                                    </label> 
                                </div>  
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_1_show_shipment_directly; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>

                                        <?php 
                                            $checked = (isset($myparcelnl_fields_general['shipment_directly']) && ($myparcelnl_fields_general['shipment_directly']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_general[shipment_directly]" value="0" />
                                        <input <?php echo $checked; ?> value="1" type="checkbox" name="myparcelnl_fields_general[shipment_directly]"> <?php echo $entry_tab_1_checkbox_shipment_directly; ?>
                                    </label> 
                                </div>  
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_1_order_status_automation; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_general['order_status_automation']) && ($myparcelnl_fields_general['order_status_automation']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_general[order_status_automation]" value="0" />
                                        <input id="enable_order_status_automation" <?php echo $checked; ?> value="1" type="checkbox"  name="myparcelnl_fields_general[order_status_automation]" > <?php echo $entry_tab_1_checkbox_order_status_automation; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr id="automatic_order_status_wrapper" <?php echo ((isset($myparcelnl_fields_general['order_status_automation']) && ($myparcelnl_fields_general['order_status_automation']==1)) ? '' : 'style="display:none;"') ?>>
                            <td><?php echo $entry_tab_1_automatic_order_status; ?></td>
                            <td>
                                <select class="selectpicker" style="padding:2px;height: 28px;" name="myparcelnl_fields_general[automatic_order_status]">
                                    <?php foreach ($order_status as $status) : ?>
                                    <?php
                                        $selected = (isset($myparcelnl_fields_general['automatic_order_status']) && ($status['order_status_id']==$myparcelnl_fields_general['automatic_order_status']))?'selected="selected"' : '';
                                    ?>
                                    <option <?php echo $selected ?> value="<?php echo $status['order_status_id']; ?>"><?php echo $status["name"]; ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_1_keep_old_shipments; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_general['keep_old_shipments']) && ($myparcelnl_fields_general['keep_old_shipments']==1))?'checked="checked"':'';
                                        ?>

                                        <input type="hidden" name="myparcelnl_fields_general[keep_old_shipments]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[keep_old_shipments]" <?php echo (isset($myparcelnl_fields_general['keep_old_shipments'])&& ($myparcelnl_fields_general['keep_old_shipments']==1))?'checked="checked"':""; ?>> <?php echo $entry_tab_1_checkbox_keep_old_shipments; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                    </table>
                    <h2><?php echo $entry_tab_1_diagnostic_tools; ?></h2>
                    <table class="form">
                        <tr>
                            <td><?php echo $entry_tab_1_log_api_communication; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_general['log_api_communication']) && ($myparcelnl_fields_general['log_api_communication']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_general[log_api_communication]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[log_api_communication]" > <?php echo $entry_tab_1_checkbox_log_api_communication; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <?php if ((1==0) && is_file(MyParcel()->getLogsDir())) : ?>
                                    <a href="<?php echo MyParcel()->getLogsUrl() ?>" target="_blank"><?php echo $entry_tab_1_download_log_file ?></a>
                                <?php else : ?>
                                    No logs generated
                                <?php endif; ?>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="tab-default-export">
                    <h2><?php echo $entry_tab_2_title_export_settings; ?></h2>
                    <table class="form">
                        <tr>
                            <td><?php echo $entry_tab_2_title_package_types; ?></td>
                            <td>
                                <table class="table_shipping_methods_package_types">
                                    <?php foreach ($package_types as $package_code => $package_label) : ?>
                                        <tr>
                                            <td>
                                                <?php echo $package_label ?>
                                            </td>
                                            <td style="min-width: 200px;">
                                                <?php if ($package_code == 1) : ?>
                                                    <label><?php echo 'MyParcel Shipping' ?></label>
                                                <?php else : ?>
                                                    <select multiple="multiple" name="myparcelnl_fields_export[shipping_methods_package_types][<?php echo $package_code ?>][]" class="form-control shipping_methods_package_types" style="width:100%;">
                                                        <?php foreach ($shipping_methods as $shipping_method) : ?>
                                                        <?php $selected = (isset($myparcelnl_fields_export['shipping_methods_package_types'][$package_code]) && in_array($shipping_method['code'], $myparcelnl_fields_export['shipping_methods_package_types'][$package_code]) ? 'selected="selected"' : '' ) ?>
                                                        <option <?php echo $selected ?> value="<?php echo $shipping_method['code'] ?>"><?php echo $shipping_method['name'] ?></option>
                                                        <?php endforeach; ?>
                                                    </select>
                                                <?php endif; ?>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>

                                </table>

                                <?php echo $entry_tab_2_select_package_types; ?>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_connect_customer_email; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['connect_customer_email']) && ($myparcelnl_fields_export['connect_customer_email']==1))?'checked="checked"':'';
                                        ?>

                                        <input type="hidden" name="myparcelnl_fields_export[connect_customer_email]" value="0" />
                                        <input <?php echo $checked; ?>  type="checkbox" value="1" name="myparcelnl_fields_export[connect_customer_email]" > <?php echo $entry_tab_2_checkbox_connect_customer_email; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_connect_customer_phone; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['connect_customer_phone']) && ($myparcelnl_fields_export['connect_customer_phone']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[connect_customer_phone]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[connect_customer_phone]" > <?php echo $entry_tab_2_checkbox_connect_customer_phone; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_extra_large_size; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['extra_large_size']) && ($myparcelnl_fields_export['extra_large_size']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[extra_large_size]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[extra_large_size]" > <?php echo $entry_tab_2_checkbox_extra_large_size; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_address_only; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['address_only']) && ($myparcelnl_fields_export['address_only']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[address_only]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[address_only]" > <?php echo $entry_tab_2_checkbox_address_only; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_signature_delivery; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['signature_delivery']) && ($myparcelnl_fields_export['signature_delivery']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[signature_delivery]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[signature_delivery]" > <?php echo $entry_tab_2_checkbox_signature_delivery; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_return_no_answer; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['return_no_answer']) && ($myparcelnl_fields_export['return_no_answer']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[return_no_answer]" value="0" />
                                        <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[return_no_answer]" > <?php echo $entry_tab_2_checkbox_return_no_answer; ?>
                                    </label> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_insured_shipment; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_export['insured']) && ($myparcelnl_fields_export['insured']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_export[insured]" value="0" />
                                        <input id="checkbox_insured" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[insured]" > <?php echo $entry_tab_2_checkbox_insured_shipment; ?>
                                    </label> 
                                </div>

                                <div style="margin-left: 20px;" id="div_checkbox_insured" class="<?php echo (isset($myparcelnl_fields_export['insured']) && ($myparcelnl_fields_export['insured']==1))?'show':'hidden';?>">
                                    <div class="form-group">
                                        <label class="text-left col-sm-3 control-label" for="input-title" ><?php echo $entry_tab_2_title_insured_amount; ?></label>
                                        <div class="col-sm-9 col-md-4 col-lg-4">
                                            <select id="select_insured_amount" name="myparcelnl_fields_export[insured_amount_selectbox]" class="form-control" style="width:30%;">
                                                <?php foreach ($insured_amounts as $key => $insured_amount) : ?>
                                                <?php $selected = (isset($myparcelnl_fields_export['insured_amount_selectbox']) && ($key == $myparcelnl_fields_export['insured_amount_selectbox']) ? 'selected="selected"' : '' ) ?>
                                                <option <?php echo $selected ?> value="<?php echo $key; ?>"><?php echo $insured_amount; ?></option>
                                                <?php endforeach; ?>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group <?php echo empty($myparcelnl_fields_export['insured_amount_selectbox'])?'show':'hidden'; ?>" id="input_insured_amount_custom">
                                        <label class="text-left col-sm-3 control-label" for="input-title" ><?php echo $entry_tab_2_title_insured_amount_custom; ?></label>
                                        <div class="col-sm-9 col-md-4 col-lg-4">
                                            <input id="insured_amount_custom" name="myparcelnl_fields_export[insured_amount_custom]" value="<?php echo isset($myparcelnl_fields_export['insured_amount_custom'])?$myparcelnl_fields_export['insured_amount_custom']:''; ?>" size="5" placeholder="" class="insured_amount" style="" type="text">
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td><?php echo $entry_tab_2_title_label_description; ?></td>
                            <td>
                                <input type="text" name="myparcelnl_fields_export[label_description]" value="<?php echo isset($myparcelnl_fields_export['label_description'])?$myparcelnl_fields_export['label_description']:''; ?>" class="form-control"/>
                                <p><?php echo $entry_tab_2_textbox_label_description; ?></p>
                                
                            </td>
                        </tr>
                        <!--<tr>
                            <td><?php echo $entry_tab_2_title_empty_parcel_weight; ?></td>
                            <td>
                                <input type="text" name="myparcelnl_fields_export[empty_parcel_weight]" value="<?php echo isset($myparcelnl_fields_export['empty_parcel_weight'])?$myparcelnl_fields_export['empty_parcel_weight']:''; ?>" class="form-control"/>
                                <?php echo $entry_tab_2_textbox_empty_parcel_weight; ?>
                            </td>
                        </tr>-->
                    </table>
                </div>
                <div id="tab-checkout">
                    <h2><?php echo $entry_tab_3_title_delivery_option; ?></h2>

                    <table class="form">
                        <tr>
                            <td><?php echo $entry_tab_3_label_enable_delivery; ?></td>
                            <td>
                                <div class="checkbox">
                                    <label>
                                        <?php 
                                            $checked = (isset($myparcelnl_fields_checkout['enable_delivery']) && ($myparcelnl_fields_checkout['enable_delivery']==1))?'checked="checked"':'';
                                        ?>
                                        <input type="hidden" name="myparcelnl_fields_checkout[enable_delivery]" value="0" />
                                        <input id="enable_delivery" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[enable_delivery]" />
                                    </label> 

                                </div>
                            </td>
                        </tr>
                    </table>

                    <div id="settings_delivery" class="<?php echo (isset($myparcelnl_fields_checkout['enable_delivery']) && ($myparcelnl_fields_checkout['enable_delivery']==1))?'show':'hidden';?>">
                        <table class="form">
                            <tr>
                                <td><?php echo $entry_tab_3_label_home_address_only; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['only_recipient_enabled']) && ($myparcelnl_fields_checkout['only_recipient_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[only_recipient_enabled]" value="0" />
                                            <input id="checkbox_home_address_only" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[only_recipient_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_home_address_only" class="<?php echo (isset($myparcelnl_fields_checkout['only_recipient_enabled']) && ($myparcelnl_fields_checkout['only_recipient_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="text" name="myparcelnl_fields_checkout[only_recipient_fee]" value="<?php echo isset($myparcelnl_fields_checkout['only_recipient_fee'])?$myparcelnl_fields_checkout['only_recipient_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_signature_on_delivery; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['signed_enabled']) && ($myparcelnl_fields_checkout['signed_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[signed_enabled]" value="0" />
                                            <input id="checkbox_signature_on_delivery" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[signed_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_signature_on_delivery" class="<?php echo (isset($myparcelnl_fields_checkout['signed_enabled']) && ($myparcelnl_fields_checkout['signed_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="" name="myparcelnl_fields_checkout[signed_fee]" value="<?php echo isset($myparcelnl_fields_checkout['signed_fee'])?$myparcelnl_fields_checkout['signed_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_evening_delivery; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['night_enabled']) && ($myparcelnl_fields_checkout['night_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[night_enabled]" value="0" />
                                            <input id="checkbox_evening_delivery" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[night_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_evening_delivery" class="<?php echo (isset($myparcelnl_fields_checkout['night_enabled']) && ($myparcelnl_fields_checkout['night_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="" name="myparcelnl_fields_checkout[night_fee]" value="<?php echo isset($myparcelnl_fields_checkout['night_fee'])?$myparcelnl_fields_checkout['night_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_tab_3_label_morning_delivery; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['morning_enabled']) && ($myparcelnl_fields_checkout['morning_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[morning_enabled]" value="0" />
                                            <input id="checkbox_morning_delivery" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[morning_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_morning_delivery" class="<?php echo (isset($myparcelnl_fields_checkout['morning_enabled']) && ($myparcelnl_fields_checkout['morning_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="" name="myparcelnl_fields_checkout[morning_fee]" value="<?php echo isset($myparcelnl_fields_checkout['morning_fee'])?$myparcelnl_fields_checkout['morning_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_tab_3_label_postnl_pickup; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['pickup_enabled']) && ($myparcelnl_fields_checkout['pickup_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[pickup_enabled]" value="0" />
                                            <input id="checkbox_postnl_pickup" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[pickup_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_postnl_pickup" class="<?php echo (isset($myparcelnl_fields_checkout['pickup_enabled']) && ($myparcelnl_fields_checkout['pickup_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="" name="myparcelnl_fields_checkout[pickup_fee]" value="<?php echo isset($myparcelnl_fields_checkout['pickup_fee'])?$myparcelnl_fields_checkout['pickup_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td><?php echo $entry_tab_3_label_early_postnl_pickup; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php 
                                                $checked = (isset($myparcelnl_fields_checkout['pickup_express_enabled']) && ($myparcelnl_fields_checkout['pickup_express_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[pickup_express_enabled]" value="0" />
                                            <input id="checkbox_early_postnl_pickup" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[pickup_express_enabled]" />
                                        </label> 

                                    </div>
                                    <table id="table_early_postnl_pickup" class="<?php echo (isset($myparcelnl_fields_checkout['pickup_express_enabled']) && ($myparcelnl_fields_checkout['pickup_express_enabled']==1))?'show':'hidden';?>">
                                        <tr> 
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                            <td>&euro; <input type="" name="myparcelnl_fields_checkout[pickup_express_fee]" value="<?php echo isset($myparcelnl_fields_checkout['pickup_express_fee'])?$myparcelnl_fields_checkout['pickup_express_fee']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <!-- MAILBOX SETTINGS -->
                            <tr>
                                <td><?php echo $entry_tab_3_label_mailbox_settings; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php
                                                $checked = (isset($myparcelnl_fields_checkout['mailbox_enabled']) && ($myparcelnl_fields_checkout['mailbox_enabled']==1))?'checked="checked"':'';
                                            ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[mailbox_enabled]" value="0" />
                                            <input id="checkbox_mailbox_enabled" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[mailbox_enabled]" />
                                        </label>

                                    </div>
                                    <table id="table_mailbox" class="<?php echo (isset($myparcelnl_fields_checkout['mailbox_enabled']) && ($myparcelnl_fields_checkout['mailbox_enabled']==1))?'show':'hidden';?>">
                                        <tr>
                                            <td><?php echo $entry_tab_3_label_mailbox_title; ?>:</td>
                                            <td><input type="" name="myparcelnl_fields_checkout[mailbox_title]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_title'])?$myparcelnl_fields_checkout['mailbox_title']:''; ?>"></td>
                                        </tr>
                                        <tr>
                                            <td><?php echo $entry_tab_3_label_additional_fee; ?> (&euro;):</td>
                                            <td><input type="" name="myparcelnl_fields_checkout[mailbox_fee]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_fee'])?$myparcelnl_fields_checkout['mailbox_fee']:''; ?>"></td>
                                        </tr>
                                        <tr>
                                            <td><?php echo $entry_tab_3_label_mailbox_accept_weight; ?> (kg):</td>
                                            <td><input type="" name="myparcelnl_fields_checkout[mailbox_weight]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_weight'])?$myparcelnl_fields_checkout['mailbox_weight']:''; ?>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- END  MAILBOX SETTINGS -->
                        </table>
                        <h2><?php echo $entry_tab_3_title_shipment_processing_parameters; ?></h2>
                        <table class="form">
                            <tr>
                                <td><?php echo $entry_tab_3_label_dropoff_days; ?></td>
                                <td>
                                    <select multiple="multiple" name="myparcelnl_fields_checkout[dropoff_days][]" class="form-control dropoff_days" style="width:100%;">
                                        <?php foreach ($days_of_the_week as $weekday_digit => $day) : ?>
                                        <?php $selected = (isset($myparcelnl_fields_checkout['dropoff_days']) && in_array($weekday_digit, $myparcelnl_fields_checkout['dropoff_days']) ? 'selected="selected"' : '' ) ?>
                                        <option <?php echo $selected ?> value="<?php echo $weekday_digit; ?>"><?php echo $day; ?></option>
                                        <?php endforeach; ?>
                                    </select>
                                    <?php echo $entry_tab_3_select_dropoff_days; ?>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_cut_off_time; ?></td>
                                <td>
                                    <input type="text" name="myparcelnl_fields_checkout[cut_off_time]" value="<?php echo isset($myparcelnl_fields_checkout['cut_off_time'])?$myparcelnl_fields_checkout['cut_off_time']:''; ?>" class="form-control"/>
                                    <?php echo $entry_tab_3_textbox_cut_off_time; ?>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_dropoff_delay; ?></td>
                                <td>
                                    <input type="" name="myparcelnl_fields_checkout[dropoff_delay]" value="<?php echo !empty($myparcelnl_fields_checkout['dropoff_delay'])?$myparcelnl_fields_checkout['dropoff_delay']:''; ?>" class="form-control"/>
                                    <?php echo $entry_tab_3_textbox_dropoff_delay; ?>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_delivery_days_window; ?></td>
                                <td>
                                    <input type="" name="myparcelnl_fields_checkout[delivery_days_window]" value="<?php echo !empty($myparcelnl_fields_checkout['delivery_days_window'])?$myparcelnl_fields_checkout['delivery_days_window']:''; ?>" class="form-control"/>
                                    <?php echo $entry_tab_3_textbox_delivery_days_window; ?>
                                </td>
                            </tr>
                        </table>

                        <!-- CUSTOMIZATIONS -->
                        <h2><?php echo $entry_tab_3_title_customizations; ?></h2>
                        <table class="form">
                            <tr>
                                <td><?php echo $entry_tab_3_label_base_color; ?></td>
                                <td>
                                    <div class="color-selector-custom-widget">
                                        <div id="color-selector-base" class="color-picker-field"><div style="<?php echo (!empty($myparcelnl_fields_checkout['base_color'])? 'background-color: #' . $myparcelnl_fields_checkout['base_color'] : 'background-color: #01bbc5') ?>"></div></div>
                                        <div id="color-selector-holder-base" class="color-picker-holder">
                                        </div>
                                    </div>
                                    <input type="hidden" id="color-picker-input-base" name="myparcelnl_fields_checkout[base_color]" value="<?php echo (!empty($myparcelnl_fields_checkout['base_color'])?$myparcelnl_fields_checkout['base_color'] : '01bbc5') ?>" class=" " />
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_highlight_color; ?></td>
                                <td>
                                    <div class="color-selector-custom-widget">
                                        <div id="color-selector-highlight" class="color-picker-field"><div style="<?php echo (!empty($myparcelnl_fields_checkout['highlight_color'])? 'background-color: #' . $myparcelnl_fields_checkout['highlight_color'] : 'background-color: #ff8c00') ?>"></div></div>
                                        <div id="color-selector-holder-highlight" class="color-picker-holder">
                                        </div>
                                    </div>
                                    <input type="hidden" id="color-picker-input-highlight" name="myparcelnl_fields_checkout[highlight_color]" value="<?php echo (!empty($myparcelnl_fields_checkout['highlight_color'])?$myparcelnl_fields_checkout['highlight_color'] : 'ff8c00') ?>" class=" " />
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_custom_style; ?></td>
                                <td>
                                    <?php
                                        $text_custom_style = (isset($myparcelnl_fields_checkout['custom_style'])? $myparcelnl_fields_checkout['custom_style'] : '');
                                    ?>
                                    <textarea name="myparcelnl_fields_checkout[custom_style]" cols="80" rows="8"><?php echo $text_custom_style ?></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td><?php echo $entry_tab_3_label_auto_google_fronts; ?></td>
                                <td>
                                    <div class="checkbox">
                                        <label>
                                            <?php
                                                    $checked = (isset($myparcelnl_fields_checkout['auto_google_fonts']) && ($myparcelnl_fields_checkout['auto_google_fonts']==1))?'checked="checked"':'';
                                                ?>
                                            <input type="hidden" name="myparcelnl_fields_checkout[auto_google_fonts]" value="0" />
                                            <input id="checkout_auto_google_fronts" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[auto_google_fonts]" />
                                        </label>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<?php echo $footer; ?>

<script type="text/javascript">
    $('#tabs a').tabs();
</script>
<style type="text/css">
    .hidden{
        display: none;
    }
    .show{
        display: block;
    }
    .alert-warning{
        color: red;
    }
</style>