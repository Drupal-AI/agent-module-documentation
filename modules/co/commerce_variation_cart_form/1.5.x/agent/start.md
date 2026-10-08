# Commerce Variation Cart Form (commerce_variation_cart_form) — agent index

Adds an **"Add to cart form" pseudo-field** to each Commerce Product Variation's *Manage
display*, so a single variation can render with its own add-to-cart form. No admin settings
page, no permissions of its own, no Drush, no plugins (`configure` = null). Requires Commerce
+ commerce_product + commerce_order + commerce_cart.

- **How to enable/position the form, the `combine` setting, the `variation_cart_form` form
  mode, and the product-display wiring** → [configure/setup.md](configure/setup.md)
- **Theming the form wrapper and the template suggestions** →
  [theming/template.md](theming/template.md)

Key facts (grounded in `commerce_variation_cart_form.module`):
- Pseudo-field id: **`commerce_variation_cart_form`** on `commerce_product_variation` displays
  (hidden by default; make it visible on the variation type's Manage display).
- Order-item form mode: **`variation_cart_form`** → `commerce_cart\Form\AddToCartForm`; its
  fields are set on the Order Item Type *Manage form display*.
- Third-party setting **`combine`** (bool) on the variation `entity_view_display`, schema
  `core.entity_view_display.*.*.*.third_party.commerce_variation_cart_form`.
- Form access requires the `access checkout` permission; unpublished variations show an
  "unavailable" message.
