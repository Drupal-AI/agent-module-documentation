# Export / import mechanism (event subscribers, install hook)

Config Suite has no controller and no import/export commands of its own. All three behaviours are
event subscribers, plus a one-time install export. Both subscribers are declared in
`config_suite.services.yml` and tagged `event_subscriber`.

## Automatic export — `ConfigSuiteExportSubscriber::onConfigSave()`

`src/ConfigSuiteExportSubscriber.php`. The class extends core
`Drupal\system\SystemConfigSubscriber` (service `config_suite.config_subscriber`, arg
`@router.builder`, tag `event_subscriber`). It does not define `getSubscribedEvents()`, so it
inherits the parent's map — including `ConfigEvents::SAVE => onConfigSave` — and **overrides**
`onConfigSave(ConfigCrudEvent $event)`:

- returns immediately if `config_suite.settings:automatic_export` is falsy;
- otherwise reads the just-saved item name from the event and copies it from `config.storage`
  (active) to `config.storage.sync`: `$sync_storage->write($name, $active_storage->read($name))`;
- repeats the copy for every config collection (`$active_storage->getAllCollectionNames()`), logging a
  `config_suite` warning when the item is absent from a collection.

Because the override does not call `parent::onConfigSave()`, core's `SystemConfigSubscriber`
bookkeeping tied to that event (e.g. flagging a router rebuild when relevant config changes) does not
run through this subscriber.

## Cross-site UUID check override — `onConfigImporterValidateSiteUUID()`

Same class, overrides the parent validator that raises "Site UUID in source storage does not match
the target storage." It calls `$event->stopPropagation()` and returns `TRUE` unconditionally, so
imported config from a different site (different `system.site:uuid`) is accepted. This is what lets a
config export be reused across site copies — the module's headline feature.

## Automatic import — `ConfigSuiteImportSubscriber::checkForRedirection()`

`src/ConfigSuiteImportSubscriber.php`, service `page_load.config_subscriber`; subscribes to
`KernelEvents::REQUEST`. (The injected `@config.factory` argument is unused — the class has no
constructor and reads config statically; the class docblock about a "maintenance mode redirect" is
boilerplate that does not match its behaviour.) On every request it:

1. returns unless `"administrator"` is in `\Drupal::currentUser()->getRoles()` (a literal role
   machine-name check);
2. returns unless `config_suite.settings:automatic_import` is truthy;
3. builds a `StorageComparer(config.storage.sync, config.storage)` and a full core `ConfigImporter`;
4. compares `stat(Settings::get('config_sync_directory'))['mtime']` against the `cache_config`
   `ChainedFastBackend::LAST_WRITE_TIMESTAMP` read from `cache.backend.database`; **only when the sync
   directory is newer** does it call `$config_importer->initialize()` and loop `doSyncStep()` over
   every returned step — a full config import;
5. wraps the import in `try/catch (ConfigException)`, logging via `Error::logException()` to the
   `config_import` channel.

So a `git pull` into the sync directory is applied automatically the next time a user in the
`administrator` role loads any page; there is no separate manual import step.

## Install-time export — `config_suite_install()`

`config_suite.install`. On install it prints a BadCamp talk link, calls `drupal_flush_all_caches()`,
then copies **all** active config (and every collection) into the sync storage — a one-time full
export so the sync directory matches the running site immediately after enabling the module.
