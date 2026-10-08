# Configuration

Commerce NZ Post is configured **per shipping method** — its one real setting is the
NZ Post API key, entered on the shipping method itself. There is no separate global
settings page.

## Store your API key securely

Your NZ Post API key is a credential — avoid committing it in exported
configuration. With DDEV you can keep it in an environment variable and override the
setting per environment (for example via `settings.php`), so the raw key stays out
of version control:

```bash
ddev dotenv set .ddev/.env --nzpost-api-key=<value>
ddev restart
```

## Add the NZ Post shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and add a shipping method (or edit an
   existing one).
2. Choose the **NZ Post** plugin.
3. Enter your **NZ Post API key**.
4. Save.

You can add NZ Post as one of several shipping methods on a shipment type.

## Make sure packages have dimensions and weight

The rate request is built from the shipment's package dimensions (length, height,
width — converted to millimetres for the API), weight (in kilograms), declared value
and destination country. Configure your package types with dimensions and weight so
the quote is accurate.

## How it behaves

At checkout the module sends the parcel details and your API key as a query to
`https://api.nzpost.co.nz/ratefinder/international.json` over HTTPS (via Guzzle) and
maps the returned products into Commerce shipping rates, one per NZ Post service
code, for the shopper to choose from.

Two behaviours to expect:

- **Domestic (NZ) destinations return no rates by design.** This method is for
  international shipments only, so pair it with another method for domestic orders.
- **Empty shipping addresses are handled gracefully** — no rates are returned until
  there's a destination to quote.

Request failures are logged via `watchdog_exception`. (A minor code note from the
review: an exception class is caught without its `use` import — a robustness detail,
not a security issue.)

## Note on the price field

The module supports both a price and a price-including-GST field, so you can present
GST-inclusive pricing where appropriate.
