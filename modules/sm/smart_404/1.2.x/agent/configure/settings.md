<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 — settings, config object, ignore patterns, retention

Install/enable: `composer require drupal/smart_404` (pulls `drupal/redirect ^1.9`), then
`drush en smart_404 -y && drush cr`. Redirect is enabled at the same time. `hook_install()`
(`smart_404.install`) shows a status message pointing at the settings page or suggesting Search 404.

## Config object `smart_404.settings`

Install defaults (`config/install/smart_404.settings.yml`), schema
(`config/schema/smart_404.schema.yml`, declared `FullyValidatable`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `retention_days` | integer (Range 0–3650) | `90` | Delete records whose `last_seen` is older than this via cron. `0` = never delete. |
| `max_records` | integer (Range 0–1000000) | `10000` | Cron deletes oldest-by-`last_seen` rows past this cap. `0` = no cap. |
| `strip_query_string` | boolean | `true` | Strip `?…` before normalizing the path (so `/s?q=a` and `/s?q=b` merge). |
| `log_bots` | boolean | `true` | When off, requests whose UA matches a bot pattern are not logged. |
| `log_referers` | boolean | `true` | When on, a sanitized referer is stored (see below). |
| `ignore_authenticated_admin` | boolean | `true` | Skip 404s from users with `administer site configuration`. |
| `search404_integration` | boolean | `false` | Log at exception level so Search 404 rewrites don't hide the 404. |
| `ignore_patterns` | sequence of string | WordPress/PHP/sitemap probes etc. | Glob patterns that are never logged (and used for deletion). |

## Settings form — `Smart404SettingsForm` (`ConfigFormBase`)

Route `smart_404.settings` at `/admin/config/system/smart-404`, permission
`administer smart_404 settings`. Fieldsets: **Retention & storage** (`retention_days`, `max_records`),
**Logging** (`strip_query_string`, `log_bots`, `log_referers`, `ignore_authenticated_admin`),
**Integrations** (`search404_integration`). Each field uses `#config_target`. The Search 404 checkbox
is `#disabled` only when the `search404` module is absent *and* the integration is not already on (so
it can always be turned off). Local tabs: **Settings** and **Ignore patterns**
(`smart_404.links.task.yml`).

![Smart 404 settings form](../../../../../../../screenshots/smart_404/1.2.x/settings-form.png)

## Ignore patterns

Two-form flow, both at permission `administer smart_404 settings`:

- **`Smart404IgnoreForm`** (route `smart_404.ignore`, `/admin/config/system/smart-404/ignore`): a
  textarea, one glob per line. `#config_target` uses a `ConfigTarget` with `fromConfig`/`toConfig`
  callbacks; `parsePatterns()` trims and drops blank lines. `buildForm()` deletes any stale
  `pending_ignore_patterns` tempstore entry. `submitForm()` counts how many existing rows the patterns
  would delete via `Smart404Repository::countMatchingPatterns()`; if `> 0` it stashes the patterns in
  private tempstore and redirects to the confirm form instead of saving directly, otherwise it saves
  immediately.
- **`Smart404IgnoreConfirmForm`** (`ConfirmFormBase`, route `smart_404.ignore_confirm`,
  `/admin/config/system/smart-404/ignore/confirm`): reachable only via the tempstore hand-off; a bare
  GET with nothing pending redirects back. On confirm it saves `ignore_patterns` and calls
  `Smart404Repository::deleteMatchingPatterns()` (which also drops the per-day rows). Saving the
  ignore list therefore purges matching history **for all current patterns**, not just newly added
  ones — hence the confirmation.

Glob semantics (`GlobMatcher::match()`, converted to PCRE, matching is case-insensitive because paths
are stored lowercased): `*` = any run incl. `/`, `?` = one char, `\*`/`\?` = literal. Used identically
by the logger (skip logging) and the repository (delete/count).

## Retention & cron — `Smart404Hooks::cron()`

`hook_cron` runs the full `Smart404Repository::cleanup()` at most once per day (tracked in state key
`smart_404.last_cron`): delete rows older than `retention_days`, prune `smart_404_log_daily` older than
`min(retention_days, 90)` (or 90 when retention is 0), then `enforceMaxRecords()`. Between daily runs,
an emergency brake calls `enforceMaxRecords()` immediately once the table exceeds `max_records * 2`.
The per-day timeline is always capped at 90 days (`Smart404Repository::MAX_DAILY_HISTORY_DAYS`)
regardless of retention. `hook_uninstall()` deletes the `smart_404.last_cron` state.

## Path normalization & referer handling

`PathNormalizer::normalize()`: optionally strip query string, strip fragment, `mb_strtolower`, strip
trailing slash (keep root `/`), ensure a leading slash. `PathNormalizer::hash($host, $path)` =
`sha256($host . '|' . $path)` — host-aware so the same path on two domains is two rows.
`Smart404Logger::sanitizeReferer()` keeps external referers as scheme+host only and internal ones as
scheme+host+path (query and fragment always dropped; non-http/https schemes rejected).

## `hook_requirements` (`Smart404Hooks::buildRequirements()`)

Runtime requirements warn when: the Search 404 integration is on but the module is missing; Search 404
is not installed (info-level suggestion); or `$settings['trusted_host_patterns']` is empty (Warning —
the Host header is logged, so validate it in `settings.php`).
