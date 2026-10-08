<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering: templates, preprocess, theme hook, `{{ styles|raw }}` & libraries

The module contributes markup through three Twig templates, one procedural preprocess, and one
`theme_registry_alter` hook. The `{{ styles|raw }}` design block and the `drupalSettings` options are
assembled by **ept_core** at view time; this module's own preprocess only computes an event image URL.

## Preprocess (`ept_timeline.module`)

`ept_timeline_preprocess_paragraph(&$variables)` runs for every paragraph but returns early unless the
bundle is `ept_timeline_item` and `field_ept_timeline_media_image` holds a media entity. When it does,
it loads the source `File` from the media entity and sets
`$variables['media_image'] = $file->createFileUrl()` (a relative URL to the uploaded file). The
`ept_timeline_item` template uses that URL as a CSS `background: … url('{{ media_image }}') …`. No
request data is involved — the media entity is chosen by a privileged editor and `createFileUrl()`
returns the managed-file URL.

## Hook (`Drupal\ept_timeline\Hook\EptTimelineHooks`)

One implementation, autowired via `ept_timeline.services.yml`; `ept_timeline.module` keeps a thin
`#[LegacyHook]` wrapper for `ept_timeline_theme_registry_alter()`.

| Hook | Method | Effect |
|---|---|---|
| `hook_theme_registry_alter` | `themeRegistryAlter()` (`src/Hook/EptTimelineHooks.php:16`) | Registers two dedicated theme entries pointing at this module's `templates/` dir: `paragraph__ept_timeline_item__default` (base hook `paragraph`, initial preprocess `template_preprocess_paragraph`) and `field__paragraph__field_ept_timeline__ept_timeline` (base hook `field`, initial preprocess `template_preprocess_field`), copying the base hook's `render element` and preprocess pipeline. |

The wrapper bundle template `paragraph--ept-timeline--default.html.twig` needs no registration — the
Paragraphs module already provides the `paragraph__ept_timeline__default` bundle suggestion.

## Templates

- `templates/paragraph--ept-timeline--default.html.twig` — the wrapper. Builds `ept-paragraph`
  classes including `ept-timeline-<styles>` read from
  `content.field_ept_settings['#object'].field_ept_settings.ept_settings.styles`; if `styles ==
  'simple_vertical'` it `attach_library('ept_timeline/simple_vertical')`. Renders `field_ept_title`
  in an `<h2>`, then prints the remaining fields with
  `content|without('field_ept_settings', 'field_ept_title')`, and ends with `{{ styles|raw }}`.
  **Quirks:** the class list also contains a stray copy-paste class `ept-accordion`; and it calls
  `attach_library('ept_timeline/jquery_ui_timeline')` — a library that is **not defined** in
  `ept_timeline.libraries.yml` (only `simple_vertical` exists), so Drupal logs a "library not found"
  warning and attaches nothing. The timeline is pure CSS and works without it.
- `templates/paragraph--ept-timeline-item--default.html.twig` — one event. Reads
  `field_ept_timeline_current.0['#markup'] == 'On'` to add a `timeline-current` class, then builds a
  `.timeline-item` with a `.timeline-img` marker dot and a `.timeline-content` block. When
  `media_image` (from the preprocess) is set it renders a `.timeline-img-header` whose inline `style`
  uses `url('{{ media_image }}')` as the background; it prints `.timeline-date`,
  `.timeline-title` (`<h3>`) and `.timeline-text`, then the leftover fields via
  `content|without(...)`. Ends by attaching `core/drupalSettings`. **Quirk:** it also references a
  legacy `field_ept_timeline_image` field that this module does not ship (only
  `field_ept_timeline_media_image` exists), so that branch is always empty.
- `templates/field--paragraph--field-ept-timeline--ept-timeline.html.twig` — the field template for
  `field_ept_timeline`. Adds the wrapper class **`ept-timeline-wrapper`** (the element the
  `simple_vertical` CSS draws the central spine on) and renders each event item.

### `{{ styles|raw }}`

`styles` is set by ept_core's `hook_preprocess_paragraph` (`EptCoreHooks::preprocessParagraph`) to the
string returned by the `ept_core.generate_css` service (`GenerateCSS::generateFromSettings`). That
service builds a `<style>.paragraph-id-<id>{ … }</style>` block from the paragraph's **design_options**
only, and passes each value through `Html::escape()` (confirmed in
`ept_core/src/Services/GenerateCSS.php`). The design values come from the privileged editor's Settings
tab; **no request data reaches this block**, so the `|raw` filter here is not a vulnerability.

## Libraries (`ept_timeline.libraries.yml`)

Only one library is defined:

`ept_timeline/simple_vertical`:
- CSS (component): `css/simple_vertical/simple_vertical.css` — the entire vertical-timeline layout
  (central spine, alternating left/right cards, marker dots, date badge, image header).

There is **no JS library** and no external/vendored dependency (contrast `ept_slideshow`, which ships
Flexslider). The `ept_timeline/jquery_ui_timeline` referenced by the wrapper template does not exist.
