<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Status page & configuration

All settings are in the single config object **`nagios.settings`**. Settings form:
`nagios.settings` route → `/admin/config/system/nagios` (permission `administer site
configuration`). Ignored-modules form → `/admin/config/system/nagios/ignored_modules`
(permission `administer nagios ignore`).

## Enable the endpoint

The status page is **off by default**. Enable it and (optionally) set its path:

```php
\Drupal::configFactory()->getEditable('nagios.settings')
  ->set('nagios.statuspage.enabled', TRUE)
  ->set('nagios.statuspage.path', 'nagios')   // path segment, no leading slash
  ->save();
```

Then rebuild routes (`drush cr`). The route `nagios.statuspage` is registered dynamically by
`StatuspageController::routes()` at `<path>/{module_name}/{id_for_hook}`; its access callback
returns allowed only when `nagios.statuspage.enabled` is true.

Read back: `drush cget nagios.settings nagios.statuspage`.

## Authorizing a monitor request

The controller returns real check data only if one of these holds, else it emits a single
`UNKNOWN` "Unauthorized" line:

- the request's HTTP `User-Agent` equals `nagios.ua` (default **`Nagios`**), or
- `nagios.statuspage.getparam` is true **and** `?unique_id=<ua>` matches `nagios.ua`, or
- the current user has permission `administer site configuration`.

So a monitor typically polls `https://site/nagios` sending `User-Agent: Nagios` (configure the
same string on both sides). Example: `curl -A Nagios https://site/nagios`.

## Config keys (`nagios.settings`, defaults from config/install)

| Key | Default | Meaning |
|---|---|---|
| `nagios.statuspage.enabled` | `false` | master switch for the endpoint |
| `nagios.statuspage.path` | `nagios` | URL path segment |
| `nagios.statuspage.getparam` | `false` | allow `?unique_id=` auth |
| `nagios.statuspage.controller` | `StatuspageController::content` | route controller |
| `nagios.ua` | `Nagios` | required User-Agent / unique id string |
| `nagios.status.{ok,warning,critical,unknown}` | 0/1/2/3 | numeric status codes |
| `nagios.min_report_severity` | 1 | only report at/above this severity |
| `nagios.function.{watchdog,cron,maintenance,requirements}` | true | which built-in checks run |
| `nagios.cron_duration` / `nagios.elysia_cron_duration` | 60 | minutes before cron is "late" |
| `nagios.show_outdated_names` | true | list outdated project names in output |
| `nagios.experimental_modules` / `deprecated_modules` / `deprecated_themes` | true | warn on these |
| `nagios.limit_watchdog.display` / `.channel_filter` | false / `access denied` | watchdog channel filtering |

## Output format

`text/plain`, cache-disabled. One aggregated line the bundled `nagios-plugin/check_drupal`
bash script understands, built from `nagios_invoke_all('nagios')` (all `hook_nagios()`
implementations) plus the enabled built-in checks. Request `/nagios/<module>/<id>` to run only
one module's `hook_nagios($id)`.
