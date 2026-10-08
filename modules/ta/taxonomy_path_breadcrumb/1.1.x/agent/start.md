<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Path Breadcrumb — agent index

Per-vocabulary switch between the default taxonomy-hierarchy breadcrumb and the core
path/alias-based breadcrumb on taxonomy **term** pages. One breadcrumb builder that delegates
to a core service named by a vocabulary third-party setting. No config page (`configure`
null), no permissions, no Drush. Depends on core `taxonomy`.

- **The vocabulary setting, the two service options, how delegation works, setting it via
  Drush/config** → [configure/vocabulary.md](configure/vocabulary.md)

Key facts:
- Service `taxonomy_path_breadcrumb.breadcrumb` (class `TermBreadcrumbBuilder`), tag
  `breadcrumb_builder` priority **1003**; `applies()` only to `entity.taxonomy_term.canonical`.
- Reads vocabulary third-party setting `taxonomy_path_breadcrumb :
  taxonomy_path_breadcrumbs_builder`; delegates `build()` to that service.
- Options: `taxonomy_term.breadcrumb` (default, term hierarchy) or `system.breadcrumb.default`
  (path/alias based). Unset → falls back to `taxonomy_term.breadcrumb`.
- Setting added to the vocabulary edit form (`hook_form_taxonomy_vocabulary_form_alter`),
  schema `taxonomy.vocabulary.*.third_party.taxonomy_path_breadcrumbs`.
