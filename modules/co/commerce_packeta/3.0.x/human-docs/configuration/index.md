# Configuration

Commerce Packeta is configured as a Drupal Commerce **shipping method** — all of its
settings live on that method, not on a separate page.

## Before you start

- A **Packeta (Zásilkovna) account** with an **API password** and your **e-shop
  identifier**.
- Your **customer profile** must have a field that stores the **phone number** (you
  select it below); Packeta needs a phone number to process a packet.
- Your **products must have weights** populated — Packeta rejects packets without a
  weight, and weights are submitted in kilograms. The
  `commerce_packeta_views` submodule gives you a bulk editor for this.

## Add the Packeta shipping method

1. Go to your shipping methods (**Commerce → Shipping methods**, e.g.
   `/admin/commerce/shipping-methods`) and add a new shipping method.
2. Choose the **Packeta** plugin.
3. Fill in the plugin settings:
   - **API password** — your Packeta API password. This authenticates the SOAP
     call that creates the packet.
   - **E-shop URL / identifier** — your Packeta e-shop id, sent as `eshop` so
     Packeta knows which store the packet belongs to.
   - **Phone field** — the profile field on the billing profile that holds the
     customer's phone number, read into the packet payload.
4. Save the shipping method and attach it to the shipping needs of your store /
   checkout flow as usual.

## Wire the pickup-point widget into checkout

In 3.x the pickup-point selector is integrated into the **default shipping
information pane**: the customer enters a shipping address first, then selects
Packeta as the shipping method and chooses a pickup point. Make sure your checkout
flow renders the shipping information pane so the selector appears and the chosen
pickup point is saved on the shipment.

## What gets sent to Packeta

When an order is processed, the module builds the packet from the order and its
billing profile — order number, recipient email and phone, currency, order value
(plus the cash-on-delivery value for COD orders), weight converted to kilograms, the
selected pickup-point id, and your e-shop id — and calls Packeta's SOAP endpoint,
authenticating with your API password. It returns the created packet id. If the SOAP
call fails, the fault is caught and logged to the `commerce_packeta` log channel, so
check **Reports → Recent log messages** when troubleshooting.

## Keep your API password safe

The API password is a credential. Restrict who can administer shipping methods, and
be mindful that it is part of the shipping-method configuration — protect config
exports and access accordingly, and avoid committing exported configuration that
contains it to a public repository. Where your workflow allows, keep the real secret
out of version control (for example by injecting it through your environment and
config-split / overrides rather than hard-coding it into committed config).

## Helper View for weights (submodule)

If you enabled **Commerce Packeta Views** (`commerce_packeta_views`, needs
`views_bulk_edit`), use the product-variation View it provides to bulk-set product
weights — a quick way to satisfy Packeta's weight requirement across your catalog.
