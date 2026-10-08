<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Variation Radio Widget (cpv_radio_widget) — agent index

A single Commerce **field widget** that renders the product-variation selector on the add-to-cart
form as **radio buttons** (each option a full entity-view render) instead of the default `<select>`.
Package `Commerce`. Depends on **`commerce`** and **`commerce_product`**. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.0-beta2. Composer: `drupal/commerce:^3.0`.

- **The widget, its four settings, theming and how to enable it** → [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `ProductVariationRadioWidget` (id **`commerce_product_variation_radio`**, label
  *"Product variation radio"*, `field_types = { "entity_reference" }`) in
  `src/Plugin/Field/FieldWidget/ProductVariationRadioWidget.php`, extending Commerce's
  `ProductVariationWidgetBase` and implementing `ContainerFactoryPluginInterface`. Selected per
  order-item type on **Manage form display** for the Purchased entity field.
- No routes, no permissions, no services, no Drush, no config entities, **no config schema**
  (widget settings save via the view-display config only). Adds procedural theme/preprocess hooks.

## Mechanism (from source)

- `formElement()` loads enabled variations via `loadEnabledVariations($product)`. Zero variations →
  sets `hide_form` and returns a `#value` of 0 (form hides). Exactly one variation **and**
  `hide_single` on → returns that variation as a hidden `#value`. Otherwise builds a `#type =>
  'radios'` element whose `#options` are each variation rendered with
  `entityTypeManager()->getViewBuilder('commerce_product_variation')->view($entity, <display mode>)`,
  keyed by variation id, with `#title` = the `label_text` setting and an `#ajax` refresh callback
  (`ajaxRefresh`, inherited). `label_display == FALSE` sets `#title_display = 'invisible'`.
- `defaultSettings()`: `label_display` (TRUE), `label_text` (`'Please select'`), `hide_single`
  (TRUE), `label_display_mode` (`'default'`) plus parent settings. `settingsForm()` /
  `settingsSummary()` expose these on Manage form display.
- `.module`: `hook_theme()` registers `radios__commerce_product_variation_radios`,
  `form_element__commerce_product_variation_radio`, `input__radio__commerce_product_variation_radio`;
  two `hook_theme_suggestions_*_alter` add those suggestions when the element carries the widget
  context; `template_preprocess_radios__commerce_product_variation_radios()` attaches library
  `cpv_radio_widget/style` (`css/style.css`). Templates live in `templates/`.

## Security / notes

- The radio option markup comes from the **Commerce entity view builder** for each enabled
  variation (access-checked, trusted render pipeline); `label_text` is an admin-set widget setting
  placed in the element `#title` (escaped by form rendering). No SQL, no external HTTP, no
  request-supplied paths or URLs. Nothing user-facing is rendered unescaped.
