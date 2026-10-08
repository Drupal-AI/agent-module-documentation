<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: template, GLightbox/oEmbed player, ept_core preprocess, libraries

This module has **no `.module` file and no hooks of its own**. All the rendering machinery — theme
registration, template suggestions, the design `<style>` block and the drupalSettings JS — is
provided by **`ept_core`** and applied to every `ept_*` bundle, including `ept_video`.

## Template

`templates/paragraph--ept-video--default.html.twig` is registered as the theme hook
`paragraph__ept_video__default` by **ept_core's** `hook_theme_registry_alter`
(`EptCoreHooks::themeRegistryAlter`, which points the hook at this module's `templates/` dir and
reuses the core `paragraph` preprocess pipeline). ept_core's `hook_theme_suggestions_paragraph_alter`
adds the `paragraph__ept_video…` suggestions.

The template:
- Builds wrapper classes: `paragraph`, `ept-paragragh`, `ept-video`, `paragraph--type--…`,
  `ept-paragraph--type--…`, view-mode class, unpublished class, and `paragraph-id-<id>`.
- `{{ attach_library('ept_video/ept_video') }}` — the CSS play-button overlay.
- Renders `<div class="bg-inner">` (background layer) and an `.ept-container` holding an `<h2>` for
  `field_ept_title` (only if rendered) and then `content|without('field_ept_settings',
  'field_ept_title')` — i.e. the video (`field_ept_video`) and body text (`field_ept_text`).
- Ends with **`{{ styles|raw }}`** — the design `<style>` string produced by ept_core (see below).

The template contains **no raw video URL / iframe**; the actual player markup comes from the media
field formatter.

## How the video plays (oEmbed + GLightbox)

`field_ept_video` renders the referenced `remote_video` media in the `ept_video` media view mode
(`entity_reference_entity_view`, `link: false`). That media display renders core's oEmbed field
`field_media_oembed_video` with the **`glightbox_media_remote_video`** formatter
(`glightbox_media_video` module) in **thumbnail** mode: a thumbnail image wrapped in a GLightbox
trigger link that opens the oEmbed player in an overlay.

The video URL itself lives on core Media's oEmbed field and is validated/resolved by **core Media**
against its configured provider allowlist (`oembed:video` source). Neither this module nor its
template ever prints an attacker-controlled URL into an `<iframe src>` / `<video src>` directly.

## ept_core preprocess & the `styles` variable

`EptCoreHooks::preprocessParagraph()` (ept_core) runs for any `ept_*` paragraph that has a
non-empty `field_ept_settings.design_options`:
- Calls `ept_core.generate_css` → `GenerateCSS::generateFromSettings($design_options,
  'paragraph-id-<id>')`, assigning the returned `<style>…</style>` string to `variables['styles']`
  (printed by the template's `{{ styles|raw }}`).
- Calls `ept_core.generate_js` and, when a background video/parallax is configured, attaches the
  relevant ept_core JS libraries and passes options via `drupalSettings.eptCore`.
- Adds `ept-edge-to-edge` and `ept-width-<size>` wrapper classes from the settings.

`EptCoreHooks::entityViewAlter()` applies the settings **ID anchor** (`Html::escape`) as the wrapper
`id` and splits **Additional CSS classes** (`Html::escape`, then `explode(' ')`) onto the wrapper
`class` array.

### `GenerateCSS` output (escaping)

`GenerateCSS::generateFromSettings()` builds a `.paragraph-id-<id> { … } <global styles> ` string
wrapped in `<style>…</style>`. Numeric box values, hex colors, selected border styles and container
widths are constrained by the widget; each interpolated value is passed through
`Html::escape()`. Background image URLs come from the referenced media File's URI. This module adds
no CSS-generation logic of its own — the mechanism is entirely ept_core's.

## Libraries (`ept_video.libraries.yml`)

- `ept_video/ept_video` — `css/ept-video.css` only. It draws the circular play-button icon
  (`img/play.svg`) centered over `.ept-video .glightbox-media-video` via a `::before` overlay.
  There is no JavaScript in this module; the lightbox behavior comes from `glightbox/glightbox`
  (pulled in by the `glightbox_media_remote_video` formatter) and background-media behavior from
  ept_core libraries.
