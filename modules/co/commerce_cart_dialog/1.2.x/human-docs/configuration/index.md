# Configuration

Commerce Cart Dialog has a small settings form plus a block/link you place to
trigger the dialog.

## Open the settings form

1. Log in as a user with the **access commerce administration pages** permission.
2. Go to **Administration → Commerce → Configuration → Cart Dialog**, or navigate
   directly to `/admin/commerce/config/ccd`.

## Choose the dialog type

The main setting is the **dialog type** — how the cart appears when opened:

- **Modal** — the cart opens in a centered popup that overlays the page.
- **Off‑canvas** — the cart slides in from the side as a panel.

Pick the style that fits your theme, set any related dialog options the form
offers, and **Save**.

## Place the cart trigger

You have two ways to let shoppers open the cart dialog:

- **Cart trigger block** — go to **Structure → Block layout**, place the **Cart
  Dialog** block in a region (for example the header), and save. Clicking it opens
  the cart in your chosen dialog type.
- **Menu link** — add a link to the path `/cart/dialog` in any menu. Clicking it
  opens the cart in a dialog.

## How it behaves

When a shopper opens the dialog, it renders the standard Commerce cart. Updating a
quantity or removing an item submits over Ajax and refreshes the dialog contents
(status messages included); after an update the dialog can reload or close
according to the dialog type. The full cart page remains available alongside the
dialog.

## Access note

The `/cart/dialog` route is public (`_access: TRUE`), exactly like core Commerce's
own cart page. This is expected and safe: the route takes **no cart or order ID**
and only ever operates on the **current** session/user's cart, so exposing it to
anonymous shoppers does not let anyone reach another user's cart. The settings
form is separately gated behind the admin permission.
