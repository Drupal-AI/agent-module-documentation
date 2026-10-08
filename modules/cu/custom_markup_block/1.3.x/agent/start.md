<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Markup Block (custom_markup_block) — agent index

Provides one block plugin, **Custom Markup** (`id: custom_markup`), whose body markup is
stored in the block instance's *configuration* (not a content entity). You place the block,
type markup into a filtered text area, and it renders through the chosen text format. Because
the content lives in config, it exports/imports with `drush cim`/`cex` and is version-controlled.

- Dependencies: core `filter` (declared `drupal:filter`).
- Core: `^8 || ^9 || ^10 || ^11`.
- `configure` route: none (no settings page — all config is per-block-instance).
- Permissions: defines none of its own. Placing/editing the block uses core `administer blocks`.
- Plugins: defines no plugin *types*; it *implements* one core Block plugin.
- Drush: none.

Solution docs:
- **Place the block / set its markup, config schema, render pipeline** → [blocks/custom-markup.md](blocks/custom-markup.md)

Key facts:
- Block plugin class: `Drupal\custom_markup_block\Plugin\Block\CustomMarkup` (extends `BlockBase`).
- Plugin id `custom_markup`; admin_label "Custom Markup"; plugin category "Custom Blocks".
- Config schema key: `block.settings.custom_markup`, mapping `markup` of type `text_format`
  (`markup.value` + `markup.format`).
- Default format: `full_html` (see `defaultConfiguration()`).
- Form element `#type: text_format`; output element `#type: processed_text`.
- Optional: `drupal/token_filter` (composer `suggest`) adds tokens as an input filter.
