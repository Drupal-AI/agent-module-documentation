<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Parameter plugin type and the built-in catalog

## The plugin type

- **Manager**: `plugin.manager.parameter` → `Drupal\parameters\Plugin\ParameterManager`
  (extends `DefaultPluginManager`). Discovery dir `Plugin/Parameter`, interface
  `ParameterInterface`, attribute `Drupal\parameters\Attribute\Parameter` (legacy annotation
  `Drupal\parameters\Annotation\Parameter` also supported). Alter hook `hook_parameter_info`.
- **Attribute args**: `id`, `label`, `weight` (sort), `entity_type`, `bundle`, `deriver`,
  `lazyDeriver`. `lazyDeriver` is preferred — derivatives are computed only when a specific
  derivative id is requested (the manager has custom lazy-derivative handling and caches them under
  `parameter_plugins:lazy`).
- **Base class**: `Drupal\parameters\Plugin\ParameterBase` — implements the config form,
  validation, `getProcessedData()` (a `TypedDataInterface`, `$dataType` default `string`),
  `getPreview()`, third-party settings, and `getUsageHelp()` (the name/token/twig snippets shown in
  the UI). Override `processDataValue()` to compute the value and `defaultConfiguration()` /
  `buildConfigurationForm()` for the stored shape.
- **Optional interfaces**: `PropertyParameterInterface` (`getProperty()` for dotted sub-access),
  `RenderableParameterInterface` (`toRenderable()`, e.g. Icon), `UsageParameterInterface`
  (`onAddition`/`onChange`/`onRemoval` lifecycle hooks fired from the collection's
  pre-save/pre-delete), `EntityParameterInterface` (entity-backed), plus core
  `AccessibleInterface`, `CacheableDependencyInterface`, `DependentPluginInterface`.

### Minimal custom type

```php
namespace Drupal\my_module\Plugin\Parameter;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\parameters\Attribute\Parameter;
use Drupal\parameters\Plugin\ParameterBase;

#[Parameter(id: "my_type", label: new TranslatableMarkup("My type"))]
class MyType extends ParameterBase {
  // Inherits a single 'value' textarea; override processDataValue()/schema as needed.
}
```

Add a matching `parameter.my_type` config schema extending `parameter_plugin`.

## Built-in parameter types

| id | label | notes |
|----|-------|-------|
| `string` | Raw string | plain value; emitted as markup by tokens (plugin is trusted to be safe) |
| `text` | Formatted text | stores value + filter format; rendered via `processed_text` (filtered) |
| `integer` / `float` | Integer / Float | numeric scalar |
| `boolean` | Boolean | true/false |
| `datetime` | Date and time | ISO-8601 UTC string |
| `machine_name` | Machine name | validated machine name |
| `color` | Color | color value |
| `options` | Options | defined option set + default |
| `icon` | Icon (SVG) | stores raw `<svg>…</svg>`, renders inline; `RenderableParameterInterface` |
| `secret` | Secret | value encrypted (AES-256-GCM) in config, revealed on read; salt via settings.php |
| `yaml` | Nested YAML | decoded structure; sub-keys addressable as properties |
| `http` | Http endpoint | fetches + caches remote JSON/text; response keys addressable as properties |
| `increment` | Incrementing integer | auto-incrementing counter with a min value |
| `reference` | Referenced parameter | points at another collection's parameter |
| `types` / `bundles` / `fields` / `roles` | Selection of entity types / bundles / fields / user roles | derived, entity-aware selection values |
| `null` | Null object | represents a non-existent parameter (returned by the graceful API) |
| `content` | Content | **deprecated**, from `parameters_content`; entity-backed, discouraged |

## Notes on notable types

- **`http`** (`Plugin/Parameter/Http.php`) — GET-only Guzzle client with a chained memory +
  consistent cache (`parameters:http` tag), lock-guarded fetch, TTL from `Cache-Control` bounded by
  `cache_ttl_min`/`cache_ttl_max` with `cache_volatility` jitter, and stale-fallback on failure. The
  URL is validated as a `Url` on save. Fetched content is cached and shared across all users/sessions
  (stated in the form help).
- **`secret`** (`Plugin/Parameter/Secret.php`) — `conceal()` on save, `reveal()` on read with a
  SHA-256 integrity check; a `parameter_secret` form element hides the field behind a show/hide
  toggle.
- **`icon`** (`Plugin/Parameter/Icon.php`) — validates the value starts with `<svg` and ends with
  `</svg>`; renders through the `parameter_icon` render element (an `HtmlTag`), exposing
  `value`/`contents`/`attributes`/sized-render properties.
