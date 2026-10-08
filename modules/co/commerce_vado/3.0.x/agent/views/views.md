# Views integration

## The groups admin view

`config/install/views.view.commerce_vado_groups.yml` — id `commerce_vado_groups`, base table
`commerce_vado_group`, page path `/admin/commerce/vado-groups`, access = permission
`administer commerce_product`. This is the listing behind the "Variation groups" menu link and the
`entity.commerce_vado_group.collection` route. `RouteSubscriber` upcasts `%commerce_product`, forces the admin
theme, and adds `ProductVadoGroupAccessCheck` on the optional `page_1` (per-product tab) display so it only
shows when the product has variations referencing groups.

## Custom Views plugins (for rendering group items on the Add-to-Cart form)

Used by the group-widget "Views" title renderer (`group_item_title_renderer = views`) to render each option's
label through a view. Create a view with one of these displays to customise group-item option markup.

| Kind | id | Class | Purpose |
|---|---|---|---|
| Display | `commerce_vado_group` | `Plugin\views\display\VadoGroup` | "Vado group (Title)" source; flags `commerce_vado_group_display` |
| Display | `commerce_vado_group_item` | `Plugin\views\display\VadoGroupItem` | "Vado group item (Title)" source; flags `commerce_vado_group_item_display` |
| Style | `commerce_vado_group` / `commerce_vado_group_item` | `Plugin\views\style\*` | matching styles |
| Row | `commerce_vado_group` / `commerce_vado_group_item` | `Plugin\views\row\*` | matching rows |

The widget passes the selected group (`commerce_vado_group` option) and parent variation
(`selected_variation` option) into the display before execution; results are XSS-filtered (admin tags minus
`<a>`) into the option labels.

## Computed Views fields (hook_views_data_alter)

`commerce_vado_views_data_alter()` adds two fields on `commerce_vado_group_item`:

| Field id | Class | Shows |
|---|---|---|
| `group_item_discounted_price` | `Plugin\views\field\GroupItemDiscountedPrice` | the group item's price after its effective discount |
| `group_item_discount_amount` | `Plugin\views\field\GroupItemDiscountAmount` | the discount amount applied to the group item |

## Cart/order price hiding

`commerce_vado_preprocess_views_view_field()` — when `commerce_vado.settings:hide_parent_zero_price` is on,
blanks the `unit_price__number` / `total_price__number` output for VADO parent order items whose price is zero
(the "controller parent" pattern). Requires a cache rebuild after toggling the setting.

`commerce_vado_form_alter()` also adjusts the cart Views form (`tag == commerce_cart_form`): it disables the
quantity field and hides the remove button on synced child items, and relabels the parent's remove button to
"Remove Bundle" when sync is on.
