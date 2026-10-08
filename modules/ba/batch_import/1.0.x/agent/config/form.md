<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Import — admin form, permission, and run flow

## Install / enable

`drush en batch_import`. No contrib dependencies. Grant the **`run batch imports`** permission
(`batch_import.permissions.yml`, `restrict access: true`) to trusted roles only. The module does
nothing visible until a custom module registers at least one `@BatchMigration` plugin
(see [../plugins/migrations.md](../plugins/migrations.md)).

## Route & menu

- Route **`batch_import.form`** (`batch_import.routing.yml`): path `/admin/content/batch-import`,
  form `\Drupal\batch_import\Form\BatchImportForm`, requirement `_permission: 'run batch imports'`.
- Menu link (`batch_import.links.menu.yml`): *Batch Import Administration* under
  `system.admin_content` (Content). Also set as the module's `configure` route in `*.info.yml`.

## The form (`BatchImportForm`, extends `ConfigFormBase`)

- `buildForm()` renders a `#type => tableselect` (`form['migrations']`, `#required`) whose rows come
  from `getPluginOptions()`: all `plugin.manager.batch_migrations` definitions, minus those with
  `hidden = true`, sorted so dependency-lighter migrations appear first (a `uasort` on the
  `dependencies` annotation). Each row shows the migration `name` and a `<ul>` of its dependency
  names (unknown ids render as `"<id> (not found)"`).
- Two submit buttons, each with its own handler (the default `submit` is unset):
  - **Queue import for cron** → `queueSubmitForm()` → `MigrationActivationService::queueMigration()`.
  - **Manually run import** → `manualSubmitForm()` → `MigrationActivationService::manualMigration()`.
- Selected values are `array_filter`ed (drop unchecked) before being passed on. Although it extends
  `ConfigFormBase` and names `batch_import.settings` in `getEditableConfigNames()`, no form element
  maps to config — nothing is actually written to that object, and no config schema ships.
- Attaches CSS-only library `batch_import/import_form` (`css/import-form.css`).

## Run flow (`MigrationActivationService`)

Constructor args: `plugin.manager.batch_migrations`, `queue`, `plugin.manager.queue_worker`,
`messenger`. Plugin ids from the form are always validated against `getDefinitions()` before use.

**Queue (cron) path — `queueMigration($plugin_ids)`:**
1. Wraps each selected id in a `\stdClass` item (`plugin_id`, `plugin_definition`, `index`, `total`)
   and pushes it to the reliable queue **`batch_import_source_queue`**.
2. On cron, `BatchImportSourceQueue::processItem()` (base `BatchImportSourceBase`) calls
   `getData($plugin_id)` → `plugin->processSource()`, normalizes each row's keys (spaces → `_`), and
   enqueues one item per row to **`batch_import_destination_queue`**.
3. On a later cron, `BatchImportDestinationQueue::processItem()` (base `BatchImportDestinationBase`)
   calls `processData($plugin_id, $row)` → `plugin->processDestination($row)`, saving the entity.
   (`cron = {"time" = 10}` on both `_queue` workers.)

**Manual (Batch API) path — `manualMigration($plugin_ids)`:**
1. Clears and repopulates the **`batch_import_source_manual`** queue with the selected items.
2. Sets a Batch with two operations, both `queueProcessItem()`: first drains
   `batch_import_source_manual` (source → per-row items into `batch_import_destination_manual`), then
   drains `batch_import_destination_manual` (save entities). `$limit = 1` item per batch step; the
   `finished` callback `outputResults()` posts per-migration "Successfully processed N entities"
   status messages and any errors via the messenger.
- Errors: `SuspendQueueException` releases the item and records the error; other exceptions are
  logged (`Error::logException`) and recorded. The batch runs under the same access-gated request as
  the form submit.

## Source database (`origin`)

A migration whose `@BatchMigration` sets `origin` reads from a secondary connection. Define it in
`settings.php`, e.g. `$databases['source']['default'] = [...]` (see README). `BatchMigrationBase::getConnection()`
switches the active DB connection to that id for the migration's `source()`.
