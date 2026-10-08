<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Config object `entity_usage.settings` (schema `config/schema/entity_usage.schema.yml`,
install defaults `config/install/entity_usage.settings.yml`). UI at
`/admin/config/entity-usage/settings` (route `entity_usage.settings.form`, form
`Form\EntityUsageSettingsForm`, perm `administer entity usage`). Read/write with
`drush config:get entity_usage.settings`.

![Entity Usage settings form](../../../../../../../screenshots/entity_usage/5.0.x/settings-form.png)

| Key | Type | Meaning |
|---|---|---|
| `track_enabled_source_entity_types` | sequence<string> | Entity types tracked as *sources*. When the key is **unset**, all content entity types are tracked except `file`, `user`, and inline types (paragraphs). |
| `track_enabled_target_entity_types` | sequence<string> | Entity types recorded as *targets*. Unset ⇒ all tracked. |
| `track_enabled_plugins` | sequence<string> | Which `EntityUsageTrack` plugins are active. Unset ⇒ all. Inline plugins are always on regardless. |
| `track_enabled_base_fields` | bool | Track referencing base (non-configurable) fields too. Default `false`. |
| `local_task_enabled_entity_types` | sequence<string> | Types that get a "Usage" local-task tab on their canonical/edit-form page. Default `{}` (none). Changing this rebuilds routes (see `Routing\RouteSubscriber`). |
| `edit_warning_message_entity_types` | sequence<string> | Types that show a warning on the **edit** form when still referenced. |
| `delete_warning_message_entity_types` | sequence<string> | Types that show a warning on the **delete** form when still referenced. |
| `delete_warning_form_classes` | sequence<string> | Form classes on which the delete warning may appear (defaults to `Drupal\Core\Entity\ContentEntityDeleteForm` when unset). |
| `site_domains` | sequence<mapping{host,path}> | Domains treated as "this site" so absolute URLs in content resolve to local entities. **Note the 5.x format change**: each entry is a `{host, path}` mapping (was a plain string list in older releases; `entity_usage_update_8301` converts it). The site's own base URL and public-file URL are auto-discovered by `SiteDomains`. |
| `usage_controller_items_per_page` | int | Rows per page on the usage report. Default 25 (`ListUsageController::ITEMS_PER_PAGE_DEFAULT`). |

## Form behavior notes
- Source, target and plugin lists are `#required`; empty selections are rejected.
- Inline entity types (e.g. `paragraph`, from `EntityUsageInlineTrackingInterface`
  plugins) are removed from the source/target and plugin option lists — they are
  tracked automatically via their host entity.
- Edit/delete-warning checkboxes are enabled (`#states`) only when the same type is
  checked as a tracked target.
- Site domains are entered one per line in a textarea and stored via
  `SiteDomains::stringsToConfig()` (IDN-normalized to ASCII host + path).

## Service parameters (in `entity_usage.services.yml`, not config)
- `entity_usage.always_track_base_fields`: `[menu_link_content, redirect]` — base
  fields always tracked for these when enabled as sources.
- `entity_usage.url_updater_records_to_process`: `15` — how many usage records are
  updated synchronously when an entity's URL changes before the rest are deferred to
  the `entity_usage_recreate_tracking` queue (`QueueWorker`).

After changing tracked types or plugins, rebuild the table — see
[batch-update.md](batch-update.md) or the [drush command](../drush/entity_usage.md).
