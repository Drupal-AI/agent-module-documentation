<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translate Side by Side — agent index

A single read-only report at `admin/reports/translate_side_by_side` (`configure` = route
`translate_side_by_side.admin`, access `administer site configuration`) that lists menus, nodes,
blocks and taxonomy with each translatable field's **source** and **target** language value side by
side. Depends on `content_translation` + `language`. No permissions/schema/plugins/Drush of its own.

- **The report form: options, which entities/fields it covers, and how to read it** →
  [configure/overview.md](configure/overview.md)

Key facts:
- One route/form: `translate_side_by_side.admin` → `Form\SettingsForm` (service
  `translate_side_by_side.settingsservice`).
- Options: source language, target language, content-type filter, "Skip field if empty in source",
  "Fill untranslated with source"; a **Load** button rebuilds the report (nothing is persisted).
- Covers `menu_link_content`, `node`, `block_content`, `taxonomy` (module-gated), including string/text
  fields, image alt/title, file description, link title, and fields inside **paragraphs**.
- Read-only: it displays source vs. target values; it does not write translations.
