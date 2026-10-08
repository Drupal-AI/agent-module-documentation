# Register an alternative filter manager

Plugins are only discovered from enabled modules. To provide config filters from somewhere the
plugin system can't see them — e.g. a PHP library or dynamically built filters — register your
own manager instead of (or in addition to) the plugin manager.

1. Implement `Drupal\config_filter\ConfigFilterManagerInterface`:
   - `getFiltersForStorages(array $storage_names, array $excluded = [])` — return an array of
     `StorageFilterInterface` instances, keyed by id.
   - `getFilterInstance($id)` — return one filter or `NULL`.
2. Register it as a service tagged `config.filter`:

```yaml
services:
  mymodule.config_filter_manager:
    class: Drupal\mymodule\MyConfigFilterManager
    tags:
      - { name: config.filter }
```

The `config_filter.storage_factory` collects every service tagged `config.filter` (via the
`service_collector` on `ConfigFilterStorageFactory::addConfigFilterManager()`). Managers with a
higher service `priority` are consulted first, and their filters win on id collisions — filters
from lower-priority managers do not overwrite already-added ids.

Note: the built-in `plugin.manager.config_filter` is itself just such a tagged manager, so your
manager runs alongside it.
