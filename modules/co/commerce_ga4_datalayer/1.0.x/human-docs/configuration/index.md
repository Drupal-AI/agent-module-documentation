# Configuration

All configuration lives on one form at **Commerce → Configuration → GA4
DataLayer** (`/admin/commerce/config/ga4-datalayer`). Open it as a user with the
*Administer commerce GA4 DataLayer* permission.

## Choose which events fire

Each GA4 event has its own on/off toggle, so you can send only what your GA4
property reports on. The available events are:

- `view_item`, `add_to_cart`, `remove_from_cart`, `view_cart`
- `begin_checkout`, `add_shipping_info`, `add_payment_info`
- `purchase`
- `add_to_wishlist` (needs Commerce Wishlist)
- `login`, `sign_up`

The checkout-step events (`begin_checkout`, `add_shipping_info`,
`add_payment_info`) are detected by checkout step, and the module avoids re-firing
them on AJAX refreshes.

## Map item parameters to tokens

Beyond the core fields the module maps automatically (SKU, title, price, quantity,
affiliation, promotions, coupons), you can add any GA4 item parameter and point it
at a product or variation field using a **token**. A built-in token browser helps
you pick the right one. Common examples:

- `item_brand` → a product brand field
- `item_variant` / `item_size` → variation attribute fields
- any custom parameter name you like → any product/variation token

There are no fixed slots — you name the parameter and choose the token.

### Hierarchical categories

For `item_category`, you can have the module walk **up to three parent levels** of
a taxonomy term reference, filling `item_category`, `item_category2` and
`item_category3` from a category tree automatically.

## Exclude roles from tracking

You can exclude selected roles (for example staff or administrators) so their
browsing and test orders never reach GA4. Tick the roles to skip.

## Good to know

- **Discount-aware prices.** Reported unit prices are the promotion-adjusted
  prices, and coupon codes plus promotion id/name are captured per line item, so
  GA4 reflects what the customer actually paid.
- **Privacy.** The `login` event carries a SHA-256 hash of the user's email (for
  GA4 user identification), not the raw address. As with any analytics that sends
  data to Google, obtain the appropriate consent and disclose the tracking for
  your jurisdiction.
- **You still need a tag manager.** This module only fills `window.dataLayer`; a
  separately configured GTM or gtag.js is what actually sends the data to Google.

## Save

Click **Save configuration**. Then verify in the browser console that
`window.dataLayer` receives the events you enabled as you browse, add to cart, and
check out.
