<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin cleanup page — route, permission, four forms, logger

## Route & access

`module_cleanup.routing.yml`:

```yaml
module_cleanup.delete_transient_data:
  path: '/admin/config/system/delete-transient-module-data'
  defaults:
    _controller: '\Drupal\module_cleanup\Controller\ModuleCleanupController::overview'
    _title: 'Delete transient module data'
  requirements:
    _permission: 'delete transient module data'
```

- Single route; `ModuleCleanupController::overview()` builds four forms into one render array.
- Permission `delete transient module data` (`module_cleanup.permissions.yml`).
- Menu link `module_cleanup.delete_transient_data` (`module_cleanup.links.menu.yml`) under
  `system.admin_config_system` (*Administration → Configuration → System*), weight 30.
- All four are plain `FormBase` forms, so submissions carry the standard **form CSRF token**.

## Form 1 — `TransientModuleDataDeleteForm` (id `module_cleanup_transient_data_delete_form`)

- Deps (`create()`): `messenger`, `database`, `update.update_hook_registry`, `extension.list.module`.
- `buildForm()`: options = every module in `getAllInstalledVersions()` that is **absent** from
  `getAllInstalledInfo()` (has a schema version but is no longer installed). A `checkboxes` element,
  `#required`, all pre-checked. If the list is empty the submit button is disabled.
- `submitForm()`: for each selected value runs
  `db->delete('key_value')->condition('name', $module)->execute()` and prints
  "<Module> transient data deleted." **No `collection` condition** — deletes all `key_value` rows with
  that `name`. Core validates the checkbox values against the offered options, so only listed
  (uninstalled) modules can be targeted through the UI.
- Fix for *"Module 'x' has an entry in the system.schema key/value storage"*
  (https://www.drupal.org/node/3137656).

## Form 2 — `TransientEntityTypeDeleteForm` (id `module_cleanup_transient_fields_delete_form`)

- Deps: `messenger`, `database`, `tempstore.private`.
- Runs `field_purge_batch(1000)`. It is a **multi-click guided flow** using a private tempstore
  (collection `module_cleanup`, keys `part_two`, `part_three`, `field_name`, `entity_type`):
  - First click that throws a `FieldException` (storage missing): regex-parses the message
    (`/^Attempted to create, modify or delete an instance of field with name/` +
    `/when the field storage does not exist.$/`, split on `/ on entity type /`) to recover
    `field_name` + `entity_type`, stores them, sets `part_two`, asks the user to click again.
  - Next click: recreates a temporary `string` `FieldStorageConfig`, sets `part_three`, asks to click
    again.
  - Next click: `field_purge_batch(1000)` succeeds, the recreated storage is deleted, tempstore reset.
  - `PluginNotFoundException` → error telling the user the owning module must be installed to purge.
- A "Reset" submit (`::resetForm`, `#limit_validation_errors => []`) clears the tempstore.
- Fix for *"The 'x' entity type does not exist"*
  (https://www.drupal.org/project/paragraphs/issues/3165612).

## Form 3 — `ClearUpdateDeleteForm` (id `module_clear_update_delete_form`)

- Deps: `messenger`, `database`.
- `submitForm()`: `db->delete('key_value')->condition('collection', 'update_fetch_task')->execute()`,
  then "Avalable updates restored." Fix for *"No available releases found"* on Available Updates.

## Form 4 — `UpdateConfigEntityForm` (id `module_cleanup_update_config_entity_form`)

- No injected deps. `submitForm()` calls `drupal_flush_all_caches()` only.
- Effective only in combination with the logger service below, which does the actual repair when the
  cache flush re-emits the error to the log.

## Logger — `ViewerErrorHandler` (`module_cleanup.services.yml`)

```yaml
module_cleanup.viewer_error_handler:
  class: Drupal\module_cleanup\Logger\ViewerErrorHandler
  arguments: ['@messenger', '@keyvalue']
  tags:
    - { name: logger, priority: 100 }
```

- Implements `LoggerInterface` (via `RfcLoggerTrait`). On **every** log call it checks whether the
  message begins with *"A non-existent config entity name returned by FieldStorageConfigInterface"*.
- If so, and context has `%entity_type` / `%field` / `%bundle`, it loads the
  `entity.definitions.bundle_field_map` key_value store, `unset()`s
  `$map[$field]['bundles'][$bundle]`, writes it back, and shows a "Fixed: …" message.
- Because it is a tagged logger it runs for all requests/users (no permission gate); it only acts on
  that one specific message, so effect is limited to healing that error on cache clear / module install.
- Fix for *"non-existent config entity name returned by FieldStorageConfigInterface::getBundles()"*
  (https://www.drupal.org/project/drupal/issues/2916266).

## Cautions

- Every action is irreversible and writes directly to `key_value` or field-purge internals — back up
  first. Deletions are matched by `key_value` `name`/`collection`, not by verified ownership.
