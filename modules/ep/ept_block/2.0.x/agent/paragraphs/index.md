<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Block — the `ept_block` paragraph type

## Config shipped (config/install)
- `paragraphs.paragraphs_type.ept_block` — the bundle (`id: ept_block`, label `EPT Block`, no
  behavior plugins).
- `field.storage.paragraph.field_ept_block_block` — storage, type `block_field`, cardinality 1,
  translatable. (Storages for `field_ept_settings`, `field_ept_text`, `field_ept_title` come from
  `ept_core`.)
- `field.field.paragraph.ept_block.field_ept_block_block` — the block reference field instance:
  - `label: Block`, `description: 'Add existing Drupal Block'`, **`required: true`**.
  - `settings.selection: categories` with `selection_settings.categories` = an allowlist that
    enumerates essentially every block category on the site (Block, Content block, Forms, Help,
    Lists (Views), Menus, System, User, Webform, all the field categories, …).
- `field.field.paragraph.ept_block.field_ept_settings` — `ept_settings` (shared design tab).
- `field.field.paragraph.ept_block.field_ept_text` / `field_ept_title` — `text_long`, optional.
- `core.entity_form_display.paragraph.ept_block.default` — a `field_group` **Tabs**: a **Content**
  tab (title, text, block) and a **Settings** tab (the EPT design settings). Block widget is
  `block_field_default` with `configuration_form: full`.
- `core.entity_view_display.paragraph.ept_block.default` — block rendered with the `block_field`
  formatter, label hidden; text/title with `text_default`; settings with `ept_settings_default`.

## Selecting the block (widget)
`block_field`'s `block_field_default` widget lists block plugins allowed by the field's `categories`
selection. `configuration_form: full` means the editor also sees the selected block's own
configuration form and can set its instance configuration; this is stored alongside the `plugin_id`
in the field item.

## Rendering the block (formatter) — access is checked
`Drupal\block_field\Plugin\Field\FieldFormatter\BlockFieldFormatter::viewElements()`:
1. `$block_instance = $item->getBlock();`
2. If context-aware, apply runtime contexts (skips the item on `ContextException`).
3. **`$access = $block_instance->access($currentUser, TRUE);`** — the access result's cacheability
   is merged into `$elements`, and if `!$access->isAllowed()` the item is **skipped** (not rendered).
4. Builds a `#theme => 'block'` render array with a `#pre_render` that calls `$block->build()`,
   and merges the block's cacheability.

Net effect: an editor picking a restricted/admin/system block does **not** leak it to viewers who
lack access — the formatter honours the block plugin's own `access()` and cacheability. (This is
`block_field` behaviour; `ept_block` only wires the field in.)

## Rendering flow (template)
`templates/paragraph--ept-block--default.html.twig` prints an optional `<h2>` from
`field_ept_title`, then `content` without the settings/title fields (so the block + text), inside
`.ept-container`, and finally `{{ styles|raw }}` — the scoped inline `<style>` produced by
`ept_core`'s `GenerateCSS` from `field_ept_settings`.

## Notes for agents
- To add the paragraph type to a content type: add/enable a Paragraphs (entity reference revisions)
  field on the node and allow the `ept_block` bundle; there is no separate UI in this module.
- The block is resolved and rendered live at display time — updating the source block updates every
  referencing paragraph.
- Cache: because embedded Views/menu/context-aware blocks vary per viewer, the rendered page's cache
  metadata reflects the block's contexts/tags (merged by the formatter).
