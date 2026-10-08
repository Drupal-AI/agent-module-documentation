# Integrator hooks

Basket invokes a large set of its own hooks (declared in `basket.api.php`). Implement them in your
module to extend the store without patching. Two shapes: `*_alter` hooks (invoked via
`moduleHandler()->alter()`) and plain invoked events (`invokeAll()`).

## Invoked events (act on a moment)

| Hook | Fired when |
|---|---|
| `hook_basket_cart($cartItem, $type)` | A cart row changes; `$type` = `add` / `updateCount` / `delete`. |
| `hook_basket_item($orderItem, $type)` | An order line changes; `$type` = `insert` / `update` / `delete`. |
| `hook_basket_paymentFinish($nid)` | An order's payment is confirmed (from the verified callback). |
| `hook_currency_clear_cache()` | Currency caches are cleared. |

## Order / checkout alters

| Hook | Purpose |
|---|---|
| `hook_basket_insertOrder_alter(&$fields, &$items, $entity)` | Change order + line data before the order is written. |
| `hook_basket_postInsertOrder_alter($entity, $orderId)` | React after an order is placed. |
| `hook_basketOrderUpdate_alter($order, $oldOrder)` | Track order changes. |
| `hook_basket_order_tokenDefaultValue_alter($node)` | Pre-fill the new order node from tokens. |
| `hook_basket_submit_ajax_response_alter(&$response, $form, $form_state)` | Alter the AJAX response after order submit. |
| `hook_basket_order_get_id_alter(&$orderViewId)` | Change the displayed order number format. |
| `hook_basket_order_links_alter($links, $order)` | Order operation links. |
| `hook_basket_orderEditAddData_alter(&$data, $entity)` | Params when adding a product to an order (admin). |

## Pricing / cart alters

| Hook | Purpose |
|---|---|
| `hook_basket_getItemPrice_alter(&$price, $row)` / `…getItemPriceAfter_alter` | Override a line price (before/after the default query). |
| `hook_basket_getItemDiscount_alter(&$discount, $row)` | Override a line discount %. |
| `hook_basket_getItemImg_alter(&$fid, $row)` | Override a line image fid. |
| `hook_basket_getTotalSum_alter(&$total, $items, $config)` | Adjust the cart total after all calculations. |
| `hook_basket_getPayInfo_alter(&$info)` | Adjust pay amount/currency. |
| `hook_basketNodeGetPriceField_alter(&$query, $keyNodeTypes, $entityId)` / `hook_priceQueryPostAlter_alter(&$query)` | Rewrite the product price SQL. |
| `hook_basket_getItemsInBasketQuery_alter(&$query)` | Replace the "items in cart" query. |
| `hook_basket_current_currency_alter(&$currency)` | Force the active currency. |
| `hook_basket_add_alter(&$info)` / `hook_basket_add_popup_alter(&$info)` | Add-to-cart params / post-add popup. |
| `hook_basket_count_input_attr_alter(&$attr, $nid, $params)` | Quantity input attributes. |

## Payment / delivery / params alters

`hook_basketPaymentField_alter`, `hook_basket_ajaxReloadPayment_alter`,
`hook_basket_create_payment_preInit_alter`, `hook_basket_payment_option_access_alter`,
`hook_payment_settings_info_alter`; `hook_basket_delivery_preInit_alter`,
`hook_basket_delivery_option_access_alter`, `hook_basket_ajaxReloadDelivery_alter`,
`hook_delivery_settings_info_alter`, `hook_basket_getDeliveryInfo_alter`;
`hook_basket_params_definition_alter`, `hook_basketValidParams_alter`.

## Access, UI, misc

`hook_basket_access_alter(&$access, $permission, $options)` (override any Basket permission check),
`hook_basket_pages_alter` / `hook_basket_admin_page_alter` (alter rendered storefront/admin pages),
`hook_basket_api_csrf_exempt_subtypes_alter(&$subtypes)` (mark public API subtypes CSRF-exempt),
`hook_basket_translate_context_alter`, `hook_basketTemplateTokens_alter`, `hook_basketTokenValue_alter`,
`hook_basket_template_list_alter`, `hook_basket_offered_services_alter`, `hook_basket_post_load_alter`,
`hook_basket_get_new_count_alter`, `hook_stockProductLinks_alter`,
`hook_basket_node_type_extra_fields_list_alter` / `…_form_alter`,
`hook_basket_cart_img_alter`, `hook_basket_add_field_views_defineOptions_alter` /
`…buildOptionsForm_alter`.

## Core hooks Basket itself implements (relevant to integrators)

`hook_cron` (cart cleanup), `hook_user_login` / `hook_user_insert` (merge anon cart → user),
`hook_entity_delete` (cascade product/order cleanup), `hook_node_access` (grants `update` on
`basket_order` to `basket access_edit_order`), `hook_entity_extra_field_info` + `hook_node_view`
(the add-to-cart extra field), `hook_mail` (order e-mails), `hook_toolbar`, and several
`hook_update_projects_alter` / `…status_alter` / `hook_locale_translation_projects_alter` that point
Basket-ecosystem update/translation lookups at alternativecommerce.org.
