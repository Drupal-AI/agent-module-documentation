<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Publications (localgov_publications) — agent index

Turns long council documents into structured **HTML publications**: a hierarchy of
`localgov_publication_page` nodes (navigated with core-style **Book** outlines) plus an optional
`localgov_publication_cover_page` that links to one or more publications and can attach downloadable
documents. Provides publication navigation, in-page tables of contents, breadcrumbs and pathauto URLs.
Core `^10 || ^11`.

- **No settings form.** `configure` is null. The one admin route is `publication.admin_edit`
  (`/admin/structure/publications/{node}`), which reuses `\Drupal\book\Form\BookAdminEditForm` to
  re-order pages; it requires `administer book outlines` **and** `_entity_access: node.view`.
- Hard dependencies: `book:book` (Book left core after D10 — a D11 site must `composer require
  drupal/book`), `pathauto`, core `block`/`menu_ui`/`text`/`views`, `localgov_core:localgov_media`,
  `localgov_paragraphs:localgov_paragraphs` + `localgov_paragraphs:localgov_paragraphs_layout`.
- Defines **1 permission** (`access publication views`), **no drush**, **no plugin types** (it ships
  plugin *instances*: 3 blocks, a text-format filter, a preview_link autopopulate plugin), and a
  config-schema entry for the filter.

Solution docs:
- **Content types, fields, book/pathauto config, the re-order route** → [configure/publications.md](configure/publications.md)
- **Permission + the localgov_editor role defaults** → [permissions/permissions.md](permissions/permissions.md)
- **Navigation / page-header / table-of-contents blocks** → [blocks/blocks.md](blocks/blocks.md)
- **Services, the menu-tree alter hook, the filter & preview-link plugins, tokens** → [api/api.md](api/api.md)

Key facts (real machine names):
- Node types: `localgov_publication_page`, `localgov_publication_cover_page`.
- Blocks: `publication_navigation`, `localgov_publications_page_header_block`, `localgov_publications_toc_block`.
- Services: `localgov_publications.publication_manager`, `localgov_publications.heading_finder`,
  `localgov_publications.route_subscriber`, `localgov_publications.breadcrumb`.
- Filter plugin id: `localgov_publications_heading_ids` (auto-added to the `wysiwyg` text format on install).
- Tokens: `[node:localgov-publication-path]`, `[node:localgov-publication-cover-page-alias]`.
- Alter hook: `hook_localgov_publications_menu_tree_alter(&$tree)`.
- Permission: `access publication views` (governs the `publications` admin view only).
- Route: `publication.admin_edit`. Overridden route: `book.admin` (controller swap only).

> **Documented from source (1.1.5).** `drush en localgov_publications` on bare Drupal fails with an
> unmet config dependency on `filter.format.wysiwyg` — a text format supplied by the LocalGov Drupal
> distribution. Install the distribution/`localgov_base`, not bare core.
