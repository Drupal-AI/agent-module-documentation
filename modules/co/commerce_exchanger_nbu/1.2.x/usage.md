<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds the National Bank of Ukraine (NBU) as a currency exchange-rate provider for the Commerce Exchanger framework, fetching official rates from the NBU public API so Drupal Commerce can convert prices.

---

Commerce Exchanger NBU is a thin provider plugin for the `commerce_exchanger` module. It contributes one exchange-rate source — "National Bank of Ukraine" (plugin id `nbu`) — whose base currency is the Ukrainian hryvnia (UAH). When selected in Commerce Exchanger and refreshed (on cron), the plugin makes a single unauthenticated HTTPS GET to the NBU statistics endpoint (`https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json`), decodes the JSON, and maps each currency code to its rate. All the heavy lifting — storing the latest rates, keeping historical snapshots, cross-sync recalculation between enabled currencies, and the provider settings form — is inherited from Commerce Exchanger; this module only defines the endpoint and how to read its response. Installation is blocked unless the UAH currency is enabled. There are no credentials, no API key, no routes, and no admin UI unique to this module.

---

- Source official Ukrainian exchange rates from the National Bank of Ukraine for Drupal Commerce.
- Add "National Bank of Ukraine" as a selectable provider inside Commerce Exchanger.
- Convert store prices to and from UAH using rates published by the central bank.
- Fetch rates automatically on cron via Commerce Exchanger's refresh mechanism.
- Keep historical rate snapshots (the plugin declares `historical_rates = TRUE`).
- Cross-sync rates across all enabled currencies (the framework recalculates from the UAH base).
- Run without any API key, account, or credentials — the NBU endpoint is public.
- Fetch over hardcoded HTTPS with normal TLS certificate verification.
- Avoid a bespoke settings form — configure it through Commerce Exchanger like any other provider.
- Guard installation so it only proceeds when the UAH currency is present.
- Serve Ukrainian and UAH-denominated Commerce stores that need authoritative local rates.
