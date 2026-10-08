<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CastorcitoComponentField ("cfield") plugin type

The building block of a component. A `castorcito_component` entity holds a list of cfield
instances in its `field_configuration` (a `CastorcitoComponentFieldPluginCollection`); each cfield
defines a data model, an optional settings form, and pairs with an SDC under `components/cfields/`
for rendering.

## Plugin machinery

- **Annotation:** `@CastorcitoComponentField` (`src/Annotation/CastorcitoComponentField.php`) —
  `id`, `label`, `description`.
- **Manager:** `CastorcitoComponentFieldManager` (service
  `plugin.manager.castorcito_component_field`), plugin namespace
  `Plugin/CastorcitoComponentField`.
- **Base/interfaces:** `CastorcitoComponentFieldBase` and `ConfigurableComponentFieldBase`
  (implements `ConfigurableInterface`); `CastorcitoComponentFieldInterface`,
  `ConfigurableComponentFieldInterface`. Key methods: `defaultModel()` (the per-instance data
  shape), `defaultConfiguration()`, `buildConfigurationForm()`/`submitConfigurationForm()`,
  `overridableConfiguration()` (which settings a formatter display-override may change),
  `getFieldName()`/`getFieldLabel()`.
- Instances are created via `CastorcitoManager::getComponentFieldInstance($plugin_id)`; a cfield's
  settings form is fetched with `getComponentFieldInstanceConfigurationForm()`.

## Core cfields (`src/Plugin/CastorcitoComponentField/`)

| id | class | model / notable settings |
|---|---|---|
| `plain_text` | `PlainText` | `value` |
| `formatted_text` | `FormattedText` | `value`, `format` (default `basic_html`); setting `allowed_formats`. Rendered via `#type => processed_text` (text-format filtering applied). |
| `image` | `Image` | file `value`/`fid`/`alt`/`title`/`width`/`height`; settings `uri_scheme`, `extensions`, `directory`, `max_size`, `max_dimensions`, alt/title fields, `display.image_style`, `image_loading`. |
| `link` | `Link` | `value`/`relative`/`external`/`target`/`text`; settings `allow_link_text`, `url_autocomplete`. |
| `boolean` | `Boolean` | `value`; display `on_label`/`off_label`. |
| `number` | `Number` | `value`; settings `min`/`max`. |
| `list_text` | `ListText` | `value`; settings `options` (key/label), `condition`/`conditions` (form-state visibility), `set_default_value`/`default_value`. Allowed values managed at route `castorcito.field_list_text_allowed_value_form`. |
| `iframe` | `Iframe` | `option`/`url`/`value`; settings `options` (iframe/vimeo/youtube), `vimeo_options`, `youtube_options` (width/height, autoplay, mute, loop, rel, controls). Builds embed markup client-side (`assets/js/components/Form/Fields/iframe.js`). |
| `entity_reference` | `EntityReference` | `value`/`entity_type`/`entity_id`; settings `entity_type`, `entity_bundle`, `display.view_mode`. Rendered via `drupal_entity`. |
| `block_reference` | `BlockReference` | `block_id`; setting `allowed_provider` (restricts block providers). Rendered via `drupal_block`. Block list fetched from the `castorcito_block_list_resource` REST endpoint. |
| `container` | `Container` | holds child components; settings `allowed_children`, `min`/`max`, add/delete button labels, `collapse_container`, `group_items`/`group_items_quantity`. |
| `advanced_container` | `AdvancedContainer` | container with a `head_component` plus body children; settings `head_component`, `item_container_label`, `allowed_children`, `min`/`max`, labels, `collapse_container`. |

Sub-modules add cfields: `date` (castorcito_date) and `webform` (castorcito_webform).

## Reserved "predefined options" (from `hook_help`)

A component can define cfields with these machine names to control the wrapper markup, applied by
`CastorcitoComponentFormatter::predefinedOptionsAttribute()`:

- `component_classes_text` — space-separated CSS classes (validated: letters/digits/`-`/`_`, not
  starting with a digit).
- `component_classes_select` — a Select whose chosen key becomes a CSS class.
- `component_id` — sets the wrapper element's HTML `id`.

## Rendering

The formatter renders each component as `#type => component` (`#component` = the resolved SDC id)
with props `component_data` (the authored model), `display_settings`, `attributes`, and
`cfield_plugins`. The default SDC (`components/default_sdc/default_sdc.twig`) loops the model
fields and `embed`s each cfield's SDC (`<provider>:castorcito_<type>`). Container / advanced
container cfields recurse into child components. See
[../fields/widget-formatter.md](../fields/widget-formatter.md).
