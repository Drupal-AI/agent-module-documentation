<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `#config` form hint (mechanism)

The whole module is `config_override_core_fields_form_alter()`. It switches on `$form_id` and,
for a fixed set of core config forms, assigns:

```php
$form[...]['#config']['key'] = '<config_object>:<dotted.key>';
```

That string is `config.name` + `:` + a dotted path into that config object. A consumer splits
it as `explode(':', $key)` → `[$configBin, $configKey]`, then reads
`\Drupal::config($configBin)->get($configKey)` / `->hasOverrides($configKey)`.

## Covered forms and a sample of the keys they map

| Form id | Example element → key |
|---|---|
| `system_site_information_settings` | site_name → `system.site:name`, site_slogan → `system.site:slogan`, site_mail → `system.site:mail`, site_frontpage → `system.site:page.front`, site_403/404 → `system.site:page.403`/`page.404` |
| `system_performance_settings` | page_cache_maximum_age → `system.performance:cache.page.max_age`, preprocess_css → `system.performance:css.preprocess`, preprocess_js → `system.performance:js.preprocess` |
| `system_cron_settings` | logging → `system.cron:logging`; interval → `automated_cron.settings:interval` (if present) |
| `system_file_system_settings` | file_temporary_path → `system.file:path.temporary`, file_default_scheme → `system.file:default_scheme`, temporary_maximum_age → `system.file:temporary_maximum_age` |
| `system_logging_settings` | error_level → `system.logging:error_level`; dblog_row_limit → `dblog.settings:row_limit` (if present) |
| `system_site_maintenance_mode` | maintenance_mode_message → `system.maintenance:message` |
| `system_themes_admin_form` | admin_theme → `system.theme:admin`; use_admin_theme → `node.settings:use_admin_theme` (if present) |
| `update_settings` | check frequency/disabled/emails/threshold → `update.settings:check.interval_days`, `check.disabled_extensions`, `notification.emails`, `notification.threshold` |
| `user_admin_settings` | many fields → `user.settings:*` and `user.mail:*` (register/verify/cancel, all mail subject/body keys), plus mail_notification_address → `system.site:mail_notification` |
| `search_admin_settings` | cron_limit → `search.settings:index.cron_limit`, minimum_word_size → `search.settings:index.minimum_word_size`, overlap_cjk → `search.settings:index.overlap_cjk`, logging → `search.settings:logging` |
| `views_ui_admin_settings_basic` | the UI show/preview toggles → `views.settings:ui.*` |
| `views_ui_admin_settings_advanced` | skip_cache → `views.settings:skip_cache`, sql_signature → `views.settings:sql_signature`, display_extenders → `views.settings:display_extenders` (if present) |

Contrib-dependent keys (automated_cron, dblog, node, views extenders) are guarded with
`isset($form[...])` so the alter is safe whether or not those modules are enabled. The full,
exact list is `config_override_core_fields.module`.

## Consuming the hint

The convention this module establishes:

- `#config['key']` — this module's hint (`config.object:key`).
- `#config_data_store['key']` — the equivalent from a work-in-progress core patch
  ([#2408549](https://www.drupal.org/project/drupal/issues/2408549)); consumers check both.

To add a hint for another form, implement your own `hook_form_alter()` (or fork this one) and
set `#config['key']` on the element. See COI (`../../../../coi/4.0.x/agent/api/mechanism.md`) for
the reference consumer that turns these hints into override indicators and field disabling.
