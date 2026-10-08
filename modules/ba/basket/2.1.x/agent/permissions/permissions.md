# Permissions

Defined in `basket.permissions.yml`. The file is **grouped** (`group:` / `sub_title:`) so the
permissions UI shows them under Orders / Buyers / Section / Settings / Users headings. User 1 always
passes (`BasketAccess::hasPermission()` short-circuits for uid 1), and `hook_basket_access_alter`
can override any check. Most admin screens are reached only through route `basket.admin.pages`, whose
custom access requires **`basket order_access`**; individual sub-pages then re-check the specific
permission below.

## Orders (group)

| Permission | Controls |
|---|---|
| `basket order_access` | Gate for the whole `/admin/basket` section (route custom access). |
| `basket edit_status_order_access` | Change an order's **status** term (AJAX `order_change_status`). |
| `basket edit_fin_status_order_access` | Change an order's **financial status** term (separable from status). |
| `basket edit_orders_filter_fields_access` | Edit which fields appear in the orders filter. |
| `basket edit_orders_settings_stat_block_access` | Edit the statistics block on the orders page. |
| `basket edit_orders_settings_tabs_access` | Edit the tab settings on the orders page. |
| `basket access_delete_order` | Delete orders. |
| `basket access_edit_order` | Edit orders (also grants `update` on `basket_order` nodes via `basket_node_access`). |
| `basket access_export_order` | Export orders (xlsx). |
| `basket access_restore_order` | Restore orders from trash. |

## Buyers / Section

| Permission | Controls |
|---|---|
| `basket access_edit_user_percent` | Edit individual per-user discount percentages (Statistics → Buyers). |
| `basket access_trash_page` | Access the Trash section. |
| `basket access_trash_clear_page` | Empty/clean the Trash section. |
| `basket operations product` | Product operations (bulk actions on goods). |

## Settings (group) — one "Access to page" per settings screen

`basket settings permissions rights`, and `basket access_page <sub>` for `<sub>` ∈
`node_types`, `order_form`, `order_page`, `notifications`, `template`, `export_orders`, `hooks`,
`empty_trash`, `appearance`, `text`, `status`, `fin_status`, `currency`, `delivery`, `payment`,
`popup_plugin`, `discount_system`. Each gates the matching `/admin/basket/settings-<sub>` screen.
(The Text-settings screen's translate action also uses `basket access_page text`; the external
libraries screen uses `basket access_page external_libraries`.)

## Users (storefront-facing)

| Permission | Controls |
|---|---|
| `basket add_button_access` | May add items to the cart / view the cart page (`/basket/view`). |
| `basket user_create_order_access` | May place an order (`/basket/order` + the storefront order form). |
| `basket access_testing_paydel` | See hidden/inactive payment & delivery methods (for testing). |

Grant in PHP: `$role->grantPermission('basket add_button_access')->save();`
