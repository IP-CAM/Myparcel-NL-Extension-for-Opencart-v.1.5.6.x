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
        <div class="heading">
            <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <h3>Settings</h3>
                <table class="form">
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="myparcel_module_username" value="<?php echo $myparcel_module_username; ?>" /></td>
                    </tr>
                    <tr>
                        <td>API key:</td>
                        <td><input type="text" name="myparcel_module_api_key" value="<?php echo $myparcel_module_api_key; ?>" /></td>
                    </tr>
                    <tr>
                        <td>Frontend plugin:</td>
                        <td>
                            <input type="hidden" name="myparcel_module_frontend" value="0" />
                            <input type="checkbox" name="myparcel_module_frontend" value="1" <?php echo ($myparcel_module_frontend == 1 ? ' checked="checked"' : ''); ?> />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<?php echo $footer; ?>