<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism — what actually blocks a config write

Two independent guards. Both are inert unless `Settings::get('config_readonly')` is truthy.

## 1. Storage decorator (`config.storage`)

`Drupal\config_readonly\ConfigReadonlyServiceProvider` implements
`ServiceProviderInterface` + `ServiceModifierInterface`. In `alter()` it rewrites the
`config.storage` definition (skipped only when `kernel.environment === 'install'`):

```php
$definition->setClass('Drupal\config_readonly\Config\ConfigReadonlyStorage');
$definition->setArguments([
  new Reference('config.storage.active'),
  new Reference('cache.config'),
  new Reference('lock'),
  new Reference('request_stack'),
  new Reference('module_handler'),
]);
```

`ConfigReadonlyStorage extends CachedStorage`. It overrides the four mutating methods and
calls `checkLock()` first:

| Method | checkLock argument |
|---|---|
| `write($name, $data)` | `$name` |
| `delete($name)` | `$name` |
| `rename($name, $new_name)` | both names |
| `deleteAll($prefix = '')` | none (no name → whitelist can't apply) |

`checkLock($name = '')` throws
`Drupal\config_readonly\Exception\ConfigReadonlyStorageException`
(`extends \RuntimeException`, message *"Your site configuration active store is currently
locked."*) unless one of these is true:

1. `Settings::get('config_readonly')` is falsy, **or**
2. the `ConfigImporter::LOCK_NAME` (`config_importer`) lock is **held** — i.e. a config
   import is running, so `$lock->lockMayBeAvailable()` is FALSE, **or**
3. the current request's route is `system.db_update` (update.php), **or**
4. `$name` matches a whitelist pattern.

`createCollection()` re-wraps the collection in the same class, so language overrides are
guarded too.

## 2. Form guard (`hook_form_alter`)

`config_readonly.module` → `config_readonly_form_alter()`:

1. Returns immediately unless `Settings::get('config_readonly')`.
2. Dispatches `ReadOnlyFormEvent` (name `config_readonly_form_event`).
3. If `$event->isFormReadOnly()`, it:
   - adds a warning message: *"This form will not be saved because the configuration
     active store is read-only."* plus, when the event carries config names, *"You can
     override by whitelisting the configs used on this page: …"* (rendered `item_list`);
   - appends `_config_readonly_validate_failure` to `$form['#validate']`, which calls
     `$form_state->setErrorByName(NULL, …)` — so even a forced POST fails;
   - sets `#disabled = TRUE` on every `submit` button in `$form['actions']` and in any
     top-level `fieldset` that contains an `actions` array.

`ReadOnlyFormSubscriber::onFormAlter()` (priority 200) decides read-only-ness:

```
mark read-only if form object is:
  ConfigFormBase | ConfigEntityListBuilder | ConfigTranslationFormBase
  OR getFormId() in [config_single_import_form, system_modules,
                     system_modules_uninstall, user_admin_permissions]
  OR EntityFormInterface whose entity is a ConfigEntityInterface
then un-mark if whitelisted:
  EntityFormInterface      -> entity->getConfigDependencyName()
  ConfigEntityListBuilder  -> "<config_prefix>.*"
  ConfigFormBase           -> all of getEditableConfigNames() + all #config_target names
  ConfigTranslationFormBase-> all keys of the protected $baseConfigData
```

The subscriber reaches the protected `getEditableConfigNames()` and `$baseConfigData`
through reflection.

## Requirements report

`config_readonly_requirements('runtime')` adds one item, title *"Config Read-only mode"*:
`REQUIREMENT_INFO` / value **"Config is readonly"** when active,
`REQUIREMENT_WARNING` / value **"Config is writable"** when the module is enabled but the
setting is off.

## Catching it in code

```php
use Drupal\config_readonly\Exception\ConfigReadonlyStorageException;

try {
  \Drupal::configFactory()->getEditable('system.site')->set('name', 'x')->save();
}
catch (ConfigReadonlyStorageException $e) {
  // Active store is locked; import instead.
}
```

Note the exception surfaces from `ConfigFactory::save()` → `StorageInterface::write()`, so
it can be thrown from anywhere a config object is saved, including entity saves of config
entities.
