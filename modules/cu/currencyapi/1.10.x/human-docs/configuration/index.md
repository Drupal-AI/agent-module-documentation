# Configuration

Currency API does nothing until you configure it. Configuration lives on the
**Currency API settings** form (config object `currencyapi.settings`), reached
from the **Configuration** section of the admin menu. You'll set three things: the
API connection, your markup rules, and the currencies and refresh schedule.

## 1. Connect to the API

- **API base URL** — the currencyapi.com endpoint the module calls (it fetches
  from `https://api.currencyapi.com/v3/latest`). Leave the default unless you have
  a reason to change it.
- **API key** — your currencyapi.com key. A free tier is available. This is the
  credential that authorizes the rate lookups.

The connection is made over **HTTPS**, and the module does not disable TLS
verification, so the certificate is checked (good).

### Handling the API key as a secret

The key is sensitive, so don't commit it to your configuration in plain text. The
recommended pattern with DDEV:

1. Store the value in an environment variable via DDEV's dotenv helper (this file
   is not committed):

   ```bash
   ddev dotenv set .ddev/.env --currencyapi-key=YOUR_KEY_HERE
   ddev restart
   ```

2. Reference it from Drupal rather than pasting it into exported config — for
   example through the [Key](https://www.drupal.org/project/key) module's
   environment provider, or from `settings.php` with `getenv('CURRENCYAPI_KEY')`.

Two cautions worth knowing: the key is passed in the request URL, and
**URL‑embedded keys can surface in server or proxy logs**, so restrict who can
read those logs. And connecting to an external service means your site makes
**outbound (egress) requests** to currencyapi.com — make sure your hosting allows
that.

## 2. Set your markup rules

This is the module's distinctive feature — the customer‑facing rate you show can
differ from the raw market rate:

- Apply **fixed fees**, **percentage‑based markups**, or **blended/tiered rates**
  to buy/sell prices.
- The displayed rate tables then show your adjusted values, so you can transparently
  present, say, a 2% margin or a flat conversion fee.

Configure the markup model that matches how you price conversions.

## 3. Choose currencies and refresh interval

- **Currencies** — select which of the 150+ supported currencies (optionally
  including crypto/fiat pairs) to fetch and display, and how to group them.
- **Refresh interval** — how often the cron‑driven update fetches fresh rates.
  Smart caching reduces API calls between refreshes, so pick an interval that
  balances freshness against your API plan's request limits.
- **Formatting** — decimals and rounding for how rates are displayed.

## 4. Save and display

Save the form. After the next cron run, rates are fetched and cached. You can then
surface them anywhere — a **block**, a **View**, or a **template** — on product
pages, checkout flows, or financial dashboards.
