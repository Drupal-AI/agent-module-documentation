# The `analytics_service` plugin type

## Discovery
- Manager: `AnalyticsServiceManager` (service `plugin.manager.analytics.service`), directory
  `Plugin/AnalyticsService`, interface `ServicePluginInterface`, annotation
  `@AnalyticsService` (`src/Annotation/AnalyticsService.php`: `id`, `label`, `multiple`).
- Alter hook: `hook_analytics_service_info_alter(&$definitions)`.
- `multiple = TRUE` lets a site create several service entities using the same plugin.

## Implementing one

Extend `ServicePluginBase` (implements `ServicePluginInterface` — `ConfigurableInterface`,
`PluginFormInterface`, etc.). Key methods:

- `defaultConfiguration(): array` — default config keys.
- `buildConfigurationForm($form, $form_state)` / `validateConfigurationForm` /
  `submitConfigurationForm` — the per-service settings subform (rendered inside
  `AnalyticsServiceForm`). Helper `ServicePluginBase::validateJson()` validates a JSON textarea.
- `getOutput(): array` — the render array appended to the page bottom when tracking is allowed.
  Emit `#type => html_tag` / `#attached['html_head']` script/style tags.
- `canTrack(): bool` — base implementation denies on admin routes and for
  `bypass all analytics services`; override to add conditions (or use the alter hook).
- `getCacheableUrls(): array`, `calculateDependencies()`.

Optional `ServiceDataTrait` adds `getData()` / `defaultData()`, firing alter hooks
`analytics_<service_id>_data` and `analytics_<plugin_id>_data` so other modules can inject
data-layer values.

`getAmpOutput(array $settings)` (on the base) builds an `<amp-analytics>` tag for AMP routes
(used by `analytics_amp`).

## Privacy wrapping

Wrap raw JS strings in `AnalyticsJsMarkup::create($js)` (`src/Render/AnalyticsJsMarkup.php`)
instead of `Markup::create()` when you want the Do Not Track guard applied automatically (it
prepends the `navigator.doNotTrack` check when `privacy.dnt` is on). `AnalyticsJsMarkup` is a
"known-safe string" marker — only pass strings that are not built from untrusted input.

## Bundled plugins

| Plugin id | Class | Module | Config keys |
|---|---|---|---|
| `google_tag_manager` | `GoogleTagManager` | analytics | `container_id`, `data_layer` (`name`,`value` JSON), `optimize_anti_flicker` |
| `google_optimize` | `GoogleOptimize` | analytics | `container_id`, `async`, `anti_flicker` |
| `google_ga` | `GoogleAnalyticsGa` | analytics_google | `id` (tracking id) |
| `amp_analytics` | `AmpAnalytics` | analytics_amp | `type`, `config_url`, `config_json` |
| `amp_tracking_pixel` | `AmpTrackingPixel` | analytics_amp | `url` |
| `piwik` | `Piwik` | analytics_piwik | `url`, `id` (site id) |

Note: emitted snippets are inline JS built from admin-entered config (`container_id`, data
layer, URLs) and injected site-wide by design; only `administer analytics` users can author them.
