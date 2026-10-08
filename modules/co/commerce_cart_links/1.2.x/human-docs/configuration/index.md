# Configuration

Commerce Cart Links has a settings form plus a small set of permissions, and then
the real work happens in the **link URLs you build**. This page covers all three.

## Open the settings form

1. Log in as a user with the **`administer commerce_cart_links`** permission.
2. Go to **Commerce → Configuration → Orders → Cart Links**, or navigate directly
   to `/admin/commerce/config/orders/cart-links`.

The form controls how `/cart-links` requests are accepted — most importantly the
**allowed referers**, which is the module's main defence against other sites
firing cart manipulations at your customers.

## The referer check — the setting to get right

When a browser follows a `/cart-links` URL, the module checks the request's HTTP
**referer** (the page the click came from) against your allowed list before it
touches the cart. This stops an arbitrary third‑party site from crafting links
that empty or fill your customers' carts.

The catch: **a referer is frequently absent entirely**. Many email clients strip
it, QR‑code scans have no referring page, and any link marked `noreferrer` sends
nothing. If your campaign relies on those channels and the allowed‑referer setting
doesn't account for them, the links will **silently return a 403** and customers
will just see an access‑denied page. So before you launch: decide which channels
the links must work from, and confirm the referer configuration covers them (or
allows an empty referer where appropriate). Test each channel — a real email, a
real QR scan — not just a click from your own site.

## Permissions

Set these under **People → Permissions**:

- **`view commerce cart links`** — lets a role follow `/cart-links` URLs. Grant to
  anonymous and/or authenticated as your campaigns require.
- **`generate cart share links`** — lets a role open the share‑cart modal and
  create a link to their own cart (the B2B "send my basket to a colleague" flow).
- **`administer commerce_cart_links`** — restricted; controls access to this
  settings form. Administrators only.

## Building cart-link URLs

All links start at `/cart-links` and are followed by one or more product
arguments, plus optional query parameters:

- **Add products** — each argument is a variation id and quantity joined by a
  hyphen. `/cart-links/57-2` adds two of variation 57;
  `/cart-links/57-2/384-1` adds two of 57 and one of 384.
- **Override the entity type** — append it as a third segment, e.g.
  `/cart-links/57-2-commerce_product_variation`, or set a default for the whole
  link with `?default_entity_type=…` (defaults to `commerce_product_variation`).
- **`?destination=/some/path`** — redirect the customer to a specific URL after
  the cart is processed. Omit it and they land on the cart form.
- **`?store=#`** — force a specific store when resolving or creating the cart.
- **`?coupon_code=#`** — automatically apply a coupon when the products are added.
- **`?existing=new`** — create a brand‑new cart for this link without touching any
  cart the user already has.
- **`?existing=empty`** — empty the customer's existing cart before adding the new
  products.
- **`?existing=delete`** — **delete** the customer's existing cart(s) before
  processing. This throws away what they already had, so use it deliberately, and
  think twice before putting it in a broad campaign link.

If `existing` is not set, the module simply adds the products to whatever cart is
resolved for the user. On multi‑store sites, or sites where users juggle several
carts, be aware that a cart link bypasses the normal store‑resolution process and
can behave unexpectedly — test those flows before going live.

## Security notes worth surfacing

- The **referer check is a real access control**, but it is only as good as your
  allowed‑referer configuration — and it fails "closed" (403) when a referer is
  missing. Plan for the channels that send no referer.
- **`existing=delete` is destructive** to the customer's current cart. Reserve it
  for links where that is genuinely intended.
- The redirect handling forces a leading `/` on the `destination` value and relies
  on Drupal core to block open redirects, so `destination` cannot be pointed at an
  external site; a malformed value results in an error page rather than a redirect.
