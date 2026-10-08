# Configuration

Commerce XPS is configured as a Commerce shipping method. You create a shipping
method that uses the XPS plugin and enter your XPS API credentials.

## Create the XPS shipping method

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Shipping methods → Add shipping method**
   (`/admin/commerce/config/shipping-methods/add`).
3. Give the shipping method a name and select **XPS Shipping** as the plugin.

## Shipping‑method settings

- **XPS API key** — the API key from your XPS account. This is a secret value.
- **Customer / account identifiers** — your XPS customer ID and any related
  account identifiers XPS requires to look up rates.
- **Conditions** — as with any Commerce shipping method, you can restrict when
  this method is available (for example by store, order total, or address) using
  the standard Commerce Shipping conditions.

Once saved, XPS rates are requested at checkout based on the order's weight,
dimensions, and destination address, and the returned carrier/service rates
appear as selectable options in the checkout shipping pane. If the API call fails
the method degrades gracefully (no rate is offered).

## Add more carriers

USPS is available by default. To offer FedEx, UPS, or other carriers, add those
carrier accounts in your XPS account settings (the provider‑accounts page in the
XPS dashboard); the extra services then flow through the same XPS shipping method.

## Handle the API key safely

The XPS API key is a secret. Never commit it to code. On DDEV, store it in an
environment variable and reference it through a **Key** entity where the field
allows, rather than pasting it into exported configuration:

```bash
ddev dotenv set .ddev/.env --xps-api-key=<value>
ddev restart
```

Always serve the site over **HTTPS**.

## Save and test

Click **Save**. Add a shippable product to the cart, proceed to checkout with a
real destination address, and confirm live XPS rates appear. Test against the XPS
sandbox before go‑live.
