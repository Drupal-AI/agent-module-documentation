# Configure WSE — settings form + `wse.settings`

- **Route:** `wse.settings` → `/admin/config/workflow/workspaces/settings`
  (also a "Settings" tab on `/admin/config/workflow/workspaces`).
- **Permission:** `administer workspaces` (core Workspaces permission).
- **Form:** `Drupal\wse\Form\SettingsForm` (a `ConfigFormBase`, also a
  `WorkspaceSafeFormInterface` so it can be saved while a workspace is active).
- **Config object:** `wse.settings` (editable name returned by `getEditableConfigNames()`).
  Schema: `config/schema/wse.schema.yml`. Install defaults: `config/install/wse.settings.yml`.

## Config keys

| Key | Type | Default | Effect |
|---|---|---|---|
| `simplified_toolbar_switcher` | bool | `true` | Use WSE's simplified toolbar/navigation workspace switcher (via lazy-builder decorators). |
| `recent_workspaces_max_age` | int (hours) | `72` | How long a workspace stays in the per-user "recent workspaces" tempstore list. `0` = keep forever. |
| `switcher_max_options` | int | `10` | Max workspaces shown in the switcher select. `0` = all. |
| `save_published_revisions` | string/`ignore` | `published` | On publish, record revision IDs for later revert. `published` = only published revision IDs; `all` = all revision IDs; empty/`0` = don't record. |
| `override_save_published_revisions` | bool | `false` | Show a per-publish "Saved revisions during publishing" select on the workspace publish form so an editor can override the value above. |
| `squash_on_publish` | bool | `false` | On publish, queue deletion of intermediary draft revisions (keeps only the published default revision). |
| `squash_on_publish_interval` | int (hours) | `0` | Delay before the queued squash runs. `0` = immediately (next cron). |
| `clone_on_publish` | bool | `false` | On publish, duplicate the workspace's metadata into a new open draft workspace and switch to it (instead of switching to Live). |
| `safe_forms` | sequence of string | `[]` | Extra form IDs allowed to submit inside a workspace with no confirmation prompt. One form ID per line in the UI. See [hooks/workspace-integration.md](../hooks/workspace-integration.md). |
| `entity_workspace_status` | sequence of string | `[]` | Entity type IDs that get the read-only `entity_workspace_status` pseudo-field (extra field) showing published/draft status. |
| `disable_sub_workspaces` | bool | `false` | Hide/forbid the workspace `parent` field so editors cannot create nested sub-workspaces (`hook_entity_field_access`). |
| `append_current_workspace_to_url` | bool | `false` | Outbound path processor appends `?workspace=<id>` to internal links while a workspace is active. Not exposed on the settings form; set via drush/config. |

Note: the publish-form select uses two constants —
`WseWorkspacePublishForm::SAVE_PUBLISHED_REVISIONS_PUBLISHED_ONLY` = `'published'`,
`SAVE_PUBLISHED_REVISIONS_ALL` = `'all'`.

## Set values without the UI

Drush:
```
drush cset wse.settings squash_on_publish true -y
drush cset wse.settings squash_on_publish_interval 24 -y
drush cset wse.settings clone_on_publish true -y
```

PHP (safe_forms / entity_workspace_status are sequences):
```php
\Drupal::configFactory()->getEditable('wse.settings')
  ->set('safe_forms', ['my_custom_form', 'another_form'])
  ->set('entity_workspace_status', ['node'])
  ->save();
```

## What happens at runtime

- **Publishing** is handled by `WorkspacePublishingEventSubscriber` on core's
  `WorkspacePrePublishEvent`/`WorkspacePostPublishEvent`:
  `save_published_revisions` → `PublishedRevisionStorage::storePublishedRevisions()` (pre) /
  `storeAllRevisions()` (post, when `all`); `squash_on_publish` → items pushed to the
  `wse_revision_cleaner` queue; `clone_on_publish` → new duplicate workspace; then the
  published workspace's `status` is set to `closed`.
- **Switcher** settings feed the decorated `workspaces.lazy_builders`,
  `workspaces_ui.lazy_builders` and `navigation.workspaces_lazy_builders` services.
- **Status field**: `wse_update_9004` / `hook_entity_base_field_info` install a base field
  `status` on `workspace` with allowed values `open`/`closed` (`WSE_STATUS_OPEN`/`WSE_STATUS_CLOSED`).
