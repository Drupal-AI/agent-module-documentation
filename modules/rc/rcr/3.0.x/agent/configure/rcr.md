<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure & operate RCR

## Settings
Route `rcr.currency_settings` → `/admin/config/system/currency-settings`
(permission `change currency rate`). Options: **country**, **update type** (cron/manual),
**currency type**, optional **manual rate** and **commission** (stored in State/config).

## Rate sources (fixed URLs in `RcrService`)
- Russia: `cbr.ru/scripts/XML_daily.asp`
- Kazakhstan: `nationalbank.kz/rss/rates_all.xml`
- Kyrgyzstan: `nbkr.kg/XML/daily.xml`
- Azerbaijan: `cbar.az/currencies/{date}.xml`
- Belarus: `services.nbrb.by/xmlexrates.aspx`
- Ukraine: `bank.gov.ua/NBUStatService/v1/statdirectory/exchange`

All URLs are hardcoded (no user input) — no SSRF surface.

## Refresh
- On cron (when update type = cron).
- On demand: `drush rcr-getrates` (`src/Commands/Drush9Commands.php`).

## Display
Place the **RCR** block (`RatesBlock`) in a region; it renders State-stored USD/EUR values plus any commission.
