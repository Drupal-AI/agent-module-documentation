# Settings

Config object `entity_usage.settings` (schema `config/schema/entity_usage.schema.yml`). UI at
`/admin/config/entity-usage/settings` (route `entity_usage.settings.form`, form
`EntityUsageSettingsForm`). Read/write with `drush config:get entity_usage.settings`.

| Key | Type | Meaning |
|---|---|---|
| `track_enabled_source_entity_types` | sequence<string> | Entity types tracked as *sources* (default: all content entities except file/user). |
| `track_enabled_target_entity_types` | sequence<string> | Entity types recorded as *targets*. |
| `track_enabled_plugins` | sequence<string> | Which EntityUsageTrack plugins are active (default: all). |
| `track_enabled_base_fields` | bool | Whether referencing base fields (not just configurable fields) are tracked (default `false`). |
| `local_task_enabled_entity_types` | sequence<string> | Types that show a "Usage" local-task tab on their canonical page (default: none). |
| `edit_warning_message_entity_types` | sequence<string> | Types that show a warning on the edit form when still referenced. |
| `delete_warning_message_entity_types` | sequence<string> | Types that show a warning on the delete form when still referenced. |
| `delete_warning_form_classes` | sequence<string> | Form classes that should display the delete warning. |
| `site_domains` | sequence<string> | Domains treated as "this site" so HTML/link URLs resolve to local entities. |
| `usage_controller_items_per_page` | int | Rows per page on the usage report (default 25). |

- Two service parameters (in `entity_usage.services.yml`, not config) tune behavior:
  `entity_usage.always_track_base_fields` (`menu_link_content`, `redirect`) and
  `entity_usage.url_updater_records_to_process` (15 — records updated synchronously on URL
  change before the rest are deferred to a queue).
- After changing tracked types or plugins, rebuild the table — see
  [batch-update.md](batch-update.md) or the [drush command](../drush/entity_usage.md).
