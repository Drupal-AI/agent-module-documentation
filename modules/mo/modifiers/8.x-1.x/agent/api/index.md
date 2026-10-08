<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modifiers — API reference

All paths relative to the module root
(`web/modules/contrib/modifiers`).

## Service `modifiers` — `Drupal\modifiers\Modifiers` (`src/Modifiers.php`)

Constructor args: `@module_handler`, `@plugin.manager.modifier`, `@theme.manager`.

- `const FIELD = 'field_modifiers'` — the entity reference field the entity-view hook looks for.
- `apply(array $modifications, array &$build, string $build_id)` — merges every `Modification`'s
  CSS/libraries/settings/attributes/links into `$build`. CSS becomes ONE inline
  `#attached['html_head']` `<style media="all" data-modifiers="$build_id">` with
  `#value => Markup::create($rendered_css)`. Links become head `<link>` tags. Settings/attributes go
  to `drupalSettings['modifiers']['settings'|'attributes'][$build_id]`.
- `renderCss(array $styles)` *(private)* — turns `[$media][$selector] => [$properties]` into a CSS
  string: `"$selector{" . implode(';', $properties) . "}"`, wrapped in
  `@media <query>{ … }` when `$media !== 'all'`. **No escaping is applied to selector or
  properties** — plugins are responsible for producing safe CSS (see security notes below).
- `extractEntityConfig(EntityInterface $entity, string $field_name, array $config = [])` — flattens a
  reference field's referenced entities into `$config[<short_field>][<bundle>][] = [field => value]`.
- `extractFieldConfig(FieldItemListInterface $field, array &$config)` — flattens one field (skips
  base fields).
- `getReferencedValue(...)` / `getSimpleValue(...)` — resolve a field to a scalar/array. Media &
  image → file URL (`File::createFileUrl()`); `color_field_type` → `rgba()`.
- `getColorValue(string $color, string $opacity): string` — hex → `rgba(r,g,b,opacity)`; returns `''`
  if the hex fails `preg_match('/[0-9A-F]{6}/i')`. Supports `#`, 3- and 6-digit hex.
- `getShortField(string $name)` — strips `field_mod_` then `field_` prefix.
- `process(array &$modifications, array $modifiers, string $selector)` — for each modifier id with a
  registered plugin definition, `createInstance($type)` and call `$plugin::modification($selector,
  $config)`, collecting non-empty `Modification` objects.

## Plugin contract

- Interface `Drupal\modifiers\ModifierInterface` — `public static function modification($selector,
  array $config): ?Modification`.
- Base `Drupal\modifiers\ModifierPluginBase` — provides `protected static getMediaQuery(array
  $config): string` (`$config['media_query']` or `'all'`).
- Attribute `Drupal\modifiers\Attribute\Modifier(id, ?label, ?description, ?deriver)` (also legacy
  annotation `Drupal\modifiers\Annotation\Modifier`).
- Manager `plugin.manager.modifier` (`ModifierPluginManager`) — subdir `Plugin/modifiers`; discovers
  in modules **and themes**; adds a `YamlDiscoveryDecorator` for `*.modifiers.yml`; alter hook
  `modifiers_info`; cache key `modifiers_plugins`.

## `Modification` value object (`src/Modification.php`)

Constructor: `__construct(array $css = [], array $libraries = [], array $settings = [], array
$attributes = [], array $links = [])`. Getters/setters for each. Shapes:

- `css`: `[$media_query][$css_selector] => [$css_property_string, …]` (`$media_query` `'all'` = no
  media wrapper).
- `libraries`: list of `module/library` strings.
- `settings`: JS dispatch descriptors, each typically `{namespace, callback, selector, media, args}`.
- `attributes`: `[$media][$selector][$attribute] => value|[values]` toggled by `modifiers.init.js`.
- `links`: arrays of `<link>` attributes (e.g. `{rel, href}`).

## Alter hooks (`modifiers.api.php`)

- `hook_modifiers_info_alter(array &$modifiers)` — modify plugin definitions (may set `class`,
  `provider`).
- `hook_modifiers_mappings_alter(array &$mappings)` — modify the entity-type/bundle → field-name
  mapping used by `getReferencedValue()`.
- `hook_modifiers_entity_view_config_alter(array &$config, array &$context)` — modify extracted
  config or the build; `$context` has `build`, `entity`, `display`.

Both `\Drupal::moduleHandler()->alter()` and `\Drupal::theme()...->alter()` are invoked for
`modifiers_mappings`, so themes can extend the mapping table too.

## Default reference mappings (`getReferencedValue()`)

```
media.audio         => [field_media_audio_file]
media.file          => [field_media_file]
media.image         => [field_media_image, image, field_file]
media.remote_video  => [field_media_oembed_video]
media.video         => [field_media_video_file, field_media_video_embed_field, field_file]
media.video_embed   => [field_media_video_embed_field, field_file]
taxonomy_term.modifiers_color => [field_mod_color]
```
First non-empty field wins. `color_field_type` → `rgba()`; `file`/`image` → file URL; else main
property value.
