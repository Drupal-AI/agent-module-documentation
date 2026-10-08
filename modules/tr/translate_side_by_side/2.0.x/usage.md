<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translate Side by Side is a single admin report that lists menus, nodes, blocks and taxonomy terms with each translatable field shown in a source language and target language column, giving translators a ready-made translation template/overview.

---

The module provides one form/report at `admin/reports/translate_side_by_side` (`configure` = route `translate_side_by_side.admin`, gated by `administer site configuration`). `SettingsForm::buildForm()` offers a source-language and target-language selector, a content-type filter, and two options — "Skip field if empty in source" and "Fill untranslated with source" — plus a **Load** button (no persistent save; it rebuilds the report on demand). After loading it walks each entity type whose module is enabled (`menu_link_content`, `node`, `block_content`, `taxonomy`) via the entity type/field managers and the menu link tree, and for every translatable string/text field — as well as image alt/title, file description, and link title, and fields inside **paragraphs** — renders a table with the field name, its source-language value, and its target-language value (falling back to source when configured). Fields are listed in form-display order. It is a read-only display/reporting aid for planning or reviewing translations for an external translation/review workflow; it does not itself write translations. Depends on core `content_translation` and `language`. No permissions, config schema, plugins, or Drush of its own.

---

- Get a side-by-side overview of source vs. target text for every node before translating.
- Produce a translation template/worklist for an external translator or agency.
- Review which node fields are still untranslated for a target language.
- Compare menu link titles across two languages in one place.
- Compare custom block content between source and target languages.
- Compare taxonomy term names/fields between two languages.
- Include fields nested inside paragraphs in the translation overview.
- See image alt and title text that needs translating.
- See file field descriptions that need translating.
- See link field titles that need translating.
- Filter the report to specific content types to focus a translation batch.
- Choose any two configurable languages as source and target.
- Skip fields that are empty in the source to reduce noise in the report.
- Fill untranslated target cells with the source value to highlight gaps.
- Audit translation completeness across menus, nodes, blocks and taxonomy at once.
- Hand a reviewer a single page showing original and translated content together.
- Plan translation effort by seeing field counts/lengths per entity.
- Verify a completed translation matches the source field-by-field.
- Use field-display order so the report mirrors the edit form layout.
- Provide a lightweight translation status view without a full TMS integration.
