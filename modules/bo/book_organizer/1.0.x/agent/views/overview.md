<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Organizer — the overview screen (view, style plugin, AJAX children)

The visible feature: a hierarchy-aware table of books at **`/admin/content/book-organized`**.

## Install / enable

`drush en book_organizer` (core `book` + `views` are dependencies). Enabling imports
`config/install/views.view.book_organized.yml`. Grant the **`administer book organizer`** permission to
the roles that should reach the screen. Menu link `book_organizer.admin_books`
(`links.menu.yml`) puts it under Content; a local task tab (`links.task.yml`) sits beside Content.

## The view (`views.view.book_organized`)

- `base_table: node_field_data`; page display **`page_1`** at path `admin/content/book-organized`
  (route `view.book_organized.page_1`, used as the cancel/redirect target by the operation forms).
- **Access**: `type: perm`, `perm: administer book organizer`. Row plugin `entity:node`,
  full pager 50/page, exposed basic form. `book_organizer_update_10001()` migrated older installs from
  `access content overview` to this permission; `_10002()` set the page title. Customized view access is
  left untouched but logged as a warning (see `book_organizer.install`).
- **Style**: `type: book_hierarchy_table` — the plugin below owns all rendering (`usesRowPlugin = FALSE`).

## Style plugin `BookHierarchyTable` (`src/Plugin/views/style/BookHierarchyTable.php`)

`@ViewsStyle(id = "book_hierarchy_table")`, extends `StylePluginBase`. `render()`:

- `collectBooks()` walks `$this->view->result`, **skips any node failing `$node->access('view')`**, groups
  rows by top-level book id (`BookHierarchyManager::getTopLevelId()`), loads any missing top nodes, drops
  books whose top node is not view-accessible, and orders books by first appearance in the result.
- For each book it fetches batched page counts / published-unpublished tallies
  (`getBookPageCountsBatch`, `getBookStatusCountsBatch`) and builds a `book_organizer_book_section` element.
- **Inline vs. lazy**: books with `1..INLINE_THRESHOLD (20)` pages render children server-side (each child
  again gated by `access('view')`); books over 20 pages get a `#children_url` to the AJAX route and load on
  expand.
- **Per-row operations** (`buildOperationsRenderArray()`): an `#type => 'operations'` dropbutton whose links
  are added **only when the matching node access passes** — `edit` (update), `view` (view),
  `order` → core `book.admin_edit` (update, book >1 page). Book-level links appear only on the top node:
  `add_child` (via `buildAddChildLink()`), `unpublish_book`/`publish_book` (state-aware, needs `update`),
  `delete_book` (needs `delete`).
- `buildAddChildLink()` mirrors core Book: requires `add content to books` **or** `administer book outlines`,
  a configured `book.settings:child_type`, `createAccess()` on that type, and depth `< BookManager::BOOK_MAX_DEPTH`.

## AJAX children route + controller

- Route **`book_organizer.book_pages`** — `/admin/book-organizer/pages/{node}`, `_permission: 'administer book organizer'`,
  `node: \d+`, entity-upcast, `_admin_route: TRUE`.
- `BookPagesController::getPages()` (`src/Controller/BookPagesController.php`) returns a
  `CacheableJsonResponse`: throws `BadRequestHttpException` if the node is not a top-level book
  (`hierarchyManager->isTopLevelBook`), clamps `offset >= 0` and `limit` to `1..100`, pages via
  `getBookPagesPaginated()`, and **emits only children passing `$page->access('view')`**. Each row's
  operations column is rendered server-side with `renderer->renderInIsolation()` of an `#type => 'operations'`
  dropbutton (`buildChildRow()`), so the JSON already carries safe markup. Cache: tag `node_list`, context
  `user.permissions`.

## Front-end (`js/book-organizer.js`, library `book_organizer/book-organizer`)

Vanilla JS behaviors (deps `core/drupal`, `core/once`, `core/drupalSettings`, `core/drupal.dropbutton`):
- `bookOrganizerCollapse` — `<details>` open/close persisted per bid in `localStorage`; expanding triggers
  `fetchChildren()`; an "Expand/Collapse all" button toggles every section.
- `fetchChildren()` — `fetch(url?offset=&limit=50)`, appends rows, adds a "Show more" button while
  `has_more`, then `Drupal.attachBehaviors()`. Row cells set title/author/updated via **`textContent`**
  (no HTML injection of node titles); only the pre-rendered server `operations_html` is assigned to
  `innerHTML`.
- `bookOrganizerSearch` — debounced client-side title filter within a loaded book.
- `bookOrganizerToc` — smooth-scroll TOC pills + IntersectionObserver active-state tracking.

Templates: `templates/book-organizer-overview.html.twig`, `templates/book-organizer-book-section.html.twig`
(auto-escaped Twig), registered by `book_organizer_theme()` in `book_organizer.module`.
