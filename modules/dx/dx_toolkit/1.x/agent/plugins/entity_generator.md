<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityGenerator, FeedTypeGenerator & the ServiceInjector annotation

Source: `src/Annotation/EntityGenerator.php`, `src/Plugin/EntityGeneratorManager.php`,
`src/Plugin/EntityGeneratorBase.php`, `src/Plugin/EntityGeneratorInterface.php`,
`src/Plugin/EntityGenerator/Derivative/EntityTypeSourceEntityDeriver.php`,
`src/Plugin/FeedTypeGeneratorBase.php`, `src/Annotation/ServiceInjector.php`.

## EntityGenerator: what it does

Given a **source** entity type, the deriver produces one plugin derivative per **bundle** of that
source, and each derivative can create (or delete) a **target** config entity built from a shipped
prototype config file merged with per-bundle overrides. Use it to fan a single template across
every bundle (e.g. a Feed Type per vocabulary, a view mode per node type).

Manager service: `plugin.manager.entity_generator` (`EntityGeneratorManager`, `parent:
default_plugin_manager`), plugin directory `Plugin/EntityGenerator`, alter hook
`entity_generator_info`, cache bin key `entity_generator_plugins`.

## Writing a generator plugin

Annotation keys (`@EntityGenerator`, extends `Annotation\PluginBase` → `id`, `label`,
`description`):

- `sourceEntityTypeId` — bundles of this type drive derivation. **Required**; without it the
  deriver returns no derivatives (`EntityTypeSourceEntityDeriver::getDerivativeDefinitions`).
- `targetEntityTypeId` — entity type to create.
- `configName` — prototype config filename (no extension).
- `configPath` — folder holding it, default `config/prototype`.
- `sourceModule` — module that ships the prototype file.
- `bundleName` — injected per-derivative by the deriver (one per source bundle).
- `deriver` — defaults to `EntityTypeSourceEntityDeriver::class`.

Extend `EntityGeneratorBase` (implements `EntityGeneratorInterface`,
`ContainerFactoryPluginInterface`). It injects `entity_type.manager`, `entity_type.bundle.info`,
`module_handler` and resolves source/target storage + definitions in its constructor. You must
implement `customConfiguration()` (per-bundle overrides) and `targetId()` (≤32 chars).

Key `EntityGeneratorBase` methods:

- `getBaseConfigurationData()` — reads the prototype via `FileStorage` at
  `Extension::root()/<extensionPath>/<configPath>`; returns `[]` if the file is absent.
- `getTargetEntityConfiguration()` — `NestedArray::mergeDeep(base, customConfiguration())`.
- `generateEntity()` — creates+saves the target **only if `hasTargetEntity()` is false** (idempotent).
- `getTargetEntity()` / `hasTargetEntity()` — load by `targetId()`.
- `deleteTargetEntity()` — deletes it if present.

Manager bulk operations (by base plugin id):

- `generateAllEntities($base_plugin_id)` — instantiate every derivative and call `generateEntity()`.
- `entities($base_plugin_id)` — target entities for derivatives that already have one.
- `deleteAllEntities($base_plugin_id)` — delete every derivative's target.

## FeedTypeGeneratorBase (requires drupal/feeds)

`Plugin/FeedTypeGeneratorBase` extends `EntityGeneratorBase` for `feeds_feed_type` targets. Its
`customConfiguration()` builds a Feed Type (`processor = entity:<source type>`, bundle-scoped
`processor_configuration`), `targetId()` is `"<bundle>_importer"`, and it adds Feed lifecycle
helpers: `generateFeed($source)` (creates one `feeds_feed`, owner uid from `feedOwnerUid()` =
`'1'`), `feeds()`, `deleteFeeds()`, `import($source)`. Note: this class references
`Drupal\feeds\*`, so the **Feeds module must be installed** to use it — dx_toolkit does not declare
Feeds as a dependency.

## @ServiceInjector — annotation only in 1.0.1

`src/Annotation/ServiceInjector.php` defines keys `factoryService`, `factoryMethod`,
`factoryArguments`, `serviceClass`, `servicePrefix` (default `service_injector`), `serviceSuffix`,
`deriver`. The README describes it auto-registering factory services (e.g.
`service_injector.node.storage`) during container compilation.

**Important accuracy note:** in this 1.0.1 release the module ships **no `ServiceInjectorBase`
class, no ServiceInjector plugin manager, and no service provider / compiler pass** that would
collect these plugins and register the services. The `dx_toolkit_demo` submodule's ServiceInjector
plugins `extend Drupal\dx_toolkit\Plugin\ServiceInjectorBase`, which does not exist in this module —
so the ServiceInjector pattern is not functional as shipped here. Treat `@ServiceInjector` as a
declared plugin type whose runtime implementation is not present in 1.0.1.
