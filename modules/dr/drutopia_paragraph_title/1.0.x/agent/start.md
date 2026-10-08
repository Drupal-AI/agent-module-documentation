<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Title Paragraph (drutopia_paragraph_title) — agent index

**A `title` Paragraphs bundle (title, subtitle, colour, style classes, titlebar, image) with Twig templates + CSS that render a hero-style page header. Config + theming only — no PHP `src/`, routes, permissions or services.**

- **Version:** 1.0.x — **DEV CHECKOUT** on disk (`info.yml` has no `version:`; installed from git branch `1.0.x`). No packaged release version.
- **Distribution:** ships as part of the Drutopia family; requires `drutopia_core`. On this site it FAILED to enable because the full Drutopia dependency chain is absent — that is expected; these docs are written from on-disk source, not a running instance.
- **Core:** `^10.2 || ^11 || ^12` · **Package:** Drutopia · **License:** GPL-2.0-or-later.
- **Depends on:** allowed_formats, drutopia_core, entity_reference_revisions, field, image, minimalhtmltitle, paragraphs, text, ui_patterns, ui_patterns_ds, ui_patterns_layouts, ui_patterns_library.
- **Composer require:** drupal/allowed_formats ^3, drupal/drutopia_core "^1 || ^2", drupal/minimalhtml ^2, drupal/paragraphs ^1.

## What it actually ships

- **One Paragraphs type:** `title` (`config/install/paragraphs.paragraphs_type.title.yml`) — "A title for your content with an optional image and subtitle."
- **Six fields** on the bundle (see [paragraphs/title.md](paragraphs/title.md)): `field_title`, `field_subtitle` (text), `field_image` (image), `field_style_color`, `field_style_classes` (list_string), `field_style_titlebar` (boolean).
- **Displays:** form display + two view displays (`default`, `columnar`) and two image styles (`max_650x650`, `max_325x325`).
- **`.module`:** only `hook_theme()` — registers `paragraph__title`, `field__field_title`, `field__field_subtitle`, `field__field_style_color`.
- **Library:** `title_paragraphs` (`styles.css`) attached by `paragraph--title.html.twig`.
- **Templates:** `paragraph--title`, `paragraph--title--columnar`, `paragraph--title--preview`, `field--field-title`, `field--field-subtitle`, `field--field-style-color`, `field--paragraph--field-subtitle--preview`, plus a UI Patterns component under `templates/patterns/title_paragraph/`.
- **No** `src/`, routing, permissions, services, install hooks, config schema, Drush, or submodules.

## Solution docs

- **The `title` bundle, its fields, the `.module`, the library and every template / UI pattern** → [paragraphs/title.md](paragraphs/title.md)

## Operate it

Enable the module (imports the type, fields, displays, image styles), then add the `title` paragraph to a content type's Paragraphs field and arrange it at the top of the display. No settings form.
