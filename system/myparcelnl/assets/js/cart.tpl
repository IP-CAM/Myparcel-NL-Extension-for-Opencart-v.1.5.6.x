<div id="cart" class="btn-group btn-block">
  <button type="button" data-toggle="dropdown" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-inverse btn-block btn-lg dropdown-toggle" style="background:none;border: 0 none;" class="btn btn-primary btn-block btn-lg dropdown-toggle btn-quick-cart">	  <span class="hidden-xs" style="display: inline-block; padding-top: 0; vertical-align: middle;font-weight: 400;margin: 0 2px 0 0;">winkelwagen</span>
			<span id="cart-total"><?php echo $text_items; ?></span>
			<i class="fa fa-shopping-cart fa-lg" style="font-size:2.9em;"></i></button>
  <ul class="dropdown-menu pull-right">
    <?php if ($products || $vouchers) { ?>
    <li class="cart-list">
      <table class="table table-striped">
        <?php foreach ($products as $product) { ?>
        <tr>
          <td class="text-center"><?php if ($product['thumb']) { ?>
            <a <?= !empty($product['product_click_event_datalayer']) ? $product['product_click_event_datalayer'] : '';?> href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
            <?php } ?></td>
          <td class="text-left"><a <?= !empty($product['product_click_event_datalayer']) ? $product['product_click_event_datalayer'] : '';?> href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
            <?php if ($product['option']) { ?>
            <?php foreach ($product['option'] as $option) { ?>
            <br />
            - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
            <?php } ?>
            <?php } ?>

				<?php if ($product['giftwrap']) { ?>
				<br>
				  &nbsp;<small><?php echo $button_giftadded; ?></small>
				<?php } ?>
				
            <?php if ($product['recurring']) { ?>
            <br />
            - <small><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></small>
            <?php } ?></td>
          <td class="text-right" style="width:40px;">x <?php echo $product['quantity']; ?></td>
          <td class="text-right"><?php echo $product['total']; ?></td>
          <td class="text-center"><button type="button" onclick="cart.remove('<?php echo $product['cart_id']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
        </tr>
        <?php } ?>
        <?php foreach ($vouchers as $voucher) { ?>
        <tr>
          
<!--tri mod start-->
<td class="text-center"><?php if (isset($voucher['thumb'])) echo $voucher['thumb']; ?></td>
<td class="text-left"><?php echo $voucher['description']; ?></td>
<!--tri mod end-->
      
          <td class="text-right">x&nbsp;1</td>
          <td class="text-right"><?php echo $voucher['amount']; ?></td>
          <td class="text-center text-danger"><button type="button" onclick="voucher.remove('<?php echo $voucher['key']; ?>');" title="<?php echo $button_remove; ?>" class="btn btn-danger btn-xs"><i class="fa fa-times"></i></button></td>
        </tr>
        <?php } ?>
      </table>
    </li>
    <li class="cart-order">
      <div>
        <table class="table table-condensed table-borderless">
          <?php foreach ($totals as $total) { ?>
          <tr>
            <td class="text-right"><strong><?php echo $total['title']; ?></strong></td>
            <td class="text-right"><?php echo $total['text']; ?></td>
          </tr>
          <?php } ?>
        </table>
        <div class="action-call text-right">
            <a href="<?php echo $cart; ?>" class="btn btn-default btn-cart-view" style="float:left">
              <i class="fa fa-shopping-cart"></i> <?php echo $text_cart; ?>
            </a>
            <a href="<?php echo $checkout; ?>" class="btn btn-primary bs-margin-left-xs btn-checkout">
              <i class="fa fa-share"></i> <?php echo $text_checkout; ?>
            </a>
        </div>
      </div>
    </li>
    <?php } else { ?>
    <li>
      <p class="text-center"><?php echo $text_empty; ?></p>
    </li>
    <?php } ?>
  </ul>
</div>
