<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EnricherDatasource plugin type

The pluggable point of the module: a datasource fetches contact data for a token and returns
cookies. Enrichers reference datasource instances (with per-instance settings) in their
`datasources` config array.

## Discovery / manager

- Manager: `EnricherDatasourceManager` (`src/EnricherDatasourceManager.php`), service
  `plugin.manager.enricher.datasource` (`parent: default_plugin_manager`). Subdir
  `Plugin/EnricherDatasource`, interface `EnricherDatasourceInterface`, attribute
  `Drupal\convivial_enricher\Attribute\EnricherDatasource`, legacy annotation
  `Drupal\convivial_enricher\Annotation\EnricherDatasource`. Alter hook
  `convivial_enricher_datasource_info`; cache key `convivial_enricher_datasource_plugins`.
- Plugin id/label/description come from the attribute (`src/Attribute/EnricherDatasource.php`:
  `id`, `?TranslatableMarkup $label`, `?TranslatableMarkup $description`, `?string $deriver`).

## Interface (`EnricherDatasourceInterface`)

Extends `PluginInspectionInterface`, `ConfigurableInterface`, `DependentPluginInterface`,
`PluginFormInterface`. Datasource-specific methods:

- `getSummary()`, `label()`, `getUuid()`, `getWeight()`/`setWeight($w)`.
- `processIncomingPath(&$path, string $endpoint_path)` — inbound URL rewriting hook (may leave the
  path untouched).
- `fetchAndProcessData($key)` — given the token/key, returns
  `Symfony\Component\HttpFoundation\Cookie[]` (or an array; the helper only attaches `Cookie`
  instances) to be set on the redirect response.

## Base class (`EnricherDatasourceBase`)

`abstract class EnricherDatasourceBase extends PluginBase implements EnricherDatasourceInterface,
ContainerFactoryPluginInterface`. Provides:

- Constructor DI of a `logger` (channel `convivial_enricher` via `logger.factory`).
- `setConfiguration()`/`getConfiguration()` — persists `{uuid, id, weight, settings}`; `settings`
  merges over `defaultConfiguration()` (empty by default).
- No-op `validateConfigurationForm()` / `submitConfigurationForm()` (subclasses override).
- `createCookie($name, $value, $expire = "+1 day")` →
  `Cookie::create('convivial_enricher_' . $name, $value, $expire, '/', NULL, FALSE, FALSE, FALSE,
  NULL)`. All emitted cookies are namespaced `convivial_enricher_*`.

## Bundled plugin: `dummy` (`DummyEnricherDatasource`)

- Attribute id `dummy`, label *"Dummy datasource"*, "Useful for testing purposes."
- `defaultConfiguration()` → `dummy_title => NULL`; `buildConfigurationForm()` exposes a required
  *Dummy Textfield*; schema `convivial_enricher.datasource.dummy` (`dummy_title: string`).
- `fetchAndProcessData($key)` returns `$key` unchanged; `processIncomingPath()` returns `$path`
  unchanged. Emits no real cookies — it exists to exercise the endpoint/redirect wiring.

## Writing a custom datasource

Add a class under `Plugin/EnricherDatasource` with `#[EnricherDatasource(id: '…', label: …)]`,
extend `EnricherDatasourceBase`, implement `buildConfigurationForm()`/`submitConfigurationForm()`
for its settings, `processIncomingPath()` if the inbound URL needs reshaping, and
`fetchAndProcessData($token)` to query your backend and return `createCookie()` results. Register a
`convivial_enricher.datasource.<id>` schema mapping for the settings. See the packaged
ActiveCampaign / Mailchimp / Recombee submodules for full examples.
