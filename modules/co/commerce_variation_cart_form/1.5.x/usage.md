Commerce Variation Cart Form adds a per-variation add-to-cart form as a pseudo-field ("Add to cart form") on the Commerce Product Variation manage-display, so each product variation can be rendered standalone with its own add-to-cart button and quantity field.

---

The module registers an `entity_extra_field_info` pseudo-field named `commerce_variation_cart_form` on every `commerce_product_variation` bundle's display; when you make it visible on a variation type's *Manage display*, `hook_ENTITY_TYPE_view()` builds an `AddToCartForm` for an order item created from that variation and renders it through the `commerce_variation_cart_form` theme hook. It exposes the order item form via a dedicated form mode: `commerce_variation_cart_form_entity_type_build()` maps the `variation_cart_form` operation to `Drupal\commerce_cart\Form\AddToCartForm`, and the module ships optional config for a "Variation cart form" form mode on `commerce_order_item` plus a default form display that shows only the `quantity` field. Which order-item fields appear in the form (typically just Quantity, or nothing for a plain add-to-cart button) is configured on the Order Item Type's *Manage form display* under that form mode. A per-display third-party setting, `combine` (boolean, schema `core.entity_view_display.*.*.*.third_party.commerce_variation_cart_form`), controls whether adding the variation combines with an identical existing cart item; it is edited via a checkbox injected into the variation display edit form. The form is access-gated on the `access checkout` permission and hidden (showing an "unavailable" message) when the variation is unpublished. It requires Commerce with the Product, Order and Cart submodules; the typical setup also renders the product's Variations field as "Rendered entity" (with injection of variation fields turned off) so the per-variation forms replace the default single product add-to-cart form.

---

- Show an individual add-to-cart form for each product variation instead of the single product-level form.
- Display a standalone product variation (e.g. in a Views listing) with its own working add-to-cart button.
- Render a grid of variations, each independently addable to the cart.
- Position the add-to-cart form anywhere among a variation's fields, since it is a pseudo-field on the display.
- Offer an add-to-cart button with a default quantity of 1 by hiding all fields in the cart form mode.
- Show a Quantity field on each variation's add-to-cart form by making only `quantity` visible in the form mode.
- Combine identical variations into one cart line item by enabling the `combine` third-party setting.
- Keep identical variations as separate cart lines by leaving `combine` off.
- Replace the default Commerce product add-to-cart form with per-variation forms via the product display.
- Gate the add-to-cart form behind the `access checkout` permission automatically.
- Show a friendly "This product is unavailable" message for unpublished variations.
- Theme the form wrapper by overriding `commerce-variation-cart-form.html.twig`.
- Provide product-type-specific markup with suggestions like `commerce-variation-cart-form--PRODUCT_TYPE.html.twig`.
- Provide variation-type and view-mode-specific templates (`…--PRODUCT_TYPE--VARIATION_TYPE--VIEW_MODE.html.twig`).
- Build a "quick order" page listing every variation of a product with inline add-to-cart forms.
- Let customers add multiple different variations to the cart from one page without a variation selector.
- Configure the Quantity placeholder or hide it entirely per order item type.
- Render variations as entities inside a custom view mode and inject the cart form into that mode.
- Prevent the default variation fields from being duplicated by disabling "Inject product variation fields" on the product type.
- Support multiple product/variation types, each with its own cart-form display configuration.
- Expose the add-to-cart form for a single purchasable variation embedded in an arbitrary block or page.
