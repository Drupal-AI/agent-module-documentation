<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Product variation radio" widget

## Install & enable

```bash
composer require drupal/cpv_radio_widget
drush en cpv_radio_widget -y
```

Requires Drupal Commerce (`drupal/commerce:^3.0`); the enabled Drupal modules `commerce` and
`commerce_product` are dependencies (info.yml). Core `^10 || ^11`. No sub-modules, no permissions,
no Drush commands, no routes of its own.

## Enable it on a field

The widget (plugin id **`commerce_product_variation_radio`**, label *"Product variation radio"*)
targets `entity_reference` fields and is meant for the **Purchased entity** field of a Commerce
**order item type** — i.e. the field that references `commerce_product_variation`.

UI path: *Commerce → Configuration → Order item types → (type) → Manage form display* → set the
**Purchased entity** field's widget to **Product variation radio** → click the gear to configure
the settings below.

It extends `\Drupal\commerce_product\Plugin\Field\FieldWidget\ProductVariationWidgetBase`, so it
plugs into Commerce's add-to-cart form exactly where the stock "Product variation" widget does and
keeps the same AJAX refresh (price/fields update on selection change).

## Widget settings

From `defaultSettings()` in `ProductVariationRadioWidget.php`:

| Setting key | Default | Meaning |
|---|---|---|
| `label_display` | `TRUE` | Show the radio-group label. When `FALSE`, the label's `#title_display` is set to `invisible` (still read by screen readers). |
| `label_text` | `'Please select'` | The group label / `#title`. **Required** in the settings form; also exposed to screen readers when hidden. |
| `hide_single` | `TRUE` | If a product has exactly one variation, skip the radios and submit that variation as a hidden value. |
| `label_display_mode` | `'default'` | The product-variation **view (display) mode** used to render each radio option. The select is only shown when the form supplies `#entity_type`; options come from `entity_display.repository`'s `getViewModes('commerce_product_variation')` plus a *Default* entry. |

`settingsSummary()` prints a summary line: the label text + `(visible|hidden)`, a note when
`hide_single` is on, and the chosen label display mode.

There is **no config schema** for these widget settings; they are stored inside the order-item
type's form-display config (`core.entity_form_display.commerce_order_item.<type>.<mode>` under
`content.purchased_entity.settings`). Strict config-schema tooling may flag them, but they save and
work.

## How an option is rendered (`formElement()`)

1. `$product = $form_state->get('product')`; `$variations = $this->loadEnabledVariations($product)`
   (inherited — only enabled/purchasable variations).
2. **No variations** → `$form_state->set('hide_form', TRUE)` and `variation` becomes `#type =>
   'value'` with value `0`; the add-to-cart form hides.
3. **One variation + `hide_single`** → `variation` becomes a hidden `#value` of that variation id,
   and `selected_variation` is stored in form state; no radios rendered.
4. **Otherwise** → a `#type => 'radios'` element:
   - options: for each variation, `\Drupal::entityTypeManager()->getViewBuilder(
     'commerce_product_variation')->view($entity, $this->getSetting('label_display_mode'))` is
     rendered via the `renderer` service and used as the option label (keyed by variation id). This
     is what makes each radio a full, themable variation render (image, title, price, etc.).
   - `#title` = `label_text`; `#required = TRUE`; `#default_value` = current/selected variation id
     (from user input via `selectVariationFromUserInput()`, else `getDefaultVariation()`).
   - `#ajax` uses the inherited `ajaxRefresh` callback with the form's `#wrapper_id`.
   - `#context['widget'] = 'commerce_product_variation_radio'` — this tag is what the theme
     suggestion hooks key on.

## Theming

Registered in `hook_theme()` (`.module`):

- `radios__commerce_product_variation_radios` → `templates/radios--commerce-product-variation-radios.html.twig`
  (a `<div{{ attributes }}>{{ children }}</div>` wrapper; class `commerce-product-variation-radios`).
- `form_element__commerce_product_variation_radio` →
  `templates/form-element--commerce-product-variation-radio.html.twig` (per-option wrapper; class
  `commerce-product-variation-radio`, label class `commerce-product-variation-radio-label`).
- `input__radio__commerce_product_variation_radio` (declared for override; the module ships no
  template for it).

`cpv_radio_widget_theme_suggestions_radios_alter()` and
`cpv_radio_widget_theme_suggestions_form_element_alter()` add those suggestions when the element is
a radios/radio carrying the `commerce_product_variation_radio` widget context (the form-element hook
also checks the `#parents` contain `purchased_entity` + `variation`).
`template_preprocess_radios__commerce_product_variation_radios()` adds the wrapper id/title/class
and attaches library **`cpv_radio_widget/style`** (`css/style.css`), which visually hides the native
radio input and turns each label into a clickable card with hover/checked states. Override
`css/style.css` (or the templates) in your theme to restyle.

## Operating notes

- This is purely a **presentation/UX** widget for variation selection; it does not change pricing,
  access, stock or cart logic — it defers to `ProductVariationWidgetBase` for load/default/AJAX.
- Best for a **small** number of variations (radio cards laid out with `justify-content:
  space-between`); large variation sets are better served by the default select.
- Option markup is produced by the trusted Commerce entity view builder (access-checked) and the
  label goes through the escaped form `#title`, so there is no unescaped user/remote output here.
