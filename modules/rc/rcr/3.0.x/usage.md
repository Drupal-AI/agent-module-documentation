<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
RCR retrieves USD and EUR exchange rates against several CIS currencies (Russian ruble, Kazakh tenge, Kyrgyz som, Azerbaijani manat, Belarusian ruble, Ukrainian hryvnia) from each country's national-bank feed and renders them in a block.

---


`RcrService` fetches XML/RSS from fixed national-bank URLs (e.g. cbr.ru, nationalbank.kz, nbkr.kg, cbar.az, nbrb.by, bank.gov.ua) with `file_get_contents`, parses the rates, and stores them in State keyed by country. The settings form (`/admin/config/system/currency-settings`, permission `change currency rate`) selects the country, update type (cron or manual), and optional manual rate and commission. Rates refresh on cron or via the `drush rcr-getrates` command. A `RatesBlock` displays the current USD/EUR values, optionally with a configured commission markup.

Setup: enable the module, configure country/update type at the settings form, run cron (or the drush command), then place the RCR block in a region.
---
- Show USD/EUR rates against a CIS currency in a block.
- Choose the source country/national bank.
- Fetch rates from the central bank XML feed.
- Update rates automatically on cron.
- Update rates manually via `drush rcr-getrates`.
- Enter a manual override rate.
- Add a commission markup to displayed rates.
- Place the rates block in any region.
- Store fetched rates in State per country.
- Restrict settings with `change currency rate`.
- Display the Russian ruble reference rates (cbr.ru).
- Display Kazakh tenge rates (nationalbank.kz).
- Display Kyrgyz som rates (nbkr.kg).
- Display Azerbaijani manat rates (cbar.az).
- Display Belarusian ruble rates (nbrb.by).
- Display Ukrainian hryvnia rates (bank.gov.ua).
- Switch between cron and manual update modes.
- Refresh rates on demand from the CLI.
