<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Organizer (book_organizer) — agent index

A **Views-powered hierarchical overview and bulk book-level operations UI** for Drupal core's **Book**
module. Adds an admin screen at **`/admin/content/book-organized`** that groups each top-level book with
its nested pages in one table, plus confirmed, batched **publish / unpublish / delete** of a whole book.
Package `Content`. Depends on core **`book`** and **`views`**. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.3. **Not** a drag-and-drop reorder tool — "Order pages" links out to core's `book.admin_edit`.

## What it actually provides

- **One permission** — `administer book organizer` (`book_organizer.permissions.yml`, `restrict access: true`):
  gates the overview view and the AJAX children route. Individual page ops and each batched node still
  check node access.
- **One Views style plugin** — `book_hierarchy_table` (`src/Plugin/views/style/BookHierarchyTable.php`),
  used by the shipped view **`views.view.book_organized`** (`config/install/`, page path
  `/admin/content/book-organized`, access = perm `administer book organizer`).
- **One service** — `book_organizer.hierarchy_manager`
  (`src/Service/BookHierarchyManager.php`): book-tree query helpers over the `{book}` table.
- **One access checker** — `book_organizer.book_operation_access` (`_book_organizer_operation` route
  requirement, `src/Access/BookOperationAccessCheck.php`).
- **One AJAX controller** — `BookPagesController::getPages` (JSON children of a large book).
- **Three confirm forms + a batch class** — delete / publish / unpublish a whole book
  (`src/Form/*`, `src/BookBatch.php`).
- **Routes** (`book_organizer.routing.yml`): `book_organizer.book_pages` (AJAX, `_permission`),
  `book_organizer.book_delete` / `book_organizer.book_unpublish` / `book_organizer.book_publish`
  (confirm forms, custom access check). All `_admin_route: TRUE`.
- **hook_theme** (`book_organizer_overview`, `book_organizer_book_section`) + two Twig templates;
  JS behaviors in `js/book-organizer.js` (collapse persistence, lazy load, in-book search, TOC).
- No config settings form (`configure` = null), no config schema of its own, no Drush.

## Solution docs

- **The overview: view, `book_hierarchy_table` style, AJAX children route/controller, JS, permission** →
  [views/overview.md](views/overview.md)
- **Book-wide operations: delete/publish/unpublish confirm forms, the access checker, the Batch class,
  and the hierarchy service** → [operations/book-operations.md](operations/book-operations.md)
