Currency API fetches exchange rates from CurrencyAPI.com on cron and displays them, with optional per-currency percentage markup for buy/sell pricing.

---

The module stores a CurrencyAPI.com API key and a comma-separated currency list in the `currencyapi.settings` config object. On cron (at most once every 24 hours) it calls `https://api.currencyapi.com/v3/latest` with `file_get_contents()` and saves the returned rate data into the expirable key/value collection `currencyapi.com` under key `rates`. The `currencyapi.service` service reads those rates and offers `getAllRates()`, `convert()`, and a markup-aware `sell()`. An admin settings form lets you enter the key, the currency list, and a per-currency buy-rate percentage (`buyrate_<CODE>`), and shows a computed buy/income table. Three content routes render the data: `/currency-rates` (rate table), `/buy-100` (a "Buy 100 <store currency>" markup page), and `/currency-rates/json/{key}` (raw rates as JSON). Note this is an early, partial release: several service methods are empty stubs, the shipped install config object is named `currency.api.settings` while the code reads `currencyapi.settings`, the `currency_rates_block` block references a `currencyapi.client` service/class that the module does not ship, and the page controller hard-calls Drupal Commerce's `commerce_store.current_store`, so the content pages require Commerce even though it is not a declared dependency. Treat it as a starting point that needs configuration and code review before production use.

---

- Fetch daily exchange rates from CurrencyAPI.com automatically via Drupal cron.
- Store a base + target currency set as a single comma-separated list (e.g. `EUR,GBP,JPY,CAD`).
- Read the full stored rate set programmatically with `\Drupal::service('currencyapi.service')->getAllRates()`.
- Convert an amount between two currencies with `->convert($amount, $from, $to)`.
- Compute a sell price that adds a per-currency percentage markup with `->sell($amount, $in, $out)`.
- Configure the API key and currency list at `/admin/config/services/currency-api`.
- Enter a per-currency buy markup percentage (`buyrate_<CODE>`) in the settings table.
- Show a customer-facing rate table at `/currency-rates`.
- Display a "Buy 100 <currency>" markup pricing page at `/buy-100` (requires Commerce store).
- Expose stored rates as JSON to other apps at `/currency-rates/json/{key}`.
- Drive multi-currency pricing displays on a financial or FX-broker site.
- Add a transparent FX fee / margin to displayed conversion rates.
- Override the three Twig templates (`currency-rates`, `buy-100`, `currency-exchange`) to theme rate output.
- Trigger a rate refresh by running cron (`drush cron`) after the 24-hour interval elapses.
- Read the timestamp of the last successful fetch from the `last_update` config value.
- Use the rates in a custom controller or service to price products in the visitor's currency.
- Cache the fetched rate set in the expirable key/value store to limit API calls.
- Seed a proof-of-concept currency dashboard for a Drupal 10.2+/11 site.
- Extend the stub methods (`getRate()`, `getSystemCurrencies()`) to fit a bespoke pricing model.
- Evaluate CurrencyAPI.com integration before committing to a Commerce-native exchange module.
- Attach the module's CSS libraries (`settings-form`, `currency-exchange`) to style the tables.
