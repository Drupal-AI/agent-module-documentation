<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Webform (ebt_webform) — agent index

A **config-only** module that adds one reusable custom block type, **`ebt_webform`**
(`block_content` bundle, label *"EBT Webform"*), which **embeds a selected Webform inline**
wrapped in the shared EBT design/styling controls. Package *Extra Block Types*. Version dir
**2.x** (installed 2.0.0). Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.

- **The block type, its fields, displays, install, and how styling renders** →
  [block-types/ebt-webform.md](block-types/ebt-webform.md)

## What it actually is

- **No `src/`, no routes, no permissions, no services, no Drush.** The whole module is
  `*.info.yml`, one `*.install` update, `config/install/*` (the bundle + fields + form/view
  displays), and two block Twig templates. All runtime behavior comes from **`ebt_core`**.
- Dependencies (`ebt_webform.info.yml`): `ebt_core:ebt_core`, `paragraphs:paragraphs`,
  `webform:webform`. Composer `require`: `drupal/ebt_core ^2.0`, `drupal/paragraphs ^1.0`,
  `drupal/webform ^6.0`.

## Fields on the `ebt_webform` bundle (config/install)

- **`field_ebt_webform_form`** — field type `webform` (target_type `webform`), **required**,
  cardinality 1. Widget `webform_entity_reference_select`; view formatter
  `webform_entity_reference_entity_view` with `source_entity: true`. This is the form to embed.
  `ebt_webform_update_9101()` sets this field required on existing sites.
- **`body`** — `text_with_summary` (label *Text*), optional intro copy.
- **`field_ebt_settings`** — field type `ebt_settings` (provided by ebt_core), the shared EBT
  design options (spacing, borders, background, container width). Hidden from output by the
  template's `content|without('field_ebt_settings')`.

## Rendering

- Templates `templates/block--block-content--ebt-webform.html.twig` and
  `block--inline-block--ebt-webform.html.twig` wrap content in `.ebt-block .ebt-container`,
  print the label, then output `{{ styles|raw }}`.
- `styles` is built by **ebt_core's `preprocess_block`** hook →
  `ebt_core.generate_css` service (`GenerateCSS::generateFromSettings()`), which emits an inline
  `<style>` block from the block's design options. Values are passed through
  `Html::escape()` / integer/float casts before being concatenated. See the solution doc for the
  full mechanism.
- The embedded webform is rendered by **Webform's own** entity-reference formatter, so it keeps
  its own access checks, handlers, and confirmation flow — this module does not alter them.

## Install

```bash
composer require drupal/ebt_webform
drush en ebt_webform -y   # pulls in ebt_core, paragraphs, webform
```

Provides **no** config schema of its own (the `ebt_settings` schema lives in `ebt_core`), no
permissions, no plugin types.
