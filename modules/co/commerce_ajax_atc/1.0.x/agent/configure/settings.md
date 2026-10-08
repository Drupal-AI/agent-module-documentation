# Configure — enable AJAX + pop-up settings

Two parts: (1) turn AJAX on for a product display, (2) configure the global pop-up.

## 1. Enable AJAX on a product display (per-formatter third-party setting)

On the product's *Manage display* (e.g. `/admin/commerce/config/product-types/default/edit/display`),
the **Variations** field uses the `commerce_add_to_cart` formatter; this module adds an
**"Enable Ajax"** checkbox to that formatter's settings. It is stored as a third-party setting on
the `variations` component of the `entity_view_display`:

```
core.entity_view_display.commerce_product.<bundle>.<view_mode>
  → content.variations.third_party_settings.commerce_ajax_atc.enable_ajax: true
```

Schema: `field.formatter.third_party.commerce_ajax_atc` → `enable_ajax` (boolean). Set it in code:

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('commerce_product', 'default', 'default');
$component = $display->getComponent('variations');
$component['third_party_settings']['commerce_ajax_atc']['enable_ajax'] = TRUE;
$display->setComponent('variations', $component)->save();
```

Only the `commerce_add_to_cart` (and `commerce_vado_group_add_to_cart`) formatters get the
checkbox. When enabled, the add-to-cart form's submit button gains an AJAX callback.

## 2. Global pop-up settings (`commerce_ajax_atc.settings`)

Settings form route `commerce_ajax_atc.ajax_settings_form` →
`/admin/commerce/config/ajax-settings` (permission `access ajax atc administration pages`;
menu under *Commerce → Configuration → Ajax*). Config object `commerce_ajax_atc.settings`:

| Key | Values / type | Purpose |
|---|---|---|
| `pop_up_type` | `non_modal` \| `modal_dialog` \| `colorbox` | Confirmation style. `colorbox` only offered when Colorbox Load is installed. |
| `success_message` | string | Confirmation text; supports the `[variation_title]` token. Blank → "[title] added to". |
| `cart_link_text` | string | Link text after the message; blank → "your cart"; `[none]` → no link. |
| `include_cart_button` / `cart_button_text` | bool / string | "View cart" button (default label "View cart"). |
| `include_checkout_button` / `checkout_button_text` | bool / string | "Checkout" button (default "Checkout"). |
| `include_close_button` / `close_button_text` | bool / string | Close button (default "Continue shopping"). |
| `ajax_modal_title` / `ajax_modal_width` / `ajax_modal_height` | string | Modal dialog options (used when `modal_dialog`). |
| `colorbox_width` / `colorbox_height` | string | Colorbox size (used when `colorbox`). |
| `use_twig_template` | bool | Render the pop-up via the `commerce_ajax_atc_popup` theme hook + view mode instead of the plain message. |
| `enable_variation_cart_form_ajax` | bool | Enable AJAX for the Commerce Variation Cart Form module's form. |

Set via drush:

```bash
drush cset commerce_ajax_atc.settings pop_up_type modal_dialog -y
drush cset commerce_ajax_atc.settings include_cart_button 1 -y
drush cset commerce_ajax_atc.settings ajax_modal_title 'Added to cart' -y
```

Note: the module ships **no** `config/install` for these settings, so `commerce_ajax_atc.settings`
does not exist until the form is saved (or you create it) — `pop_up_type` is unset by default.

## Permission

`access ajax atc administration pages` — gates the settings form only. (The AJAX close route
`/close-modal-form` uses `access content`.)
