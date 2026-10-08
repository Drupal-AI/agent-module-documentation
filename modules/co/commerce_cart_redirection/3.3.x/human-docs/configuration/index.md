# Configuration

Everything Commerce Cart Redirection does is controlled from one settings form.
Until you save it once, nothing is redirected.

## Open the settings form

1. Log in as a user with the **Configure commerce cart redirection** permission
   (an administrator by default). You can grant this permission to a store
   manager so they can maintain the rules themselves.
2. Go to **Commerce → Configuration → Orders → Cart redirection**, or navigate
   directly to `/admin/commerce/config/commerce_cart_redirection`.

## Which products trigger a redirect

- **Product variation types** — a set of checkboxes listing your product
  variation types (bundles). Tick the ones that should send the shopper away
  after being added to the cart. For example, tick only "Event ticket" if you
  want tickets to skip the cart but ordinary merchandise to behave normally.

  > Note: despite reading like "products", these checkboxes are your product
  > *variation* types — the variations that are actually added to the cart.

- **Negate the bundles condition** — a checkbox that flips the logic. When
  ticked, the redirect fires for **all** variation types *except* the ones you
  checked above. This is handy when it is easier to list the exceptions than the
  matches. (Note: ticking every type *and* also negating cancels out, so nothing
  redirects.)

## Where to send the shopper

- **Redirection target** — choose one of:
  - **Checkout** *(default)* — send the shopper straight to the checkout form.
    (If the Commerce Checkout module is not available, this falls back to the
    site's front page.)
  - **Cart** — send them to the cart page.
  - **Other** — send them to a custom URL that you type in the next field.
- **Other URL** — the address to redirect to when the target is **Other**. This
  can be an internal path or an external URL such as a thank‑you page, an upsell
  page, or a hosted payment page. It is checked only for being a valid‑looking
  URL, so make sure it actually points where you intend.

## Advanced: clear the cart first

- **Clear cart before add** — when turned on, every other item already in the
  cart is removed before the new product is added, so the shopper ends up
  checking out with just that one item. This is what powers single‑item checkout
  kiosks, "one product at a time" carts, and donation‑style flows where each
  selection replaces whatever was there before.

## Match the button to the behavior

- **Add to cart replacement text** — text that replaces the **Add to cart**
  button label, but only for the variations that will be redirected. Set it to
  something like "Buy now" or "Proceed to checkout" so the button matches the
  skip‑the‑cart behavior. Leave it empty to keep the default "Add to cart" label.

## Save

Click **Save configuration**. Your rules take effect immediately: adding a
matching product now redirects the shopper to your chosen destination.
