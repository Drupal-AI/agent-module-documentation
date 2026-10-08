<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Counter (ebt_counter) — agent index

Provides an `ebt_counter` custom block content type that renders animated number counters (CountUp.js) built from repeatable `ebt_counter_item` paragraphs, plus an optional WYSIWYG body.

- **Version:** 2.0.x · **Core:** `^10.1 || ^11 || ^12` · **License:** GPL-2.0-or-later
- **Depends on:** `ebt_core`, `paragraphs` (config also uses `entity_reference_revisions`, and `media` is checked at install if enabled).
- **Composer:** `drupal/ebt_core:^2.0`, `drupal/paragraphs:^1.0`, `levmyshkin/count-up.js:^2.8` (CountUp.js placed under `/libraries/count-up.js`).
- **Configure route:** none. All configuration is per-block-instance on the block form.

## What it installs (config/install)

- **Block type:** `block_content.type.ebt_counter`.
- **Paragraph type:** `paragraphs.paragraphs_type.ebt_counter_item`.
- **Block fields:** `field_ebt_counter_number` (integer), `field_ebt_counter_icon`, `field_ebt_counter_items` (entity_reference_revisions → paragraph `ebt_counter_item`, cardinality -1), `field_ebt_settings` (`ebt_settings`, from ebt_core), `body`.
- **Paragraph fields:** `field_ebt_counter_title` (required), `field_ebt_counter_description`, `field_ebt_counter_number`, `field_ebt_counter_icon`.
- Default form/view displays for both the block type and the paragraph type.

## Code surface

- **Hook class:** `src/Hook/EbtCounterHooks.php` (autowired service, `ebt_counter.services.yml`) — `hook_help` and `hook_theme` (registers `field__paragraph__ebt_counter__field_ebt_counter_number`). `ebt_counter.module` adds `hook_theme_suggestions_field_alter` for `field_ebt_counter_number`.
- **Field widget plugin:** `EbtSettingsCounterWidget` (`ebt_settings_counter`, for `ebt_settings` field type) — extends `ebt_core`'s `EbtSettingsDefaultWidget`; adds 2/3/4-column `styles` plus all CountUp.js options.
- **Library:** `ebt_counter/countup` — CountUp.js UMD + `js/countup.js` + `css/countup.css`; deps `core/drupal`, `core/once`, `core/drupalSettings`.
- **Templates:** two block templates (block_content + inline_block), the paragraph item template, and the counter-number field template.
- **Install:** `ebt_counter_requirements` (needs an `image` Media type when Media is enabled); update hooks `9101`–`9103`.
- **Routes / permissions / services / drush:** none beyond the hook service.

## Solution docs

- [Block type, paragraph & fields](blocks/counter.md) — entities, fields, config, templates, theming.
- [Counter settings widget & CountUp.js](fields/settings-widget.md) — `ebt_settings_counter` options and the JS pipeline.
