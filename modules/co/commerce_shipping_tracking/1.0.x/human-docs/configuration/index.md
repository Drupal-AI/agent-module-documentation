# Configuration

Commerce Shipping Tracking needs a short setup before customers can use it: map
your shipment workflow states to readable labels, choose the messages the form
shows, place the lookup block, and review who is allowed to use it.

## Open the settings form

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Shipping → Order Tracking Settings**, or
   navigate directly to `/admin/commerce/config/shipping_tracking`.

## Map shipment states to labels

The core of the configuration is mapping the **machine names** of your shipping
workflow states to the **labels** you want customers to see. Enter one mapping per
line in the form `machine_name|Label` — for example `draft|Preparing...` or
`shipped|On its way`. For each state in the shipment workflow (for example a
"shipped" or "ready for delivery" state), give the friendly text that should be
displayed when an order is in that state, so cover the states customers care about.

## Success and error messages

Configure the two messages the lookup form uses:

- **Success message** — shown when a matching order is found and its shipment
  status can be reported.
- **Error message** — shown when the lookup does not return a status (no order with
  that number, the submitted email does not match the order's email, or the order
  has no shipment yet). The same message covers all of these cases.

Click **Save configuration** when done.

## Place the tracking block

The customer‑facing lookup form is provided as a **block**. To show it:

1. Go to **Structure → Block layout**.
2. In the region where you want the form, click **Place block** and choose the
   Commerce Shipping Tracking block.
3. Configure the block's visibility (which pages it appears on) and save.

## Permissions

The module provides one permission, **Access Commerce Shipping Tracking Settings
Page** (`access commerce shipping tracking settings`), which controls access to the
configuration page you are reading about here. Review it at **People →
Permissions** and grant it only to the administrative roles that should manage the
tracking settings.

The customer-facing lookup form (the block and its standalone page) is not gated
by this permission — it is meant to be reachable by the customers who need to check
their orders. Its access control is built into the lookup itself: a status is
returned only when the visitor supplies both a valid **order number** and the
**email address that was used on that order**, and only a mapped shipment-state
label is shown — never the order's contents.

## How the lookup identifies a customer

When a visitor submits the form, the module looks up the order by its number and
returns a status only if the submitted email matches that order's own email and the
order has a shipment. The single configurable error message is returned for every
unsuccessful case (unknown order number, mismatched email, or no shipment yet), so
the form behaves the same way whichever condition applies.
