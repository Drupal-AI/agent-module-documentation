<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install / enable
```bash
composer require drupal/mautic_audiences
drush pm:install mautic_audiences
```
Requires `advanced_mautic_integration` (the Mautic API client + tracking script); enable and configure that first. Attach the JS API where needed with the `mautic_audiences/audiences` library.

## Settings form
Route `mautic_audiences.settings_form` → `\Drupal\mautic_audiences\Form\SettingsForm` at `/admin/config/services/mautic-audiences` (perm `administer mautic audiences`). It edits the config object `mautic_audiences.settings`.

![Mautic Audiences settings form](../../../../../../../screenshots/mautic_audiences/1.1.x/settings-form.png)

## Config object `mautic_audiences.settings`
Keys, schema (`config/schema/mautic_audiences.schema.yml`), and install defaults (`config/install/mautic_audiences.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `webhook_secret` | string | `''` | Shared secret used to verify inbound webhooks. May instead be set in `$settings['mautic_audiences.webhook_secret']` (settings.php), which `WebhookController` reads when the config value is empty. A **Generate a secret** button fills a random value into the form for you to save. |
| `anonymous_ttl` | integer | `300` | Freshness window (seconds) for anonymous audiences resolved via the `mtc_id` cookie; after it, the next render-path read triggers one Mautic refresh. |
| `identity_strategy` | string | `email` | Active identity-strategy plugin id (`email` or `custom_field`). See [api/resolver.md](../api/resolver.md). |
| `identity_strategy_settings` | mapping | `{}` | The active strategy's own settings (the strategy embeds its subform; save once after switching to reveal it). |
| `reconciliation_threshold` | integer | `604800` | Drift threshold (seconds, default 7 days); authenticated audiences older than this are re-fetched on cron. |
| `idempotency_window` | integer | `3600` | How long a webhook event key is remembered to deduplicate replays. |
| `consent_callback` | string | `''` | Optional service id that returns TRUE when profiling is permitted; empty = ungated. See the Klaro submodule and [api/resolver.md](../api/resolver.md). |
| `exposed_segments` | sequence(string) | `[]` | Segment aliases safe to expose to client-side surfaces (`/me` and the joined-string token). Empty = expose nothing. |
| `exposed_tag_prefixes` | sequence(string) | `[]` | Tag prefixes (matched with `str_starts_with`) safe to expose to client-side surfaces. Empty = expose nothing. |

`SettingsForm::submitForm()` parses the two textareas into distinct-line lists via `parseLines()` and delegates the strategy subform to `IdentityStrategyInterface::submitConfigurationForm()`, storing the result under `identity_strategy_settings`.

## Drush config
```bash
drush cget mautic_audiences.settings
drush cset mautic_audiences.settings anonymous_ttl 600
drush cset mautic_audiences.settings consent_callback mautic_audiences_klaro.consent_check
```

## Permissions (`mautic_audiences.permissions.yml`)
- `administer mautic audiences` — settings form, the debug report, and (via the field submodule) viewing stored audience aliases. `restrict access: true`.
- `preview mautic audiences` — preview the site as an arbitrary audience via URL params. `restrict access: true`. See [reports/debug.md](../reports/debug.md).

## Menu links (`mautic_audiences.links.menu.yml`)
`mautic_audiences.settings` under `system.admin_config_services`; `mautic_audiences.debug` under `system.admin_reports`.

## Uninstall
`mautic_audiences_uninstall()` (`mautic_audiences.install`) drops the `mautic_audiences_anonymous` keyvalue collection, deletes all `users_data` rows for the module, and clears the `mautic_audiences.processed_events` state. Config is removed by core.
