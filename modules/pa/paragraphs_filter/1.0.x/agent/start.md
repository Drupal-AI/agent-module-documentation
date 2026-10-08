<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Filter (paragraphs_filter) — agent index

**Associates paragraph types with content types and filters the paragraph-types list + node reference widgets accordingly.**

- **Version:** 1.0.x (1.0.4)
- **Core:** ^9 || ^10 || ^11 — depends on paragraphs.
- **Config:** `paragraphs_filter.settings` (keyed by paragraph type id => content type ids).
- **Hooks (`.module`):** alters `paragraphs_type_add_form`/`edit_form` (adds "Content types" checkboxes + submit), `field_config_edit_form` (filters target bundles for node fields), `entity_type_alter` (swaps list builder), `paragraphs_type_delete` (cleanup).
- **List builder/form:** `src/Controller/ParagraphsFilterListBuilder.php`, `src/Form/ParagraphsFilterForm.php` (exposed filter on `/admin/structure/paragraphs_type`).
- **Routes/permissions/services:** none of its own; relies on the structure/field admin pages' access.
- **Security:** config-only, operates inside permission-controlled admin forms; no custom routes, no untrusted input beyond a content-type machine name used in a redirect query. No security findings.