<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — `new_relic_rpm.settings`

Single config object, form at `/admin/config/development/new-relic`
(`\Drupal\new_relic_rpm\Form\NewRelicRpmSettings`, route `new_relic_rpm.settings`,
permission `administer new relic rpm`). All keys and shipped defaults
(`config/install/new_relic_rpm.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | New Relic REST API v2 key (used only for deployment markers / listing apps). |
| `region` | string | `us` | Data-center endpoint for the REST client: `us` or `eu`. |
| `track_drush` | string | `norm` | How Drush commands are tracked: `norm` / `bg` / `ignore`. |
| `track_cron` | string | `norm` | How cron runs are tracked: `norm` / `bg` / `ignore` (applied in `hook_cron`). |
| `ignore_roles` | sequence | `{}` | Role IDs; a user with any listed role has their transactions ignored. |
| `ignore_urls` | string | `''` | One path per line; matched paths are ignored. |
| `bg_urls` | string | `''` | One path per line; matched paths are marked as background jobs. |
| `exclusive_urls` | string | `''` | One path per line; if non-empty, everything **not** listed is ignored. |
| `override_exception_handler` | bool | `false` | Route uncaught exceptions to New Relic. |
| `watchdog_severities` | sequence | `{}` | RFC log levels (ints 0–7) whose watchdog messages are forwarded as errors. |
| `module_deployment` | bool | `false` | Create a deployment marker on module install/uninstall. |
| `config_import` | bool | `false` | Create a deployment marker on config import. |
| `views_log_slow` | bool | `false` | Record slow Views renders as `SlowView` Insights events. |
| `views_log_threshold` | int | `100` | Millisecond threshold above which a view counts as slow. |
| `disable_autorum` | bool | `false` | Disable New Relic's automatic RUM JS injection. |

## Region / endpoint

`region` selects which fixed New Relic REST endpoint `NewRelicApiClient` calls:

| `region` | Endpoint (`getApiBaseUrl()`) |
|---|---|
| `us` (default) | `https://api.newrelic.com/v2/` |
| `eu` | `https://api.eu.newrelic.com/v2/` |

Both endpoints are hard-coded in `NewRelicApiClient::getRegions()` and cannot be pointed at an
arbitrary host; the schema enforces the value with a `Choice` constraint (`us`, `eu`). EU
accounts must set `eu` or API calls fail. The post-update `new_relic_rpm_post_update_config_region`
backfills `us` on sites upgraded from 2.2.x.

## Transaction-state values

The three tracking selects (`track_drush`, `track_cron`) and the URL/role logic use the
constants on `NewRelicAdapterInterface`: `STATE_NORMAL = 'norm'`, `STATE_BACKGROUND = 'bg'`,
`STATE_IGNORE = 'ignore'`. These are the literal strings stored in config.

## Drush / config recipes

```bash
# Read the whole config object:
drush config:get new_relic_rpm.settings

# Switch to the EU data center:
drush config:set new_relic_rpm.settings region eu -y

# Turn on slow-views logging with a 500 ms threshold:
drush config:set new_relic_rpm.settings views_log_slow true -y
drush config:set new_relic_rpm.settings views_log_threshold 500 -y

# Ignore Drush transactions and mark deployments on module changes:
drush config:set new_relic_rpm.settings track_drush ignore -y
drush config:set new_relic_rpm.settings module_deployment true -y

# Set the REST API key:
drush config:set new_relic_rpm.settings api_key YOUR_KEY -y
```

Notes:
- `ignore_urls` / `bg_urls` / `exclusive_urls` are newline-separated strings, matched with
  the `path.matcher` service (supports `*` wildcards and `<front>`).
- `watchdog_severities` and `ignore_roles` are sequences; set them via a config import or
  `drush php:eval` rather than a scalar `config:set`.
- `views_log_threshold` label is "Slow view threshold in ms"; the slow-view event is only
  recorded when `views_log_slow` is TRUE.
