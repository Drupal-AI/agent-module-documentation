DX Toolkit is a code-only developer library that gives module authors plugin systems, an entity-generator, and hardened extensions of core utility classes to cut boilerplate.

---

DX Toolkit provides reusable PHP primitives for building Drupal modules; it defines no routes, controllers, permissions, blocks, or admin configuration and therefore has no runtime web surface of its own. Its centerpiece is the EntityGenerator plugin system, which iterates the bundles of a "source" entity type and programmatically creates a companion configuration entity for each (for example a Feed Type per taxonomy vocabulary), driven by the `@EntityGenerator` annotation, the `plugin.manager.entity_generator` manager, `EntityGeneratorBase`, and the `EntityTypeSourceEntityDeriver`. A `FeedTypeGeneratorBase` specialization adds Feeds-aware Feed Type and Feed creation/import. Alongside this it defines a `@ServiceInjector` annotation for a factory-based auto-service pattern (demonstrated by the `dx_toolkit_demo` submodule), a ServiceInstance pattern for `MyService::getService()` static access, extended plugin base classes and managers, an OO wrapper around Drupal's State key/value store, and subclasses of core's Color, Json, Environment and array utilities. Requires PHP 8.1+ and works on Drupal 9, 10, or 11. You add it as a Composer dependency and call its classes from your own module code; enable the demo submodule to see working examples.

---

- Programmatically generate a companion config entity for every bundle of an entity type using an `@EntityGenerator` plugin plus `plugin.manager.entity_generator`.
- Create a View Mode, REST Resource config, or entity form display for each bundle of a custom entity type without hand-writing each config file.
- Generate a Feeds Feed Type for every taxonomy vocabulary (or any source bundle) by extending `FeedTypeGeneratorBase`.
- Bulk-create all generator-derived entities at once with `EntityGeneratorManager::generateAllEntities()`, skipping ones that already exist.
- Bulk-delete generator-created entities with `EntityGeneratorManager::deleteAllEntities()` when tearing down.
- Merge a shipped prototype config file with per-bundle overrides via `getBaseConfigurationData()` + `customConfiguration()` (NestedArray::mergeDeep).
- Automatically create and import a Feed for each generated Feed Type with `FeedTypeGeneratorBase::generateFeed()` / `import()`.
- Give a service self-lookup ability so callers can write `MyService::getService()` by implementing `ServiceInstanceInterface` with `ServiceInstanceTrait`.
- Build a custom annotation-based plugin type quickly by extending `PluginManager` and `PluginBase`.
- Instantiate every plugin (or every derivative of a base plugin) in one call with `PluginManager::createInstances()` / `createDerivativeInstances()`.
- Populate a Form API `#options` array from a plugin manager's definitions with `PluginManager::optionLabels()`.
- Look up plugin definitions by arbitrary property values using `PluginManagerPropertyQueryTrait::findByProperties()` (loadByProperties-style querying for plugins).
- Wrap a Drupal State value in a typed object (name + optional context) with `StateBase`, including array-value helpers `setArrayValue()`/`arrayValue()`.
- Track install-phase behavior safely with the shipped `PreInstallState` flag (set in `hook_module_preinstall` / `hook_install`).
- Normalize any CSS hex color to `#rrggbb` and validate it (throws on bad input) with `Color::normalize()`.
- Pick the most readable text color over a background using `Color::contrastYIQ()`, `contrast50()`, `contrastLuminance()`, or `calculateBestContrast()`.
- Convert a hex color to `rgba(...)` with an opacity via `Color::hexToRgba()`.
- Safely decode JSON that may contain BOMs or control characters using `Json::decode()` / `Json::cleanJsonString()`.
- Detect a CLI/Drush execution context reliably with `Environment::isCli()`.
- Extract a single field property (or several) across all deltas of an entity field with `EntityFieldPropertyAdapter::fieldPropertyValues()`.
- Build an id => label options array from an entity storage handler or an array of entities with `OptionsGenerator`.
- Reindex, combine, column-extract, or key-sort arrays with the `ArrayUtilities` helpers (`arrayKeysCombined`, `arrayMapMerged`, `arrayKeyColumn`, `arraySortByKeys`).
- Resolve a module's own path/root statically inside utility code via the `Extension` / `ExtensionTrait` helpers.
- Coerce any value to an array with `AsArrayTrait::asArray()` before iterating.
- Study the `dx_toolkit_demo` submodule as a template for writing your own ServiceInjector plugins and derivers.
