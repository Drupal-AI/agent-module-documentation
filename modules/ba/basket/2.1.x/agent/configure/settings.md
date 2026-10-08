# Configure Basket settings

There is **no `configure` route** and no single settings form. Every configuration screen is a
sub-page of the admin dispatcher route `basket.admin.pages` (`/admin/basket/{page_type}`), and each
writes to a schemaless config object named `basket.setting.<type>`. The module ships **no
`config/schema`**, so these are untyped config; set them by their real keys.

## Read/write settings in PHP

```php
$basket = \Drupal::service('Basket');
$value  = $basket->getSettings('order_form', 'config.submit_redirect'); // read a key
$basket->setSettings('order_form', 'config.submit_redirect', 'finish'); // write a key
```

`getSettings($type, $name = NULL)` is literally
`\Drupal::config('basket.setting.'.$type)->get($name)`; `setSettings()` is the editable equivalent.
Passing `$name = NULL` returns the whole object. Equivalent Drush:
`drush cget basket.setting.order_form` / `drush cset basket.setting.order_form config.submit_redirect finish`.

## Config objects shipped in `config/install`

| Config object | Admin page (`/admin/basket/…`) | Gating permission | Holds |
|---|---|---|---|
| `basket.setting.order_form` | `settings-order_form` | `basket access_page order_form` | Storefront order form: `config.submit_button`, `config.submit_redirect` (`finish`/`reload`/`<front>`/URL/`payment`), `config.submit_message`, `config.default_values` (token map), `config.form_mode`, `config.phone_mask`. |
| `basket.setting.order_page` (`SettingsOrderPage`) | `settings-order_page` | `basket access_page order_page` | Whether the cart-view page embeds the order form (`config.view_form`). |
| `basket.setting.notifications` | `settings-notifications` | `basket access_page notifications` | `config.notification_order_admin` + `_mails`, `config.notification_order_user` + `_field`. |
| `basket.setting.templates` | `settings-templates` | `basket access_page template` | Editable Twig templates per language (e.g. `basket_finish_<langcode>`, email bodies). |
| `basket.setting.enabled_services` | (Basic settings) | — | Master switches `payment`, `delivery`, and the widget type (`payment_widget`). |
| `basket.setting.popup_plugin` (`PopupPluginForm`) | `settings-popup_plugin` | `basket access_page popup_plugin` | Add-to-cart popup: `config.add_popup.type` (`noty_message`/modal), `config.add_popup.noty_message`, `config.admin` (admin popup plugin id). |
| `basket.setting.appearance` (`AppearanceSettingsForm`) | `settings-appearance` | `basket access_page appearance` | Contacts + storefront styles/colors (fed to `scss_compiler`). |
| `basket.setting.export_orders` (`SettingsExportOrdersForm`) | `settings-export_orders` | `basket access_page export_orders` | Order-export (xlsx) column/format config. |
| `basket.setting.FilterOrders` | Orders page filter | `basket edit_orders_filter_fields_access` | Which fields appear in the orders filter. |
| `basket.setting.orders_tabs_settings` | Orders page | `basket edit_orders_settings_tabs_access` | Order list tab definitions. |
| `basket.setting.orders_stat_block_settings` | Orders page | `basket edit_orders_settings_stat_block_access` | Statistics block on the orders page. |
| `basket.setting.basket_theme` | Appearance / theme negotiator | — | Admin theme override for `/admin/basket/*` (see `BasketThemeNegotiator`). |
| `basket.setting.empty_trash` (`EmptyTrashSettingsForm`) | `settings-empty_trash` | `basket access_page empty_trash` | Auto-empty-trash policy. |

Other settings-page forms with their own gate (values stored via `setSettings` under matching keys or
in dedicated tables): **Text settings** `settings-text` (`basket access_page text` → `TextSettingsForm`,
UI-string translations), **Discount system** `settings-discount_system` (`basket access_page discount_system`
→ `DiscountSystemForm`; ranges via `DiscountRangeForm`), **Currencies** `settings-currency`
(`basket access_page currency` → `basket_currency` table), **Statuses / Financial statuses**
`settings-status` / `settings-fin_status` (`basket access_page status` / `…fin_status` → `basket_terms`),
**Delivery / Payment types** `settings-delivery` / `settings-payment`
(`basket access_page delivery` / `…payment` → `basket_terms` + `Plugins`), **Material types**
`settings-node_types` (`basket access_page node_types` → `basket_node_types` table, see
[products.md](products.md)), **Permissions** `settings-permissions`
(`basket settings permissions rights` → `UserPermissionsForm`).

## settings.php overrides

- `$config['basket']['not_use_session'] = TRUE;` — cart uses a signed `__busid` cookie instead of the
  PHP session (lets the cart page be cached for anonymous users). Read in `BasketCart::getSid()` /
  `getCookieSid()`; on login/register the anon cart is merged to the uid (`hook_user_login` →
  `BasketCart::movingItems()`).

## Runtime notes

- `basket_install()` creates the `basket_order` node type + its fields and default terms/currency
  from `config/basket_install/*`; `basket_requirements()` warns if `scss_compiler` / the mPDF /
  PhpSpreadsheet libraries are missing.
- Config here is **untyped** — there is no `config/schema/*.schema.yml`, so `data.json`
  `provides_config_schema` is `false`.
