<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# batch_plugin_entity — reference

## Install & enable

```bash
drush en batch_plugin_entity -y   # pulls in batch_plugin
```

Then visit **`/admin/structure/batch-plugin`** (Structure → Batch plugins). Access requires the
permission **`administer batch_plugin_entity`**.

## Operating flow

1. **Add** (`/admin/structure/batch_plugin/add`): `BatchPluginEntityLibraryController::listPlugins`
   renders every non-`hidden` batch plugin the user may see (a plugin's `permission`, if set, is
   checked against the current user). Each row links to `batch_plugin_entity.admin_add`.
2. **Configure** (`/admin/structure/batch_plugin/{plugin_id}`):
   `BatchPluginEntityAddController::batchPluginEntityAddConfigureForm` creates a new
   `batch_plugin_entity` with that `plugin` and renders `BatchPluginEntityForm`.
3. The form collects `label`, machine `id`, `description`, an **Enabled** (`status`) checkbox, and
   the wrapped plugin's own configuration form (`buildConfigurationForm()` on the plugin — which
   for the base includes the **Processor** selector and the processor's sub-form).
4. **Save** stores the config entity. **Save** + the **Process** button (present once the entity
   has an id) runs the plugin immediately.

## The config entity (`BatchPluginEntity`)

- `@ConfigEntityType id = batch_plugin_entity`, `config_prefix = batch_plugin_entity`,
  `admin_permission = administer batch_plugin_entity`.
- Stored fields (`config_export`): `id`, `label`, `description`, `plugin` (the wrapped batch plugin
  id), `settings` (the plugin's configuration, incl. `processor_plugin_id`).
- `getPlugin()` → `getPluginCollection()->get($this->plugin)`, a `BatchPluginEntityCollection`
  (extends `DefaultSingleLazyPluginCollection`) built with `plugin.manager.batch_plugin`, the
  stored `settings`, and the entity id. `initializePlugin()` throws if no plugin id is set, but
  swallows plugin exceptions for plugins provided by uninstalled modules.
- `getPluginCollections()` returns `['settings' => collection]` so core config-entity dependency
  handling tracks the plugin.

## Lifecycle & queues

- `postSave($storage, $update)` on **create** (`!$update`): if the settings' `processor_plugin_id`
  is **not** a `CronProcessorPluginInterface`, `deleteQueue()`; then clears the queue-worker plugin
  cache so `Derivative/BatchPluginQueueWorker` re-discovers derivatives for this entity.
- `delete()` calls `deleteQueue()` first. `deleteQueue()` deletes
  `\Drupal::queue(BatchPluginQueueWorker::QUEUE_NAME_ENTITY_PREFIX . id)`.
- Note: `BatchPluginManager::getDefinitionsByType()` includes enabled entities using
  `queue_name = batch_plugin_queue_worker:_entity_<id>`, so a cron/queue entity is picked up by
  `hook_cron()` and the queue deriver alongside code-defined plugins.

## Running from the form (`BatchPluginEntityForm::save`)

- Sets the plugin's config key to `batch_plugin_entity.batch_plugin_entity.<id>` before submitting
  its config form (so traits like `ConfigTableSelectTrait` can write back to this object).
- On the Process op: resolves `settings['processor_plugin_id']` via
  `ProcessorPluginManager::createProcessorPlugin()`; for cron processors sets the queue id to
  `batch_plugin_queue_worker:_entity_<id>`; then `$processor_plugin->process($plugin)`.
- Redirects back to the edit form.

## List builder columns (`BatchPluginEntityListBuilder`)

Label, Machine name, Plugin ID, Provider, Processor (`settings['processor_plugin_id']` or *Not
set*), Status (Enabled/Disabled). A missing/invalid plugin definition is caught and shown as
*Missing plugin definition* rather than fatalling the list.

## Config schema

`config/schema/batch_plugin_entity.schema.yml` types the entity: `id`, `label`, `description`,
`plugin`, `processor`, and a free-form `settings` mapping.
