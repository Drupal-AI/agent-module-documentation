<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Direct checkout by URL exposes `/direct-checkout-by-url`, which reads product SKUs from the query string, adds them to the visitor's Commerce cart, and redirects straight to checkout — a shareable "buy now" deep link that skips the product page.

---

The endpoint takes a `products` query parameter in one of two shapes. A comma-separated string of SKUs — `/direct-checkout-by-url?products=1234,5678` — adds each SKU with a quantity of 1. An array — `/direct-checkout-by-url?products[0][sku]=1234&products[0][quantity]=2` — lets each entry carry its own quantity. For every entry the controller loads the matching `commerce_product_variation` by SKU (`loadBySku`), runs it through Commerce's availability manager, selects the variation's store (single-store, or the current store when sold from several), gets or creates the visitor's `default` cart for that store, and calls `CartManager::addEntity()` so the line item is priced server-side from the product — never from the URL. Two settings at `/admin/commerce/config/orders/direct-checkout-by-url` shape the behaviour: **Reset cart** empties the existing cart before adding (guaranteeing the visitor arrives at checkout with exactly the linked items, at the cost of discarding whatever they had), and **Allow unknown SKUs in URL** decides whether an unknown SKU is skipped (so stale links still work with the products that do exist) or triggers a 404. After adding, it redirects to `commerce_checkout.form` for the cart's order; if nothing could be added it redirects to the cart page. Because that is an ordinary internal redirect, Drupal's built-in `destination` parameter overrides the target — `?products=123&destination=cart` lands on the cart instead of checkout. Two permissions gate the module: `use direct checkout` on the endpoint (not granted to anonymous by default — grant it to the anonymous role to make links public) and `administer direct checkout by url` on the settings form. Requires the `commerce_product`, `commerce_order`, `commerce_cart`, and `commerce_checkout` modules. A known minor defect: the admin permission declares `restrict_access: TRUE` with an underscore, but core reads the key `restrict access` with a space, so the "restricted" warning beside it on the permissions page is silently not shown (the permission is otherwise granted normally).

---

- Send a campaign email that lands the recipient on checkout with the offer already in the cart.
- Build a one-click reorder link for a known product SKU.
- Point a paid ad directly at payment instead of a catalogue page.
- Create a subscription renewal link that re-adds the same plan.
- Put a bundle in the basket from a QR code on packaging.
- Add a Views "add to cart" button using the global custom text field and a link to `/direct-checkout-by-url?products={{ sku }}`.
- Link into checkout from a printed catalogue or flyer.
- Offer a sample-request flow that pre-fills the cart.
- Support a partner or affiliate referral link that seeds a specific product.
- Skip the product page for a repeat buyer who already knows what they want.
- Send a pre-filled multi-item cart to a customer over chat or SMS.
- Give a sales team quote links that drop agreed items into a cart.
- Build a limited-time-offer link for a single SKU.
- Create an event-ticket purchase shortcut.
- Reorder refills from an in-product link.
- Use `destination=cart` to build a cart from a link but stop at the cart rather than checkout.
- Enable "Reset cart" so a campaign link always checks out exactly the linked items.
- Enable "Allow unknown SKUs" so archived links keep working after products are retired.
- Add multiple SKUs with per-item quantities in one link via the array form.
- Restrict the feature to logged-in customers by withholding `use direct checkout` from anonymous.
- Grant `use direct checkout` to anonymous to make the buy links fully public.
- Drive conversion by removing steps between intent and purchase.
