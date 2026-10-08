Configuration Filter is an API-only module that lets other modules intercept and transform Drupal's configuration as it is imported from or exported to the sync storage, using `ConfigFilter` plugins.

---

Drupal core (since 8.8) has a config storage transformation API that fires events when configuration is synchronized between the active database and the exported YAML files. Configuration Filter bridges that API with a simpler, pluggable interface: a `ConfigFilter` is a plugin that can rewrite, add, remove, or hide configuration on read and write operations against a storage (typically `config.storage.sync`). The module ships the plugin type (annotation, interface, base class, and plugin manager), a `FilteredStorage` decorator that applies an ordered chain of filters to any `StorageInterface`, and a storage factory that assembles the filtered sync storage. It has no UI, no permissions, no schema, and no configuration of its own — you never really "use" it directly; you depend on it from a module that provides filters. Filters are sorted by weight, can be toggled with a `status` flag, and target specific storages. For providers outside the plugin system (for example a PHP library), you can register an alternative manager by implementing `ConfigFilterManagerInterface` and tagging the service `config.filter`. It also provides handy `ReadOnlyStorage` and `GhostStorage` decorators. The best-known consumer is Configuration Split, which uses filters to split site config per environment.

---

- Depend on it from a contrib/custom module that needs to alter config during import/export.
- Provide a `ConfigFilter` plugin that strips secrets (API keys, passwords) from exported config.
- Inject environment-specific values into config on import without editing the YAML files.
- Split configuration into conditional sets per environment (the Config Split use case).
- Remove development-only modules' config from a production export.
- Rewrite a configuration value on the fly as it is read from the sync storage.
- Add configuration objects that do not exist in the sync directory during import.
- Hide certain config objects from `listAll()` so tools do not see them.
- Prevent specific config from being deleted during a sync with a delete filter.
- React to config collections (e.g. language overrides) by filtering per collection.
- Chain several filters in a defined weight order over one storage.
- Toggle a filter on or off via its `status` annotation property without removing it.
- Target filters at a specific storage name via the `storages` annotation property.
- Wrap an arbitrary `StorageInterface` with `FilteredStorage` in custom code.
- Use `ReadOnlyStorage` to expose a config storage that rejects all write operations.
- Use `GhostStorage` to silently swallow writes while still serving reads.
- Register an alternative filter manager from a PHP library via the `config.filter` service tag.
- Alter the discovered filter definitions through `hook_config_filter_info_alter()`.
- Build a config transformation pipeline compatible with Drupal 8.8+ core events.
- Programmatically fetch the filtered sync storage via the `config_filter.storage_factory` service.
- Exclude specific filters when building a storage with `getSyncWithoutExcluded()`.
- Read configuration as Drupal will see it (post-filter) from within a filter.
- Support modules that must run on both config_filter 1.x and 2.x with one API.
- Simulate import/export transformation in tests using the shipped storage decorators.
