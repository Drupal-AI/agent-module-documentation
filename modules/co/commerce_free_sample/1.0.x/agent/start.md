<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Free Sample (commerce_free_sample) — agent index

**Free-sample selector for Commerce checkout**: adds a widget on the order-information step; the chosen sample becomes an order item.

**Version:** 1.0.x (1.0.2). Core: `^10 || ^11`. Depends on `commerce`, `commerce_order`, `commerce_product`, `commerce_checkout_order_fields`.

Mechanism: `hook_form_..._alter` on the multistep checkout adds `field_free_sample` (widget `free_sample_widget`) on the `order_information` step; submit handler `commerce_free_sample_checkout_form_submit` and the widget's `ajaxAddToOrder` remove any existing sample item and add the selected product's default variation as an `OrderItem` (unit_price = the variation's own price). Eligibility optional via `eligibility_field`/`eligibility_values`. Config `commerce_free_sample.settings` (`free_sample_ids`, `product_bundle`, `order_item_type`, eligibility). Route `commerce_free_sample.admin_settings_form` at `/admin/commerce/free-samples` (`administer commerce_product`). No permissions file.

**Security (report):** the submit/AJAX handlers load the posted product id and add it **without re-validating it is in `free_sample_ids`** (commerce_free_sample.module ~line 120; FreeSampleWidget::ajaxAddToOrder src/Plugin/Field/FieldWidget/FreeSampleWidget.php:214-243). Impact is limited: the item is charged at the variation's real `getPrice()`, so a tampered id adds a normally-priced item (data-integrity/UX, not free-money) — but keep sample products at price 0 and treat this as unverified form-value trust. Admin settings gated by `administer commerce_product`.

See [configure/settings.md](configure/settings.md).