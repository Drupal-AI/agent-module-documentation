# Configuration

Setting up the checkbox is a two‑step job: place the pane on a checkout flow, then
configure the pane's fields.

## 1. Place the pane on a checkout flow

1. Log in as an administrator.
2. Go to **Commerce → Configuration → Checkout flows**
   (`/admin/commerce/config/checkout`) and edit the checkout flow you want the
   checkbox to appear in.
3. Find the **Commerce Checkbox Checkout Pane** among the available panes and drag
   it into the checkout step and position where it should show (for example, in
   the review step just before the customer completes the order).
4. Save the checkout flow.

## 2. Configure the pane

Edit the pane's settings at
`/admin/commerce/config/checkout/form/pane/commerce_checkbox_checkout_pane` (or via
the pane's configure link on the checkout flow). The fields are:

- **Key / ID** — the machine key under which the checkbox value is saved on the
  order, i.e. `$order->data[KEY]`. Choose a stable, descriptive key (for example
  `share_email_with_shipper`), because other code, exports, or reports will read
  the customer's choice from this key. Avoid changing it later once orders have
  been saved with it.
- **Title** — the heading shown for the pane (typically rendered as a fieldset
  label above the checkbox).
- **Checkbox label** — the text next to the checkbox itself, i.e. what the customer
  is agreeing to ("I accept the terms and conditions", "Share my email with the
  courier", and so on).
- **Description** — optional help text shown with the checkbox to explain the
  choice.
- **Required** — when enabled, the customer must tick the box before checkout will
  proceed. Leave it off for a genuine opt‑in; turn it on for mandatory
  acknowledgements such as terms acceptance.

Save the pane, then run a test checkout to confirm the wording reads well and that
the required behaviour (if set) blocks completion until the box is ticked.

## Where the value ends up

The customer's choice is stored on the order under the key you set, in
`$order->data[KEY]`. That makes it available to fulfilment logic, order reports, or
any custom code that needs to know whether the customer ticked the box. The module
does no access control and takes no action on the value itself — it simply records
the choice on the order for you to use.
