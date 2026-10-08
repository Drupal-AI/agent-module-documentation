# Configuration

Commerce UPS is configured as a Commerce **shipping method**, not from a
standalone settings page. Everything below lives on the UPS shipping method form.

## Add the UPS shipping method

1. Log in as a user who can administer Commerce shipping.
2. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/config/shipping-methods`) and click **Add shipping method**.
3. Give the method a name (for example "UPS"), then in the **Plugin** select
   choose **UPS**. The UPS-specific fields appear.

The form is grouped into API information, rate options, and options. When you
save, the module immediately requests a UPS OAuth2 access token to verify your
credentials — a success message reads "Connectivity to UPS successfully
verified", and a failure flags the Client ID / Client Secret with "Invalid Client
ID or Client Secret specified."

## API information

These fields are all required — they are your UPS API credentials.

- **Account number** — your UPS account number.
- **Client ID** — the Client ID from your UPS developer application.
- **Client Secret** — the Client Secret from the same application. Treat this like
  a password; see the [installation notes](../installation/index.md) on keeping it
  out of exported config.
- **Mode** — choose **Test** while you set things up (UPS integration endpoint) or
  **Live** for production (UPS production endpoint). Rates from the test endpoint
  are for validation only.

## Rate options

- **Rate type** — choose **Standard** (UPS published rates) or **Negotiated**
  (your account-specific contract rates). Negotiated rates require that your UPS
  account is enabled for them.
- **Rate multiplier** — every rate UPS returns is multiplied by this number
  (default `1.0`, minimum `0.1`). Use it to add or remove a margin — for example
  `1.5` marks shipping up to 150% of the UPS price, `0.9` discounts it to 90%.

## Options

- **Tracking URL** — a template used to build a clickable tracking link for a
  shipment. The token `[tracking_code]` is replaced with the shipment's tracking
  number (if you omit the token, the code is simply appended). The default is
  `https://wwwapps.ups.com/tracking/tracking.cgi?tracknum=[tracking_code]`.
- **Rounding** — how calculated rates are rounded: half up, half down, half even,
  or half odd.
- **Logging** — two checkboxes let you log the UPS API **request** and/or
  **response** messages to Drupal's log (the `commerce_ups` channel). Turn these
  on only while debugging a rate problem, then turn them off — responses can be
  verbose.

## Choosing which UPS services to offer

Below the UPS-specific settings, the standard Commerce shipping **services**
checkboxes let you pick which UPS services customers may see — Next Day Air,
Ground, Worldwide Express, Saver, Standard, and so on. All are selected by
default; untick any you don't want to offer.

## Package types

Commerce UPS installs the standard UPS package definitions — 10KG box, 25KG box,
large/medium/small express boxes, and the express tube, each with proper
dimensions and weights. Pick a **default package type** for the method so UPS has
something to rate when a shipment doesn't specify one.

## Saving and testing

Click **Save**. Because the module verifies connectivity on save, a green
confirmation means your credentials and mode are working. Then place a test order
with a shippable product (one that has weight and dimensions) and a valid
shipping address to see live UPS rates at checkout.

> **Tip:** rate responses are cached for one hour, and OAuth tokens are reused
> until they expire, so occasional stale-looking rates during testing are normal.
> A cache rebuild clears cached rates.
