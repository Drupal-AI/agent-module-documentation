<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ebt_block — the EBT Block content type (config reference)

`ebt_block` is **config-only**. Everything it does is defined by the YAML under `config/install/`
plus two Twig templates. There is no `.module`, `.install`, `.routing.yml`, `.permissions.yml`,
`.services.yml`, `.libraries.yml`, or `src/` in this project. The runtime behaviour of the settings
field and the styling comes from **`ebt_core`** (see
[../../../../ebt_core/2.0.x/agent/start.md](../../../../ebt_core/2.0.x/agent/start.md)).

## Install / enable

- `composer require drupal/ebt_block` then `drush en ebt_block -y`.
- Requires `drupal/ebt_core:^2.0` and `drupal/block_field:^1.0` (declared in both `composer.json`
  and `ebt_block.info.yml`). `ebt_core` in turn expects Media (Image type) for background images.
- On install, Drupal imports the `config/install/*` objects listed below.

## Config objects installed

- **`block_content.type.ebt_block`** — the bundle. `id: ebt_block`, `label: 'EBT Block'`,
  `revision: 0`.
- **`field.storage.block_content.field_ebt_block_block`** — `type: block_field`, cardinality 1,
  module `block_field`. (The `body` and `field_ebt_settings` storages are provided by core and by
  `ebt_core` respectively, not by this module.)
- **`field.field.block_content.ebt_block.body`** — core `text_with_summary`, `display_summary: false`.
- **`field.field.block_content.ebt_block.field_ebt_block_block`** — `block_field`, label "Block".
  `settings.selection: categories` with an explicit allow-list of block **categories** an editor may
  pick from (Block, Content block, Content fields, Forms, Help, Inline blocks, Lists (Views), Menus,
  System, User, Webform, and more). This constrains which block *plugins* appear in the widget; the
  chosen plugin's own configuration form is then shown (`configuration_form: full`).
- **`field.field.block_content.ebt_block.field_ebt_settings`** — field type **`ebt_settings`**
  (from `ebt_core`), label "Block settings". This is the EBT design-options field.
- **`core.entity_form_display.block_content.ebt_block.default`** — `field_group` (module dependency
  `field_group`) Tabs layout:
  - **Content** tab (`group_content`): `info`, `body` (`text_textarea_with_summary`, 9 rows),
    `field_ebt_block_block` (`block_field_default`, `configuration_form: full`).
  - **Settings** tab (`group_settings`, closed by default): `field_ebt_settings`
    (`ebt_settings_default` widget).
- **`core.entity_view_display.block_content.ebt_block.default`** — `body` (`text_default`),
  `field_ebt_block_block` (`block_field`), `field_ebt_settings` (`ebt_settings_default`,
  label hidden).

## Templates

Both templates live in `templates/` and are mapped onto this bundle by `ebt_core`'s
`hook_theme_registry_alter` (`block__block_content__ebt_block` and `block__inline_block__ebt_block`):

- `block--block-content--ebt-block.html.twig` — standalone content-block placement.
- `block--inline-block--ebt-block.html.twig` — Layout Builder inline-block placement.

Each wraps the block in `<div class="block ebt-block …"><div class="bg-inner"></div>
<div class="ebt-container">…{{ content|without('field_ebt_settings') }}…</div></div>` and appends
`{{ styles }}`. The `styles` variable (an inline `<style>` string built from the block's
`field_ebt_settings` design options) and the classes/JS are set by `ebt_core`'s
`hook_preprocess_block` / `GenerateCSS` / `GenerateJS` services — this module only renders them.
`field_ebt_settings` is intentionally excluded from the visible content with `|without`.

## Operating notes

- Create blocks at **Structure » Block layout » Add content block » EBT Block**; a **Settings** tab
  exposes EBT design options (margin, border, padding, border colour/style/radius, background
  colour/image/video, edge-to-edge, container max width). Place the resulting block with Layout
  Builder.
- Site-wide EBT defaults (primary/secondary colours, mobile/tablet/desktop breakpoints, container
  widths) are set by **ebt_core** at `/admin/config/content/ebt-core`, not here.
- No permission is added by this module. Creating/editing these blocks uses core block-content
  permissions (e.g. *Administer block content* / *Create and edit custom blocks*). The **embedded**
  block selected in `field_ebt_block_block` renders through Block Field and keeps its own plugin
  access checks.
- **Field Layout note (README):** if the Field Layout module is on, it may auto-enable Layout
  Builder for new EBT block types; disable it at
  `/admin/structure/block/block-content/manage/ebt_block/display/default` so the block-type fields
  display normally.
- Each EBT block type is standalone — you can install only the EBT block types you need.
