<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & install

## Install / enable

```
composer require drupal/content_telemetry
drush en content_telemetry -y
drush cr
```

`hook_schema()` creates the three tables automatically. `content_telemetry_install()` seeds config
defaults so the insight engine has thresholds from the first request. No data appears until front-end
traffic is sampled and `drush cron` has run the rollup. Requires core `node`, `views`, `system`;
Drupal 10 or 11.

## Settings form

`Form/SettingsForm` (`content_telemetry_settings_form`, extends `ConfigFormBase`) at
**`/admin/config/system/content-telemetry`**, route `content_telemetry.settings`, permission
**`administer content telemetry`**. Menu link under *Configuration → System* and a menu tab.

Groups:
- **Collection settings**: `sampling_rate` (number, 1-100, required), `force_sample` (checkbox),
  `enable_block_telemetry` (checkbox — enables the block `#post_render` timing).
- **Performance thresholds**: `render_budget_ms` (50-30000, suffix ms); DB ratio warn/poor (%);
  cache-hit warn/poor (%); regression warn/poor (%).

The form stores ratio percentages back as **fractions** (e.g. entering `40` saves `0.40` for
`db_ratio_warn`); regression values are stored as whole percentages. `validateForm()` enforces
cross-field ordering: DB `warn < poor`, cache-hit `poor < warn` (lower is worse), regression
`warn < poor`.

## Config object `content_telemetry.settings`

Schema: `config/schema/content_telemetry.schema.yml` (type `config_object`). Install defaults:
`config/install/content_telemetry.settings.yml` (also re-seeded in `hook_install`, and Phase-5
threshold keys backfilled by `content_telemetry_update_9004`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `sampling_rate` | integer | 5 | % of front-end requests sampled (admins always sampled) |
| `force_sample` | boolean | false | Sample every eligible request |
| `enable_block_telemetry` | boolean | false | Collect per-block render timing |
| `render_budget_ms` | integer | 500 | Render SLO; PerformanceBudgetRule warn at budget, poor at 2× |
| `db_ratio_warn` | float | 0.40 | HighDbRatioRule warn |
| `db_ratio_poor` | float | 0.60 | HighDbRatioRule poor |
| `cache_hit_warn` | float | 0.50 | LowCacheHitRule warn |
| `cache_hit_poor` | float | 0.30 | LowCacheHitRule poor |
| `regression_warn_pct` | integer | 10 | RegressionRule warn (% over 7-day baseline) |
| `regression_poor_pct` | integer | 25 | RegressionRule poor |

`Service/ThresholdConfig` (service `content_telemetry.threshold_config`) reads these with
`DEFAULT_*` constant fallbacks and exposes `toArray()` for the rule context.

## Operating notes

- For local testing set `sampling_rate` to 100 and/or enable *Always collect telemetry*
  (`force_sample`); leave the 5% default in production to minimise overhead.
- `enable_block_telemetry` adds render-pipeline instrumentation — recommended only while
  investigating a specific slowdown.
- Aggregation is cron-only. Run `drush cron` (or wait for scheduled cron) before expecting reports.
- Raw samples are pruned after 14 days by `hook_cron`.
- There is no config for data clearing; the `clear content telemetry` permission is declared but no
  route/action in this release uses it.
