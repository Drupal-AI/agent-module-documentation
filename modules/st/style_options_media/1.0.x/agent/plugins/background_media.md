<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `background_media` style option plugin

Class: `Drupal\style_options_media\Plugin\StyleOption\BackgroundMedia`
File: `src/Plugin/StyleOption/BackgroundMedia.php`
Annotation: `@StyleOption(id = "background_media", label = @Translation("Background media"))`
Extends `Drupal\style_options\Plugin\StyleOptionPluginBase`; uses `AjaxHelperTrait` and `StyleOptionStyleTrait`.

## Install / enable
```
composer require drupal/style_options_media
drush en style_options_media -y
```
Requires `style_options` and `media_library_form_element` (both pulled by Composer). Core Media + Media Library must be enabled for media entities to exist.

## Turning the option on
The plugin is not global; it renders only where a Style Options config file lists it. In a `[module|theme].style_options.yml` add `background_media` to the option set applied to your layouts/paragraph types (see the base `style_options` module docs for the file's full shape). Recommended: create a **`background`** view mode on your media types; otherwise the plugin falls back to `default`.

## Configuration form — `buildConfigurationForm()`
Builds a `#tree` fieldset `background_media` with two children:
- `media` — `#type => 'media_library'`, `#allowed_bundles => ['image', 'video', 'remote_video']`. Stores the selected media entity ID. Default from `getValue('background_media')['media']`.
- `blend_mode` — `#type => 'select'`, `#empty_value => ''`, 16 fixed options: `color, color-burn, color-dodge, darken, difference, exclusion, hard-light, hue, lighten, luminosity, multiply, normal, overlay, saturation, screen, soft-light`.

`submitConfigurationForm()` stores the cleaned form values via `setValues($form_state->cleanValues()->getValues())` (inherited pattern from the base class).

## Render — `build(array $build, $value = '')`
1. Reads stored config with `getValue('background_media')`; returns `$build` unchanged if empty.
2. Initializes `$build['#style_options_media']` (assigned by reference).
3. If a media ID is set: `entityTypeManager->getViewBuilder('media')` + `getStorage('media')->load($id)`, then `$styleOptions['media'] = $vb->view($media, 'background')`. The `background` view mode determines markup; media types without it fall back to core's `default`.
4. If `blend_mode` is set: `$styleOptions['blend_mode'] = $blendMode` (raw string).

## Consuming the output in a template
The values land on the element under `#style_options_media`:
- `#style_options_media['media']` — a media render array (view-mode output).
- `#style_options_media['blend_mode']` — one of the fixed blend-mode strings.

For a layout/paragraph, these appear in `elements` under `#style_options_media` (per the module README's "Theming" note). A layout template or paragraph behavior template prints `media` and typically maps `blend_mode` onto a `mix-blend-mode` / `background-blend-mode` CSS declaration or a modifier class.

## Notes
- Media ID and blend mode are set by whoever can edit the layout/paragraph (a privileged Style Options / Layout Builder / Paragraphs operation); no anonymous or request-driven input path exists.
- The plugin performs no external fetches; `remote_video` is handled by core Media's oEmbed pipeline, not by this module.
- Module ships no `config/install`, `config/schema`, `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.install`, or `.module` file — it is purely the one plugin class plus `*.info.yml` and README.
