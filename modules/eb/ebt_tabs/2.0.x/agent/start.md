<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EBT Tabs — agent index

Installs an "EBT Tabs" block content type + `ebt_tab` paragraph type; each tab holds text, a page, a
block, or a View, rendered with jQuery UI Tabs. Built on `ebt_core`; also needs `paragraphs`,
`block_field`, `viewsreference`, `jquery_ui_tabs`, `views`. No config page, no permissions,
no config schema of its own (block/paragraph content stays behind core content permissions).

- **The installed bundles/fields, the content-type selector, the settings widget & style presets,
  the form-alter/validation hooks** → [configure/tabs.md](configure/tabs.md)

Key facts:
- Config install (`config/install/`): `block_content.type.ebt_tabs`, paragraph type `ebt_tab`, fields
  `field_ebt_tabs` (paragraph ref on the block), `field_ebt_settings`, and per-tab fields
  `field_ebt_tab_title|content|text|page|block|views`, plus default form/view displays.
- Widget `ebt_settings_tabs` (`src/Plugin/Field/FieldWidget/EbtSettingsTabsWidget.php`) for field type
  `ebt_settings` (from `ebt_core`); adds `styles` presets and `pass_options_to_javascript`.
- Hooks in `src/Hook/EbtTabsHooks.php` (`#[Hook]` attribute) with legacy `.module` shims:
  `field_widget_single_element_(entity_reference_)paragraphs_form_alter` toggle field visibility by the
  `field_ebt_tab_content` value; `form_alter` adds `_ebt_tabs_form_validation` to
  `block_content_ebt_tabs_form`.
- Content-type options → value field: `text`→`field_ebt_tab_text`, `page`→`field_ebt_tab_page`,
  `block`→`field_ebt_tab_block`, `views`→`field_ebt_tab_views`.
- Requires the `page` content type and Media Image type at install (per README).
