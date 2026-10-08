# Configuration

There are two sides to setting this up: **showing the link** (on a display or in a
view) and the **module settings** (token protection and redirect behavior).

## 1. Show the link on a product or variation display

The module adds an **Add to cart link** field to every product and product-
variation display, but it's **hidden by default**. Enable it on the view modes
where you want it:

1. Go to **Commerce → Configuration → Product types → {type} → Manage display**
   (`/admin/commerce/config/product-types`).
2. Choose the view mode you want (for example a "Catalog" or "Teaser" mode via the
   local tabs at the top).
3. Drag **Add to cart link** out of the *Disabled* region into a visible one.
4. **Save.**

Which variation the link adds depends on where you enable it:

- On a **product** display, the link adds the product's **default variation**
  (nothing renders if the product has no active variation).
- On a **variation** display, the link adds **that specific variation** — ideal
  for products that have many variations, giving each its own link.

**Recommendation:** keep the normal add-to-cart *form* on the full product page,
and use the link only on catalog and teaser view modes.

## 2. Add the link as a Views field

If you build product listings with Views, you can add the link as a field
instead:

1. Edit a view of **product variations** and add the **Add to cart** field.
2. In the field settings you get a few options:
   - **Quantity** — how many to add per click (default 1; set to, say, 6 to add a
     six-pack at once).
   - **Combine** — when on (default), adding the same product again merges into
     the existing cart line item; turn it off to create a separate line item each
     time.
   - **Destination** — when on, appends a "return to this listing" destination so
     the shopper comes back to the view after adding.

## 3. Module settings

Open **Configuration → Commerce → Commerce Add To Cart Link**
(`/admin/commerce/config/add-to-cart-link`). You need the *Administer product
types* permission. Two settings:

- **CSRF token roles** — choose which user roles get a per-user security token
  added to their cart links. A user is protected if **any** of their roles is
  selected. Leave this empty (the default) and no one gets a token — which is
  perfectly fine for anonymous, cacheable catalog links, since there's nothing
  secret to protect. Enable it for authenticated roles when you want to guard
  against bots or cross-site request forgery.
- **Redirect back** — off by default. When on, after adding to the cart the
  shopper is sent back to the page they came from (the referring listing) instead
  of to the cart page. If there's no valid internal referrer, they still go to the
  cart page.

Click **Save configuration**.

## Theming and AJAX (optional)

The link renders through a Twig template (`commerce_add_to_cart_link`), with
per-bundle and per-id template suggestions, so themers can fully control its text
and markup. Add `use-ajax` in the template to turn the link into an AJAX action
that updates the cart count live without a full page reload; a custom
`addToCartLink.updated` JavaScript event lets you show a toast or update your own
cart widget. See the sibling [`agent/`](../agent/start.md) docs for the exact
template names and event details.
