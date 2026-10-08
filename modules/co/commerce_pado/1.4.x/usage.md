<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Add On lets one product offer other products as selectable add-ons directly in its Add to Cart form — an extended warranty next to a laptop, gift wrapping next to a gift, a membership beside a ticket — with each chosen add-on becoming its own order item at its own price.

---

The module works through display configuration rather than new entities. You add an entity-reference field (targeting `commerce_product`) to the product type that should offer add-ons, then on that type's **Manage display** you set the **Variations** field to the formatter **"Add to cart form with add-ons"** (`commerce_pado_add_to_cart`, class `PadoAddToCartFormatter`), pointing its `add_on_field` setting at the reference field and choosing whether customers may pick one or several (`multiple`). At render time the formatter lazy-builds the add-on form via `commerce_pado.lazy_builders` (`PadoLazyBuilders`), which instantiates `PadoAddToCartForm` (an order-item form registered through `hook_entity_type_build()`, extending Commerce's `AddToCartForm`). That form lists each referenced product's enabled, published variations as checkboxes or a select, labelled through three themeable hooks (`commerce_pado_add_to_cart_form`, `commerce_pado_addon_product_label`, `commerce_pado_addon_product_variation_label`, each with per-bundle suggestions). On submit it creates an order item per selected variation, resolves the price server-side through the chain price resolver, and adds it to the cart honoring the `combine` setting — so add-ons carry their own price, stock, tax and fulfilment as ordinary line items. The module also ships an order-item form mode (`pado_add_to_cart`) and `add_on` view modes for products and variations, plus a config schema for the formatter settings. Configuration exports with the site's view-display config, so add-on offers move between environments with normal config sync.

---

- Offer an extended warranty as a checkbox on a product page.
- Sell gift wrapping alongside a gift item.
- Add installation or setup services to hardware products.
- Offer accessories directly on the product page.
- Upsell a care plan without a separate cart step.
- Attach an optional membership to an event ticket.
- Let customers pick one add-on tier from a select list.
- Let customers pick several add-ons at once with checkboxes.
- Bundle optional extras while keeping separate order-item lines.
- Price each add-on independently via the chain price resolver.
- Track add-on stock as ordinary product-variation inventory.
- Theme add-on labels per product type or variation type.
- Show each add-on's price in its label with `commerce_price_format`.
- Configure which products are offered as add-ons per view display.
- Export add-on configuration with site config sync.
- Offer different add-ons in teaser vs. full product displays.
- Present add-ons as checkboxes rather than a separate product list.
- Report on add-on sales separately since each is its own order item.
- Remove add-ons from a display without deleting the products.
- Hide the underlying reference field while still driving the add-ons from it.
- Reuse one add-on product (e.g. gift wrap) across many host products.
- Restrict add-ons to published, enabled variations only.
- Keep the product page cacheable via the add-on form lazy builder.
