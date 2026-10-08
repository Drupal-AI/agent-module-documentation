# Configuration

Commerce USPS has no standalone settings page. You configure it by creating a
Commerce **Shipping method** and choosing a USPS plugin. All of USPS's options
live on that shipping method.

## Create a USPS shipping method

1. Go to **Commerce → Configuration → Shipping → Shipping methods** and click
   **Add shipping method** (`/admin/commerce/config/shipping-methods/add`).
2. Give it a name (e.g. "USPS") and, if you run multiple stores, assign the
   stores it applies to.
3. Choose the **plugin**:
   - **USPS** (`usps`) for domestic (US) shipments, or
   - **USPS International** (`usps_international`) for shipments leaving the US.
4. Fill in the sections below, then **Save**. You can add both a domestic and an
   international method to the same store if you ship both ways.

## API information

This is where your USPS OAuth credentials go:

- **Consumer key** — your USPS API "client id".
- **Consumer secret** — your USPS API secret.
- **Mode** — **Test** (sandbox) or **Live**. Start in **test** with sandbox
  credentials, confirm rates come back sensibly at checkout, then edit the method
  and switch to **live**.

Both the key and secret are required, and they are validated — an incorrect pair
produces the error *"Invalid Consumer key or Consumer secret specified."*

> **Keep your API secret out of version control.** The Consumer secret is a
> credential. If you export site configuration (`drush cex`) and commit it, the
> secret would land in your repository. Follow this project's secrets practice:
> store the value in an environment variable via DDEV's dotenv
> (`ddev dotenv set .ddev/.env --usps-consumer-secret=<value>`, then
> `ddev restart`), keep `.ddev/.env` out of version control, and avoid committing
> the shipping-method config with the live secret in place. Populate the real
> credentials on the production site only.

## Services

Each plugin offers a fixed menu of USPS services; tick the ones you want to make
available at checkout:

- **USPS Domestic** — Priority Mail, Priority Mail Express, USPS Ground Advantage,
  Parcel Select, Media Mail, Library Mail, Bound Printed Matter, USPS Connect
  (Local / Regional / Mail), and return-service variants.
- **USPS International** — Global Express Guaranteed, Priority Mail International,
  Priority Mail Express International, and First-Class Package International
  Service.

Restrict the list to just the services you actually offer (for example only
Priority Mail plus Ground Advantage) so shoppers aren't shown options you don't
use.

## Rate options

Fine-tune how rates are calculated and priced:

- **Price type** — **Retail** (published USPS prices) or **Contract** (your
  negotiated / NSA pricing).
- **Contract account details** — when using contract pricing, supply your USPS
  **account type**, **account number**, and **CRID** (Customer Registration ID),
  plus the relevant processing categories, rate indicators, and destination-entry
  (facility type) options for presorted contract mailings.
- **Rate multiplier** — multiply the returned USPS rate to mark it up or discount
  it (e.g. `1.1` adds 10%).
- **Rounding** — round the calculated shipping rate to a precision you choose.

## Other options

- **Tracking URL** — a template used to build order tracking links. It defaults
  to the standard USPS tracking URL with a `[tracking_code]` placeholder; change
  it only if you need a custom tracking destination.
- **Log request / Log response** — two toggles that record the outgoing API
  request and the USPS response to the log. Turn these on temporarily when you're
  debugging unexpected rates, then off again in normal operation (they can be
  noisy and may record address data).

## Package types

The module registers USPS flat-rate boxes (Large / Medium / Small Flat Rate Box,
plus a top-loading Medium) as Commerce package types, each tied to the USPS
shipping method. Select one as the method's default package type if your products
ship in USPS flat-rate boxes; otherwise combine with Commerce's own package types
for weight/dimension-based packing.

## Test before going live

Leave the method in **test** mode and place a test order to confirm USPS returns
rates for your enabled services and destinations. Once verified, edit the method,
switch **mode** to **live**, and (on production) enter your live credentials.
