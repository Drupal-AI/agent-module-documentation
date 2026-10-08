# Configure SendGrid Reports

## Routes / permissions

| Route | Path | Access | Purpose |
|---|---|---|---|
| `sendgrid_integration_reports.reports` | `/admin/reports/sendgrid` | `access site reports` | The reports dashboard (volume, spam, browser/device tables) |
| `sendgrid_integration_reports.settings_form` | `/admin/config/services/sendgrid/reports` | `administer sendgrid integration reports` + `administer modules` | Date range / aggregation settings |

Permission defined: `administer sendgrid integration reports`. The API key itself comes from the
**parent** module (`sendgrid_integration.settings` → `apikey`); no key is configured here.

## Settings — `sendgrid_integration_reports.settings`

No `config/install` or `config/schema` ships; the config object is created by the settings form.
Keys (all optional):

| Key | Default | Meaning |
|---|---|---|
| `start_date` | today − 30 days | Global stats start date (`Y-m-d`) |
| `end_date` | today | Global stats end date (`Y-m-d`) |
| `aggregated_by` | `day` | Aggregation window: `day`, `week`, or `month` |

The form validates that `start_date` <= `end_date`. Saving the form clears the reports cache.

## Cache bin

Reports responses are cached in a dedicated bin via the `cache.sendgrid_integration_reports` service
(tagged `cache.bin`, factory `cache_factory:get`). It defaults to the database but can be pointed at
Redis/Memcache by overriding the `cache.sendgrid_integration_reports` backend. Clear it from the form
(auto) or `\Drupal::cache('sendgrid_integration_reports')->deleteAll()`.

## Charts library note

The dashboard attaches `sendgrid_integration_reports/googlejsapi` (external `https://www.google.com/jsapi`)
and `sendgrid_integration_reports/main` (jQuery-based) libraries to render Google Charts.
