<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — `layout_builder_reusable_blocks.settings`

Install/enable: `drush en layout_builder_reusable_blocks` (pulls core `layout_builder` +
`block_content`). Configure at **`/admin/config/user-interface/layout-builder-reusable-blocks`**
(menu link `layout_builder_reusable_blocks.settings` under *Configuration → User interface*,
`links.menu.yml`).

## Form

`src/Form/LayoutBuilderReusableBlocksConfigForm.php` — a plain `ConfigFormBase`.
`getFormId()` = `layout_builder_reusable_blocks_config_form`;
`getEditableConfigNames()` = `['layout_builder_reusable_blocks.settings']`. Two `details` groups:

- **Warning Message Settings**
  - `show_warning` (checkbox) — show the warning when editing a reusable block. Default `TRUE`.
  - `warning_text` (textarea) — the warning body; `#states`-hidden unless `show_warning` is checked.
    Default `"This is a reusable block. Changes made here will affect all instances of this block."`
- **Block Behavior Settings**
  - `allow_editing_reusable_blocks` (checkbox) — allow editing a reusable block *in place* inside
    Layout Builder. Default **`FALSE`**. When off, the plugin does not embed the edit form at all.
  - `make_all_blocks_reusable` (checkbox) — skip the inline/reusable choice and create **every**
    added block as reusable. Default `FALSE`.

`submitForm()` writes all four keys back to `layout_builder_reusable_blocks.settings->save()`.

## Config object

Single object `layout_builder_reusable_blocks.settings`, four keys as above. There is **no
`config/install` default file and no `config/schema`** in this module — the object does not exist
until the form is first saved, and every reader supplies a `?? <default>` fallback
(`$config->get('make_all_blocks_reusable') ?? FALSE`, etc.). Consequence: exporting config before
the form is saved yields nothing to export, and the effective defaults are the code fallbacks, not
a shipped YAML file.

## Who reads each key

- `make_all_blocks_reusable` → `.module` `hook_form_..._add_block_alter` (auto-reusable path).
- `allow_editing_reusable_blocks`, `show_warning`, `warning_text` →
  `LayoutBuilderReusableContentBlock::buildConfigurationForm()` (in-place edit + warning).
