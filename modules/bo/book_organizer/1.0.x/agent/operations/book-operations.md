<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Organizer — book-wide delete / publish / unpublish operations

The write side: run an operation across a whole book and all its pages, confirmed and batched.

## Routes (`book_organizer.routing.yml`)

All take `{node}` (upcast to `entity:node`, `node: \d+`), `_admin_route: TRUE`, and are gated by the
custom access check `_book_organizer_operation`, **not** a bare permission:

| Route | Path | Form | `_book_organizer_operation` |
|---|---|---|---|
| `book_organizer.book_delete` | `/admin/book-organizer/delete/{node}` | `BookDeleteForm` | `delete` |
| `book_organizer.book_unpublish` | `/admin/book-organizer/unpublish/{node}` | `BookUnpublishForm` | `update` |
| `book_organizer.book_publish` | `/admin/book-organizer/publish/{node}` | `BookPublishForm` | `update` |

## Access checker (`src/Access/BookOperationAccessCheck.php`)

Service `book_organizer.book_operation_access` (tagged `access_check`, `applies_to: _book_organizer_operation`).
`access()` reads the operation from the route requirement (default `update`) and returns
`AccessResult::allowedIf($hierarchyManager->isTopLevelBook($node)) ->andIf($node->access($operation, $account, TRUE))`,
with the node as a cache dependency and `cachePerPermissions()`. So a caller must (a) target the **top-level**
node of a book and (b) hold the relevant node operation on that node. Note there is no `administer book organizer`
permission requirement on these three routes — access is purely node-operation based (the links to them are only
surfaced on the perm-gated overview).

## Confirm forms (`src/Form/*`)

`BookOperationFormBase` extends `ConfirmFormBase` (so a valid **form/CSRF token** is required to submit) and
holds the shared flow; `BookDeleteForm` / `BookPublishForm` / `BookUnpublishForm` supply labels, the batch
callback name, the node ordering, and the log verb. `getCancelUrl()` / redirect → `view.book_organized.page_1`.
`submitForm()`:

1. Builds the node id list via the subclass's `orderedNodeIds($bid)` — delete uses
   `getBookPageIdsChildFirst()` (deepest pages first, so parents delete only after children); publish/unpublish
   use `getBookPageIds()` (order immaterial). A safety net appends `$bid` if missing.
2. Logs `Queued @verb of book %title (bid @bid): @count nodes.` to channel `book_organizer`.
3. `batch_set()` with `BookBatch::buildOperations()` (chunks of `BATCH_SIZE = 20`), a leading
   `BookBatch::rememberTitle` op, and the subclass's finished callback.

## Batch class (`src/BookBatch.php`)

Static callbacks (kept stateless because Batch API serializes the op list). **Each callback re-checks node
access per node** — this is the real authorization on the mutation, defence-in-depth over the route check:

- `deleteNodes()` — loads each chunk, deletes only nodes where `$node->access('delete')`, else increments
  `skipped`.
- `unpublishNodes()` — `$node->access('update')` required; unpublishes only currently-published nodes.
- `publishNodes()` — `$node->access('update')` required; publishes only currently-unpublished nodes.
- `*Finished()` — messenger status with the remembered `%title` and a warning counting nodes skipped for
  lack of permission.

So a user allowed to act on the top book but not on some children will have those children **skipped**, not
force-processed. Titles flow through translation/messenger, not raw markup.

## Hierarchy service (`src/Service/BookHierarchyManager.php`)

`book_organizer.hierarchy_manager` (args `@entity_type.manager`, `@database`). Read-only helpers over the core
`{book}` table, all using the query builder with int-cast ids (no string concatenation):
`getBookPageCount()`, `getBookPageCountsBatch()`, `getBookStatusCountsBatch()` (joins `node_field_data`),
`getBookPageIds()` / `getBookPagesPaginated()` (ordered by `weight` then materialized-path `p1..p9`, mirroring
core outline order), `getBookPageIdsChildFirst()` (order by `depth DESC`), `getBookPages()`, `loadMultiple()`,
`isInBookHierarchy()`, `getTopLevelId()`, `isTopLevelBook()` (node id === `book['bid']`).
