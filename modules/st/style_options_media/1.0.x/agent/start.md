<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Style Options: Media (style_options_media) — agent index

Adds one Style Options plugin, **`background_media`**, that attaches a Media Library item (image/video/remote_video) plus a CSS blend mode to a layout component or paragraph. Installed version **1.0.0** (`core_version_requirement: ^10 || ^11`, PHP >= 8.1).

## What it provides
- **Plugin:** `@StyleOption("background_media")` — `Drupal\style_options_media\Plugin\StyleOption\BackgroundMedia` (extends `StyleOptionPluginBase`).
- Config form: a `media_library` element (allowed bundles `image`, `video`, `remote_video`) and a `blend_mode` select (16 CSS blend values).
- Render: loads the media entity and builds it with the `background` view mode, exposed on the element under `#style_options_media` (`media` render array + `blend_mode` string).
- No routes, permissions, services, hooks, config/install, or config/schema of its own.

## Dependencies
- `drupal/style_options` (`^1`) — provides the `@StyleOption` plugin type and base class.
- `drupal/media_library_form_element` (`^2.1`) — provides the `media_library` form element.
- Implies core Media + Media Library (media entities).

## How to enable the option
The plugin only appears where a `style_options` config file references it. Add `background_media` under the options in a `[module|theme].style_options.yml`. See the solution doc.

## Solution docs
- [Background media plugin & configuration](plugins/background_media.md)
