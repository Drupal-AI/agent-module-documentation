# Configuration

You configure Commerce Agree to Terms as a **checkout pane** on whichever Commerce
checkout flow you use. There is no separate settings page.

## 1. Add the pane to your checkout flow

1. Go to **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout-flows`).
2. Click **Edit** on the flow your store uses (often the *Default* flow).
3. In the list of panes, find **Agree to the terms and conditions** and drag it
   into the step where you want it to appear. It defaults to the **Review** step,
   which is a natural spot right before the customer completes the order.
4. Click the pane's **Edit** (or its settings/cog) to open its configuration form,
   then fill in the fields below.

## 2. Pane settings, field by field

- **Terms and Conditions page** (`nid`, *required*) — start typing the title of
  the node you want the checkbox to link to and pick it from the autocomplete. This
  is the page the customer sees when they click the link (for example your Terms &
  Conditions or Privacy Policy node). The checkbox will not render at all until
  this is set.
- **Link text** (`link_text`, *required*) — the visible, clickable text of the
  link. Defaults to *Terms and Conditions*.
- **Prefix text** (`prefix_text`) — the checkbox label wording. It contains a
  special token, **`%terms`**, which is replaced by the link at display time.
  Default: `I agree with the %terms`. So with the defaults, the label reads
  "I agree with the *Terms and Conditions*" where the italic part is the link.
- **Description** (`description`) — optional help text shown under the checkbox.
  Leave it blank if you don't need it.
- **Invalid text** (`invalid_text`) — the error message shown if the customer
  tries to continue without ticking the box. It also supports the `%terms` token.
  Default: `You must agree with the %terms before continuing`.
- **Open in new window** (`new_window`) — when ticked (the default), the terms link
  opens in a new browser tab so the customer doesn't lose their place in checkout.
  Untick it to open in the same window.

Save the checkout flow when you are done.

## 3. What the customer sees

On the checkout step you chose, the customer sees a required-style checkbox with
your wording and a link to the terms page. If they try to complete the order
without ticking it, the module sets a form error using your **Invalid text**
message and stops checkout from proceeding — so consent is always captured before
an order can be placed.

## Tips

- **Multiple flows** — if you run several checkout flows, add and configure the
  pane separately in each; every flow can point at a different terms node and use
  different wording.
- **Swapping the terms page** — to change which page the checkbox links to, just
  re-point the **Terms and Conditions page** field at a different node; you don't
  need to republish anything.
- **Combine with other panes** — the terms pane sits happily alongside the
  contact-information, coupon, and payment panes on the same step.
