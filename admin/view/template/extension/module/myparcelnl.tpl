<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>"
                        class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } else { ?>
            <?php $myparcel->notice->print_notices(); ?>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
                    <div class="tab-pane">
                        <ul class="nav nav-tabs" id="ul-tab-pane">
                            <li><a href="#tab-general" data-toggle="tab"><?php echo $entry_tab_1_title; ?></a></li>
                            <li><a href="#tab-default-export" data-toggle="tab"><?php echo $entry_tab_2_title; ?></a></li>
                            <li><a href="#tab-checkout" data-toggle="tab"><?php echo $entry_tab_3_title; ?></a></li>
                        </ul>
                        <div class="tab-content">

                            <!-- _______________________ CONTENT OF GENERAL SETTINGS _______________________ -->
                            <!-- ___________________________________________________________________________ -->


                            <div class="tab-pane" id="tab-general">
                                <h2><?php echo $entry_tab_1_api_setting; ?></h2>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_api; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <input type="text" name="myparcelnl_fields_general[api]" value="<?php echo isset($myparcelnl_fields_general['api'])?$myparcelnl_fields_general['api']:''; ?>" class="form-control"/>
                                    </div>
                                </div>


                                <h2><?php echo $entry_tab_1_generel_setting; ?></h2>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_label_display; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="myparcelnl_fields_general[pdf]" value="1" <?php echo (isset($myparcelnl_fields_general['pdf']) && $myparcelnl_fields_general['pdf']==1) ? "checked" : "";?>> <?php echo $entry_tab_1_radio_download_pdf; ?>
                                            </label>
                                        </div>
                                        <div class="radio">
                                          <label><input type="radio" name="myparcelnl_fields_general[pdf]" value="0" <?php echo ( (isset($myparcelnl_fields_general['pdf']) && $myparcelnl_fields_general['pdf']==0) || !isset($myparcelnl_fields_general['pdf']) ) ? "checked" : "";?>> <?php echo $entry_tab_1_radio_open_pdf; ?></label>
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_trackandtrace_email; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>

                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['trackandtrace_email']) && ($myparcelnl_fields_general['trackandtrace_email']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_general[trackandtrace_email]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[trackandtrace_email]"> <?php echo $entry_tab_1_checkbox_trackandtrace_email; ?>
                                                
                                            </label> 
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_add_trackandtrace_account; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['trackandtrace_myaccount']) && ($myparcelnl_fields_general['trackandtrace_myaccount']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_general[trackandtrace_myaccount]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[trackandtrace_myaccount]"> <?php echo $entry_tab_1_checkbox_trackandtrace_myaccount; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_show_shipment_directly; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>

                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['shipment_directly']) && ($myparcelnl_fields_general['shipment_directly']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_general[shipment_directly]" value="0" />
                                                <input <?php echo $checked; ?> value="1" type="checkbox" name="myparcelnl_fields_general[shipment_directly]"> <?php echo $entry_tab_1_checkbox_shipment_directly; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_order_status_automation; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['order_status_automation']) && ($myparcelnl_fields_general['order_status_automation']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_general[order_status_automation]" value="0" />
                                                <input <?php echo $checked; ?> id="enable_order_status_automation" value="1" type="checkbox"  name="myparcelnl_fields_general[order_status_automation]" > <?php echo $entry_tab_1_checkbox_order_status_automation; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group" id="automatic_order_status_wrapper" <?php echo ((isset($myparcelnl_fields_general['order_status_automation']) && ($myparcelnl_fields_general['order_status_automation']==1)) ? '' : 'style="display:none;"') ?>>
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_automatic_order_status; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <select class="selectpicker" style="padding:2px;height: 28px;" name="myparcelnl_fields_general[automatic_order_status]">
                                            <?php foreach ($order_status as $status) : ?>
                                            <?php
                                                $selected = (isset($myparcelnl_fields_general['automatic_order_status']) && ($status['order_status_id']==$myparcelnl_fields_general['automatic_order_status']))?'selected="selected"' : '';
                                            ?>
                                            <option <?php echo $selected ?> value="<?php echo $status['order_status_id']; ?>"><?php echo $status["name"]; ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>        
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_keep_old_shipments; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['keep_old_shipments']) && ($myparcelnl_fields_general['keep_old_shipments']==1))?'checked="checked"':'';
                                                ?>

                                                <input type="hidden" name="myparcelnl_fields_general[keep_old_shipments]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[keep_old_shipments]" <?php echo (isset($myparcelnl_fields_general['keep_old_shipments'])&& ($myparcelnl_fields_general['keep_old_shipments']==1))?'checked="checked"':""; ?>> <?php echo $entry_tab_1_checkbox_keep_old_shipments; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <h2><?php echo $entry_tab_1_diagnostic_tools; ?></h2>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_1_log_api_communication; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_general['log_api_communication']) && ($myparcelnl_fields_general['log_api_communication']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_general[log_api_communication]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_general[log_api_communication]" > <?php echo $entry_tab_1_checkbox_log_api_communication; ?>
                                            </label> 

                                        </div>
                                        <?php if (is_file(MyParcel()->getLogsDir())) : ?>
                                            <a href="<?php echo MyParcel()->getLogsUrl() ?>" target="_blank"><?php echo $entry_tab_1_download_log_file ?></a>
                                        <?php else : ?>
                                            No logs generated
                                        <?php endif; ?>
                                    </div>
                                </div>
                            </div>
                            <!-- _______________________ CONTENT OF DEFAULT EXPORT SETTINGS _______________________ -->
                            <!-- __________________________________________________________________________________ -->

                            <div class="tab-pane" id="tab-default-export">
                                <h2><?php echo $entry_tab_2_title_export_settings; ?></h2>
                                <div class="form-group" >
                                    <label class="col-sm-2 control-label" for="input-title"><?php echo $entry_tab_2_title_package_types; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
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
                                                            <select <?php echo (($package_code == 1) ? '' : 'multiple="multiple"') ?> name="myparcelnl_fields_export[shipping_methods_package_types][<?php echo $package_code ?>][]" class="form-control shipping_methods_package_types" style="width:100%;">
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
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_connect_customer_email; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['connect_customer_email']) && ($myparcelnl_fields_export['connect_customer_email']==1))?'checked="checked"':'';
                                                ?>

                                                <input type="hidden" name="myparcelnl_fields_export[connect_customer_email]" value="0" />
                                                <input <?php echo $checked; ?>  type="checkbox" value="1" name="myparcelnl_fields_export[connect_customer_email]" > <?php echo $entry_tab_2_checkbox_connect_customer_email; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_connect_customer_phone; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['connect_customer_phone']) && ($myparcelnl_fields_export['connect_customer_phone']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[connect_customer_phone]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[connect_customer_phone]" > <?php echo $entry_tab_2_checkbox_connect_customer_phone; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_extra_large_size; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['extra_large_size']) && ($myparcelnl_fields_export['extra_large_size']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[extra_large_size]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[extra_large_size]" > <?php echo $entry_tab_2_checkbox_extra_large_size; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_address_only; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['address_only']) && ($myparcelnl_fields_export['address_only']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[address_only]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[address_only]" > <?php echo $entry_tab_2_checkbox_address_only; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_signature_delivery; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['signature_delivery']) && ($myparcelnl_fields_export['signature_delivery']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[signature_delivery]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[signature_delivery]" > <?php echo $entry_tab_2_checkbox_signature_delivery; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_return_no_answer; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['return_no_answer']) && ($myparcelnl_fields_export['return_no_answer']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[return_no_answer]" value="0" />
                                                <input <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[return_no_answer]" > <?php echo $entry_tab_2_checkbox_return_no_answer; ?>
                                            </label> 
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_insured_shipment; ?></label>

                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_export['insured']) && ($myparcelnl_fields_export['insured']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_export[insured]" value="0" />
                                                <input id="checkbox_insured" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_export[insured]" > <?php echo $entry_tab_2_checkbox_insured_shipment; ?>
                                            </label> 
                                        </div>

                                        <div id="div_checkbox_insured" class="<?php echo (isset($myparcelnl_fields_export['insured']) && ($myparcelnl_fields_export['insured']==1))?'show':'hidden';?>">
                                            <div class="form-group">
                                                <label class="text-left col-sm-3 control-label" for="input-title" ><?php echo $entry_tab_2_title_insured_amount; ?></label>
                                                <div class="col-sm-9 col-md-4 col-lg-4">
                                                    <select id="select_insured_amount" name="myparcelnl_fields_export[insured_amount_selectbox]" class="form-control" style="width:100%;">
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
                                        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_label_description; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <input type="text" name="myparcelnl_fields_export[label_description]" value="<?php echo isset($myparcelnl_fields_export['label_description'])?$myparcelnl_fields_export['label_description']:''; ?>" class="form-control"/>
                                        <?php echo $entry_tab_2_textbox_label_description; ?>
                                    </div>
                                </div>


                               <!-- <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_2_title_empty_parcel_weight; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <input type="text" name="myparcelnl_fields_export[empty_parcel_weight]" value="<?php echo isset($myparcelnl_fields_export['empty_parcel_weight'])?$myparcelnl_fields_export['empty_parcel_weight']:''; ?>" class="form-control"/>
                                        <?php echo $entry_tab_2_textbox_empty_parcel_weight; ?>
                                    </div>
                                </div> -->
                            </div>

                            <!-- _______________________ CONTENT OF CHECKOUT _______________________ -->
                            <!-- ___________________________________________________________________ -->
                            <div class="tab-pane" id="tab-checkout">
                                <h2><?php echo $entry_tab_3_title_delivery_option; ?></h2>

                                <div class="form-group">
                                    <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_enable_delivery; ?></label>
                                    <div class="col-sm-10 col-md-6 col-lg-6">
                                        <div class="checkbox">
                                            <label>
                                                <?php 
                                                    $checked = (isset($myparcelnl_fields_checkout['enable_delivery']) && ($myparcelnl_fields_checkout['enable_delivery']==1))?'checked="checked"':'';
                                                ?>
                                                <input type="hidden" name="myparcelnl_fields_checkout[enable_delivery]" value="0" />
                                                <input id="enable_delivery" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[enable_delivery]" />
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div id="settings_delivery" class="<?php echo (isset($myparcelnl_fields_checkout['enable_delivery']) && ($myparcelnl_fields_checkout['enable_delivery']==1))?'show':'hidden';?>">

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_home_address_only; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <div class="checkbox">
                                                <label>
                                                    <?php 
                                                        $checked = (isset($myparcelnl_fields_checkout['only_recipient_enabled']) && ($myparcelnl_fields_checkout['only_recipient_enabled']==1))?'checked="checked"':'';
                                                    ?>
                                                    <input type="hidden" name="myparcelnl_fields_checkout[only_recipient_enabled]" value="0" />
                                                    <input id="checkbox_home_address_only" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[only_recipient_enabled]" />
                                                </label> 

                                            </div>
                                            <table id="table_home_address_only" class="v-center <?php echo (isset($myparcelnl_fields_checkout['only_recipient_enabled']) && ($myparcelnl_fields_checkout['only_recipient_enabled']==1))?'show':'hidden';?>">
                                                <tr> 
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[only_recipient_fee]" value="<?php echo isset($myparcelnl_fields_checkout['only_recipient_fee'])?$myparcelnl_fields_checkout['only_recipient_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_signature_on_delivery; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <div class="checkbox">
                                                <label>
                                                    <?php 
                                                        $checked = (isset($myparcelnl_fields_checkout['signed_enabled']) && ($myparcelnl_fields_checkout['signed_enabled']==1))?'checked="checked"':'';
                                                    ?>
                                                    <input type="hidden" name="myparcelnl_fields_checkout[signed_enabled]" value="0" />
                                                    <input id="checkbox_signature_on_delivery" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[signed_enabled]" />
                                                </label> 

                                            </div>
                                            <table id="table_signature_on_delivery" class="v-center <?php echo (isset($myparcelnl_fields_checkout['signed_enabled']) && ($myparcelnl_fields_checkout['signed_enabled']==1))?'show':'hidden';?>">
                                                <tr> 
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[signed_fee]" value="<?php echo isset($myparcelnl_fields_checkout['signed_fee'])?$myparcelnl_fields_checkout['signed_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_evening_delivery; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <div class="checkbox">
                                                <label>
                                                    <?php 
                                                        $checked = (isset($myparcelnl_fields_checkout['night_enabled']) && ($myparcelnl_fields_checkout['night_enabled']==1))?'checked="checked"':'';
                                                    ?>
                                                    <input type="hidden" name="myparcelnl_fields_checkout[night_enabled]" value="0" />
                                                    <input id="checkbox_evening_delivery" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[night_enabled]" />
                                                </label> 

                                            </div>
                                            <table id="table_evening_delivery" class="v-center <?php echo (isset($myparcelnl_fields_checkout['night_enabled']) && ($myparcelnl_fields_checkout['night_enabled']==1))?'show':'hidden';?>">
                                                <tr> 
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[night_fee]" value="<?php echo isset($myparcelnl_fields_checkout['night_fee'])?$myparcelnl_fields_checkout['night_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_morning_delivery; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
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
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[morning_fee]" value="<?php echo isset($myparcelnl_fields_checkout['morning_fee'])?$myparcelnl_fields_checkout['morning_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>


                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_postnl_pickup; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
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
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[pickup_fee]" value="<?php echo isset($myparcelnl_fields_checkout['pickup_fee'])?$myparcelnl_fields_checkout['pickup_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_early_postnl_pickup; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
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
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>: </td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[pickup_express_fee]" value="<?php echo isset($myparcelnl_fields_checkout['pickup_express_fee'])?$myparcelnl_fields_checkout['pickup_express_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- MAILBOX SETTINGS -->
                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_mailbox_settings; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <div class="checkbox">
                                                <label>
                                                    <?php
                                                        $checked = (isset($myparcelnl_fields_checkout['mailbox_enabled']) && ($myparcelnl_fields_checkout['mailbox_enabled']==1))?'checked="checked"':'';
                                                    ?>
                                                    <input type="hidden" name="myparcelnl_fields_checkout[mailbox_enabled]" value="0" />
                                                    <input id="checkbox_mailbox" class="checkbox_delivery_options" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[mailbox_enabled]" />
                                                </label>

                                            </div>
                                            <table id="table_mailbox" class="<?php echo (isset($myparcelnl_fields_checkout['mailbox_enabled']) && ($myparcelnl_fields_checkout['mailbox_enabled']==1))?'show':'hidden';?>">
                                                <tr>
                                                    <td><?php echo $entry_tab_3_label_mailbox_title; ?>:</td>
                                                    <td>
                                                        <input class="form-control" type="text" name="myparcelnl_fields_checkout[mailbox_title]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_title'])?$myparcelnl_fields_checkout['mailbox_title']:''; ?>">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><?php echo $entry_tab_3_label_additional_fee; ?>:</td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">&euro;</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[mailbox_fee]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_fee'])?$myparcelnl_fields_checkout['mailbox_fee']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td><?php echo $entry_tab_3_label_mailbox_accept_weight; ?> :</td>
                                                    <td>
                                                        <div class="input-group">
                                                            <span class="input-group-addon">kg</span>
                                                            <input class="form-control" type="text" name="myparcelnl_fields_checkout[mailbox_weight]" value="<?php echo isset($myparcelnl_fields_checkout['mailbox_weight'])?$myparcelnl_fields_checkout['mailbox_weight']:''; ?>">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- END  MAILBOX SETTINGS -->

                                    <h2><?php echo $entry_tab_3_title_shipment_processing_parameters; ?></h2>
                                    
                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_dropoff_days; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <select multiple="multiple" name="myparcelnl_fields_checkout[dropoff_days][]" class="form-control dropoff_days" style="width:100%;">
                                                <?php foreach ($days_of_the_week as $weekday_digit => $day) : ?>
                                                <?php $selected = (isset($myparcelnl_fields_checkout['dropoff_days']) && in_array($weekday_digit, $myparcelnl_fields_checkout['dropoff_days']) ? 'selected="selected"' : '' ) ?>
                                                <option <?php echo $selected ?> value="<?php echo $weekday_digit; ?>"><?php echo $day; ?></option>
                                                <?php endforeach; ?>
                                            </select>
                                            <?php echo $entry_tab_3_select_dropoff_days; ?>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_cut_off_time; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <input type="text" name="myparcelnl_fields_checkout[cut_off_time]" value="<?php echo isset($myparcelnl_fields_checkout['cut_off_time'])?$myparcelnl_fields_checkout['cut_off_time']:''; ?>" class="form-control"/>
                                            <?php echo $entry_tab_3_textbox_cut_off_time; ?>
                                        </div>    
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_dropoff_delay; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <input type="" name="myparcelnl_fields_checkout[dropoff_delay]" value="<?php echo !empty($myparcelnl_fields_checkout['dropoff_delay'])?$myparcelnl_fields_checkout['dropoff_delay']:''; ?>" class="form-control"/>
                                            <?php echo $entry_tab_3_textbox_dropoff_delay; ?>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_delivery_days_window; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <input type="" name="myparcelnl_fields_checkout[delivery_days_window]" value="<?php echo (!empty($myparcelnl_fields_checkout['delivery_days_window']) || $myparcelnl_fields_checkout['delivery_days_window'] == '0')?$myparcelnl_fields_checkout['delivery_days_window']:''; ?>" class="form-control"/>
                                            <?php echo $entry_tab_3_textbox_delivery_days_window; ?>
                                        </div>
                                    </div>

                                    <h2><?php echo $entry_tab_3_title_customizations; ?></h2>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_base_color; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <div class="color-selector-custom-widget">
                                                <div id="color-selector-base" class="color-picker-field"><div style="<?php echo (!empty($myparcelnl_fields_checkout['base_color'])? 'background-color: #' . $myparcelnl_fields_checkout['base_color'] : 'background-color: #01bbc5') ?>"></div></div>
                                                <div id="color-selector-holder-base" class="color-picker-holder">
                                                </div>
                                            </div>
                                            <input type="hidden" id="color-picker-input-base" name="myparcelnl_fields_checkout[base_color]" value="<?php echo (!empty($myparcelnl_fields_checkout['base_color'])?$myparcelnl_fields_checkout['base_color'] : '01bbc5') ?>" class=" " />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_highlight_color; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-3">
                                            <div class="color-selector-custom-widget">
                                                <div id="color-selector-highlight" class="color-picker-field"><div style="<?php echo (!empty($myparcelnl_fields_checkout['highlight_color'])? 'background-color: #' . $myparcelnl_fields_checkout['highlight_color'] : 'background-color: #ff8c00') ?>"></div></div>
                                                <div id="color-selector-holder-highlight" class="color-picker-holder">
                                                </div>
                                            </div>
                                            <input type="hidden" id="color-picker-input-highlight" name="myparcelnl_fields_checkout[highlight_color]" value="<?php echo (!empty($myparcelnl_fields_checkout['highlight_color'])?$myparcelnl_fields_checkout['highlight_color'] : 'ff8c00') ?>" class=" " />
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_custom_style; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <?php
                                                $text_custom_style = (isset($myparcelnl_fields_checkout['custom_style'])? $myparcelnl_fields_checkout['custom_style'] : '');
                                            ?>
                                            <textarea name="myparcelnl_fields_checkout[custom_style]" cols="80" rows="8"><?php echo $text_custom_style ?></textarea>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="text-left col-sm-2 control-label" for="input-title" ><?php echo $entry_tab_3_label_auto_google_fronts; ?></label>
                                        <div class="col-sm-10 col-md-6 col-lg-6">
                                            <div class="checkbox">
                                                <label>
                                                    <?php
                                                    $checked = (isset($myparcelnl_fields_checkout['auto_google_fonts']) && ($myparcelnl_fields_checkout['auto_google_fonts']==1))?'checked="checked"':'';
                                                    ?>
                                                    <input type="hidden" name="myparcelnl_fields_checkout[auto_google_fonts]" value="0" />
                                                    <input id="checkout_auto_google_fronts" <?php echo $checked; ?> type="checkbox" value="1" name="myparcelnl_fields_checkout[auto_google_fonts]" />
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
    <link href="view/javascript/summernote/summernote.css" rel="stylesheet"/>
    <script type="text/javascript"><!--
        $('#ul-tab-pane a:first').tab('show');
        //-->
    </script>
</div>
<?php echo $footer; ?>