<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Formatter Template (fft) — agent index

Lets a site builder select a **Twig template** for **any field's formatter**, chosen from files
placed in a **configured directory** and annotated with a `{# Template Name: … #}` header. Package
`Field`. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 3.0.1. **No
external dependencies**, no permissions of its own, no Drush. Ships one submodule, **vff** (Views
Formatter).

- **The `fft_formatter` field formatter, its settings, how templates are discovered, tokens, image
  styles, events** → [fields/formatter.md](fields/formatter.md)
- **The settings form, config object, and the template directory** → [config/settings.md](config/settings.md)
- **Submodule vff (Views style)** is documented in its own tree:
  `modules/ff/fft/modules/vff/3.0.x/`

## What it actually is

- One field formatter plugin: **`FFTFormatter`** (id `fft_formatter`, label *"Formatter Template"*),
  in `src/Plugin/Field/FieldFormatter/FFTFormatter.php`, extending core
  `EntityReferenceFormatterBase`. Its annotation lists only `text`/`text_long`/`text_with_summary`,
  but `fft_field_formatter_info_alter()` in `fft.module` **rewrites `field_types` to every field
  type on the site**, so it is selectable on any field.
- One config form: **`SettingsForm`** (route `fft.admin_settings`, path
  `/admin/config/content/fft`, permission `administer site configuration`) editing config object
  **`fft.settings`** — a single key, `fft_storage_dir` (the template directory).
- One event: **`PreProcess`** (`src/Event/PreProcess.php`, constant `fft.preprocess`), dispatched
  before each template renders with a mutable `variables` reference.
- No config schema (only `config/install/fft.settings.yml`), no `.install`, no entities, no
  services file. A JS behavior (`js/fft.js`, library `fft/backend`) drives the settings-extras UI.

## Mechanism (from source, all in `fft.module`)

- `fft_get_templates($prefix)` scans `fft_storage_dir()` with `file_system->scanDirectory()` for
  `*.html.twig`, keeps files matching `{# Template Name: … #}` whose name starts with `$prefix`
  (`fft` for formatters), and reads an optional `{# Settings: … #}` block. Missing directory →
  a logged warning and an empty list.
- `FFTFormatter::viewElements()` → `fft_field_formatter_render($entity, $type, $items, $settings)`.
  It shapes `data` per field type (image → uri/path/alt/width/height + optional image-style
  derivatives; text → processed/summary; entity_reference → the referenced entities; else
  `$item->getValue()`), parses the settings-extras textarea with `drupal_parse_info_format()`,
  resolves `js`/`css` paths via `fft_realpath()`, and calls `fft_render()`.
- `fft_render($template_file, $variables)` dispatches `PreProcess`, then renders through Drupal's
  **sandboxed** Twig via the procedural `twig_render_template()`. Output is wrapped in an
  `#type => inline_template` render element with `{{ content|raw }}`.
- `FFTFormatter::view()` drops `#theme` when the `reset` setting is `'1'`, removing core's default
  field wrapper.

## Notes / caveats

- `fft_render()` and `fft_theme_extension()` use the legacy `global $theme_engine` and the
  procedural `twig_render_template()`, which is undefined outside a themed web request — these
  paths throw in CLI/unit contexts (robustness bug).
- Templates are trusted, site-builder-authored code: authoring them requires write access to the
  configured directory, and a template only renders where a site builder selects it on a formatter.
- Default `fft_storage_dir` is `sites/all/formatter`, a **Drupal 7 path** that does not exist on
  D8+; the setting must be changed before any template is discovered — see
  [config/settings.md](config/settings.md).
