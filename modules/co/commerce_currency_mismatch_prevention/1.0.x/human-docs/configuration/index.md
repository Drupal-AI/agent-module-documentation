# Configuration

This module has a single, small settings form where you choose what should happen
when a shopper tries to add a product priced in a different currency than the
items already in their cart.

## Open the settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Commerce → Configuration → Store → Currency mismatch prevention**.

## Choose a behavior

The form offers three options for handling a currency conflict:

- **Remove new product, keep current cart items** — the product the shopper just
  tried to add is removed, and the existing cart is left untouched. Choose this if
  you want to protect whatever is already in the cart.
- **Remove existing cart items, add new product** — the cart is cleared and the
  newly added product takes its place. Choose this if you would rather let the
  shopper switch to the new item and start fresh in its currency.
- **Disabled** — allow products with different currencies to be added. This lets
  the underlying currency‑mismatch error occur again, so only use it if you are
  handling the conflict some other way.

## Save

Click **Save configuration**. The chosen behavior applies immediately the next
time a shopper adds a product whose currency does not match the cart.
