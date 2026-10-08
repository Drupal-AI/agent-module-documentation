Commerce Cart Redirection sends a Drupal Commerce shopper to the checkout, the cart, or a custom URL immediately after they add a matching product to their cart, instead of leaving them on the product page. Behaviour is driven by one or more reusable "redirection rule" config entities, each with its own Commerce conditions, redirect target, optional replacement "Add to cart" button text and an optional "clear the cart first" option.

---

Version 4.x is a full rewrite of the old single settings form into a `commerce_cart_redirection_rule` config entity type managed at `/admin/commerce/config/commerce_cart_redirection` (permission `configure commerce_cart_redirection`). You create any number of rules; each rule holds a set of standard Commerce **order-item condition plugins** (match by product, product type, variation, variation type or category), a condition operator (`AND`/`OR`), a redirect target (`checkout`, `cart`, or `other` with a custom URL), optional replacement button text, and a `clear_cart` flag. Enabled rules are sorted by weight on a drag-to-reorder listing and the first rule whose conditions match the added order item wins; a rule with no conditions matches every item. The redirect itself is done by `CommerceCartRedirectionSubscriber`: it listens to `CartEvents::CART_ENTITY_ADD` (resolves the URL, optionally clears the cart, dispatches the alterable `RedirectUrlEvent`, and stashes the URL on the request) and to `KernelEvents::RESPONSE` at priority -10 (issues a `RedirectResponse`, or an Ajax `RedirectCommand` for Ajax add-to-cart, or an `X-Commerce-Cart-Redirect` header for non-HTML/decoupled requests). The `checkout` target falls back to `<front>` when no `commerce_checkout.form` route exists (headless / alternative checkout). Custom URLs and the button text both support tokens (order item, product variation and product data), with a built-in open-redirect guard: a URL that only becomes external through token replacement must resolve back to this site, otherwise the redirect falls back to checkout and logs a warning. Rules declare config dependencies on the bundles their conditions reference, disabling or narrowing themselves when a referenced type is deleted. Upgrading from 3.x runs a post-update that converts the legacy single configuration into a "Default" rule.

---

- Send shoppers straight to checkout after adding a product, for a one-click "buy now" flow.
- Redirect to the cart page after every add-to-cart instead of the default in-place refresh.
- Redirect to a custom thank-you or upsell page URL after a specific product is added.
- Create a rule that only fires for a specific product variation type (e.g. "event ticket" variations).
- Create a rule that only fires for a specific product, product type or product category using Commerce conditions.
- Combine several conditions with AND (all must pass) or OR (any one passes) per rule.
- Stack multiple rules in weight order so a specific rule wins over a broader catch-all beneath it.
- Build a single-item checkout kiosk where adding a product clears the cart and jumps to checkout.
- Force "one product at a time" carts by enabling "Clear cart before add" on a rule.
- Relabel the "Add to cart" button to "Buy now" for products matched by a rule.
- Set different button text per rule, e.g. "Pay Fees" for one variation type and "Pay & Register" for another.
- Redirect ticket purchases to checkout while leaving ordinary merchandise in the normal cart flow.
- Send one variation type to checkout and another to the cart from the same product using two rules.
- Redirect back to the originating page with a custom URL of `[current-page:url]` (keeps the correct language on multilingual sites).
- Build a per-product external payment URL such as `https://pay.example.com/[commerce_order_item:order_id]`.
- Translate the rule label and button text per language with core's Configuration Translation.
- Drive donation-style flows where each amount variation goes straight to checkout with a cleared cart.
- Send subscription or license products directly to checkout after selection.
- Reduce cart abandonment by removing the extra click between add-to-cart and checkout.
- Redirect to an external hosted payment/checkout provider page after add.
- Support a headless/decoupled front end: read the resolved target from the `X-Commerce-Cart-Redirect` response header on a JSON:API/REST add-to-cart.
- Alter or cancel a redirect in custom code by subscribing to `RedirectUrlEvent` (set the URL, or set it to an empty string to keep default add-to-cart behaviour).
- Grant a store manager the `configure commerce_cart_redirection` permission to self-serve redirection rules.
- Disable a rule temporarily without deleting it (disabled rules are skipped and linked from the listing).
- Migrate a 3.x site: run database updates to auto-convert the old settings into a "Default" rule.
- Export redirection rules as config for consistent behaviour across environments or a multi-store site.
- Point the checkout redirect at the front-page fallback when running an alternative checkout (e.g. BigCommerce).
