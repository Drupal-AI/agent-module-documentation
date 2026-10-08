<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Counter block type, paragraph & fields

All entities/fields are shipped as `config/install/*` and created on module enable. No settings form; each counter is configured on the block instance.

## Install / enable

```bash
composer require drupal/ebt_counter   # pulls ebt_core, paragraphs, levmyshkin/count-up.js
drush en ebt_counter -y
```

`ebt_counter_requirements($phase == 'install')` (in `ebt_counter.install`): only if the `media` module is enabled, it requires an `image` Media type to exist, otherwise install fails with `RequirementSeverity::Error`. If Media is not enabled the check is skipped.

## Block content type

- `block_content.type.ebt_counter` — label "EBT Counter". Placeable via Layout Builder or Block layout as an inline/reusable custom block.

Block fields (`field.field.block_content.ebt_counter.*`):

| Field | Type | Notes |
|---|---|---|
| `field_ebt_counter_items` | entity_reference_revisions → paragraph | cardinality -1; target bundle `ebt_counter_item` |
| `field_ebt_counter_number` | integer | label "Number" (block-level number) |
| `field_ebt_counter_icon` | (storage in config/install) | icon field |
| `field_ebt_settings` | `ebt_settings` (ebt_core) | design + CountUp.js options; widget `ebt_settings_counter` |
| `body` | text_with_summary | optional WYSIWYG intro |

## Paragraph type (counter item)

- `paragraphs.paragraphs_type.ebt_counter_item` — label "EBT Counter Item".

Paragraph fields (`field.field.paragraph.ebt_counter_item.*`):

- `field_ebt_counter_title` — required (set required by `ebt_counter_update_9101`).
- `field_ebt_counter_description`.
- `field_ebt_counter_number` — the number that animates.
- `field_ebt_counter_icon`.

The block references many `ebt_counter_item` paragraphs; each renders one animated number with title/description/icon.

## Templates & theming (`templates/`)

- `block--block-content--ebt-counter.html.twig` and `block--inline-block--ebt-counter.html.twig` — wrap the block in `.ebt-block-counter` plus a `ebt-counter-{styles}` class read from `content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings.styles`; `attach_library('ebt_counter/countup')`; end with `{{ styles|raw }}` (the `styles` variable is the inline CSS generated and pre-escaped by `ebt_core`, not by this module).
- `paragraph--ebt-counter-item--default.html.twig` — wraps item content in `.ebt-counter-content`.
- `field--paragraph--ebt-counter--field-ebt-counter-number.html.twig` — renders each number item into `<div class="ebt-counter-number" id="ebt-counter-number-{id}">{{ item.content }}</div>`; the element id is the JS animation target.

## Hooks (`src/Hook/EbtCounterHooks.php`, `ebt_counter.module`)

- `hook_help` — help text on `help.page.ebt_counter`.
- `hook_theme` — registers `field__paragraph__ebt_counter__field_ebt_counter_number` (base hook `field`).
- `hook_theme_suggestions_field_alter` — adds that suggestion for the `field_ebt_counter_number` field.

## Troubleshooting

- If Field Layout is installed it may force Layout Builder onto the block type; disable it at `/admin/structure/block/block-content/manage/ebt_counter/display/default` so fields render normally (see README).
