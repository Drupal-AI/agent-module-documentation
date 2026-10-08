<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Variation Radio Widget adds a "Product variation radio" field widget that renders each purchasable product variation as a full, themable radio option on the Commerce add-to-cart form instead of the default select dropdown.

---

Commerce Product Variation Radio Widget ships a single Field API widget plugin, `commerce_product_variation_radio` (class `ProductVariationRadioWidget`, extending Commerce's `ProductVariationWidgetBase`), for the Purchased entity / product-variation `entity_reference` field on order-item "Add to cart" form displays. Each enabled variation is rendered through the entity view builder in a configurable view (display) mode and offered as a radio option, so shoppers pick a variation (size, colour, etc.) by clicking a rich, styled card rather than choosing from a `<select>`. The widget keeps Commerce's AJAX refresh behaviour so price and other variation-dependent fields update when the selection changes. It has four widget settings — an accessible label (text plus a show/hide toggle), a "hide when there is only one variation" option, and the view mode used to render each option — and provides its own theme hooks, templates and a small CSS library (`cpv_radio_widget/style`) so the radio group can be fully re-themed. It depends on Commerce and Commerce Product, targets Drupal core `^10 || ^11`, and adds no routes, permissions, services, Drush commands or config entities of its own.

---

- Replace the default product-variation `<select>` on the add-to-cart form with radio buttons.
- Let shoppers pick a variation (size, colour, style) by clicking a rich radio card.
- Render each variation option through a chosen Commerce view (display) mode (e.g. show a thumbnail + title per option).
- Present a small set of variations as visually distinct, themable options.
- Keep Commerce's AJAX behaviour so price/fields refresh when the selected variation changes.
- Configure a screen-reader label for the radio group via the widget's "Label text" setting.
- Show or visually hide that label while keeping it available to assistive technology.
- Automatically collapse the widget to a hidden value when a product has exactly one variation ("Hide if there's only one product variation").
- Hide the whole add-to-cart form when a product has no purchasable (enabled) variations.
- Apply the widget per order-item type on Commerce → order item type → Manage form display.
- Choose the "Product variation radio" widget on the Purchased entity field and set its options via the gear icon.
- Theme the radio group with the shipped `radios--commerce-product-variation-radios` and `form-element--commerce-product-variation-radio` templates.
- Override the module's `css/style.css` (library `cpv_radio_widget/style`) to restyle the option cards, hover and selected states.
- Build swatch- or card-style variation pickers for apparel, subscriptions or configurable products.
- Improve add-to-cart UX where a dropdown obscures the available variations.
- Use a custom variation view mode to display images, attributes or price per radio option.
- Keep accessible variation selection (proper `<label>`s, required marker) while restyling the control.
- Drop into any Drupal Commerce 3 store running on Drupal 10 or 11.
- Provide a drop-in alternative to Commerce's default product-variation widget without custom code.
- Support multiple order-item types, each with its own label text and view mode.
- Fall back gracefully (single hidden value) so single-variation products still add to cart cleanly.
