<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `eplikt_source` plugin type

Source plugins decide **which entities** appear in the feeds. The controller merges the entities
returned by every enabled source.

## Plugin type wiring

- Discovery dir: `Plugin/eplikt` (`EpliktSourcePluginManager` constructor).
- Annotation: `Drupal\eplikt\Annotation\EpliktSource` (`@EpliktSource`) — keys `id`, `label`,
  `description`, `provider`.
- Interface: `EpliktSourceInterface` (extends `ConfigurableInterface`,
  `PluginInspectionInterface`, `PluginFormInterface`, `ContainerFactoryPluginInterface`).
- Base class: `EpliktSourceBase` (extends `PluginBase`).
- Manager service: `plugin.manager.eplikt_source` (`EpliktSourcePluginManager`, parent
  `default_plugin_manager`); alter hook `eplikt_source_info`, cache key `eplikt_source_info`.

### `EpliktSourceInterface`

- `getLabel(): string`, `getDescription(): string` — from the annotation (implemented in base).
- `getEntities(?int $max_age = NULL): ContentEntityInterface[]` — **the method you implement.**
  `$max_age` (seconds) is passed only for the weekly feed; NULL means "all".
- Inherited `PluginFormInterface`: `buildConfigurationForm()`, `validateConfigurationForm()`,
  `submitConfigurationForm()`.
- Inherited `ConfigurableInterface`: `getConfiguration()`, `setConfiguration()`,
  `defaultConfiguration()` (base returns `['id' => …, 'provider' => …]`).

## Shipped plugins

Both live in `src/Plugin/eplikt/` and extend `EpliktSourceBase`; identical logic against different
storage.

| Plugin | id | Storage | Target |
|---|---|---|---|
| `NodeSource` | `node_source` | `node` | Node entities |
| `MediaSource` | `media_source` | `media` | Media entities |

`getEntities()` (both): builds an entity query with
`accessCheck(TRUE)->condition('status', 1)->sort('created', 'DESC')`; adds
`condition('bundle', $configuration['bundles'], 'IN')` when bundles are configured; adds
`condition('changed', time() - $max_age, '>=')` when `$max_age` is set; then `loadMultiple()` on the
result. So a feed only ever contains **published** entities the requester is allowed to view
(access checked as the current user), newest first.

`buildConfigurationForm()` (both): a multi-select `bundles` element listing the entity type's
bundles (`entity_type.bundle.info`). `submitConfigurationForm()` stores
`$configuration['bundles']`. `validateConfigurationForm()` is a no-op.

## Writing a custom source

1. Create `src/Plugin/eplikt/MySource.php` in your module, annotate with `@EpliktSource` (`id`,
   `label`, optional `description`).
2. Extend `EpliktSourceBase` and implement `getEntities(?int $max_age = NULL)` returning
   `ContentEntityInterface[]` — honour `$max_age` and set `accessCheck(TRUE)` on any query.
3. Optionally override `buildConfigurationForm()` / `submitConfigurationForm()` for per-source
   settings (stored flat under `<plugin_id>.<key>` in `eplikt.settings`).
4. Clear caches; the plugin then appears in the settings form's **Sources** select.

Note: `EpliktController::getEnabledSources()` calls `setConfiguration($config->get($id))`, so your
plugin reads its saved config from `$this->configuration` at feed-build time. The base's
`create()` injects nothing extra; the shipped plugins add their own `create()` for
`entity_type.manager` + `entity_type.bundle.info`.
