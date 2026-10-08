<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The book-outline tabledrag alter (`BookLinkWeightForm`)

All logic lives in `src/Form/BookLinkWeightForm.php` (service `book_link_weight.form`, arg `@book.manager`). There is no config, no route, no permission — install `book_link_weight`, and every book-enabled node form is altered automatically.

## Entry points

`book_link_weight.module`:
- `hook_form_node_form_alter()` → calls `alterBookOutlineForm()` whenever `$form['book']` exists.
- `hook_form_alter()` → same call for the standalone outline form (id starts `node`, ends `book_outline_form`), which exposes no base form id so a plain node-form alter would miss it.

## `alterBookOutlineForm(&$form, $form_state)`

Runs only when both `$form['book']['bid']['#default_value']` and `['pid']['#default_value']` are set (a book + parent are chosen); otherwise it emits an empty, `visually-hidden` placeholder table (id `book-order`, `#empty` "No sibling elements") that AJAX later fills.

When a parent is set:
1. Loads the parent link via `bookManager->loadBookLink(pid)`, then `bookManager->bookSubtreeData($link)` and `reset()` to get the parent's `below` children.
2. Computes a weight `#delta` (range of the `weight` selects): `DEFAULT_DELTA = 20`; if the parent has >= 30 children it grows to `intval($count / 1.5) + 1` for breathing room.
3. Adds an `#ajax` callback to `book[pid]` → `bookWeightTableUpdate` (wrapper `edit-book-weight-wrapper`, fade) and class `js-book-parent-select`.
4. Builds `$form['book']['table']` as `#type => table`, id `book-order`, columns **Name / Weight**, with `#tabledrag` (`action: order`, `relationship: sibling`, `group: book-item-weight`), wrapped in `<div id="edit-book-weight-wrapper">`.
5. One row per existing sibling keyed by **nid**: `name` is `#markup => $item['link']['title']` (the book link title); `weight` is a `#type => weight` element (class `book-item-weight`, `#delta` = `max($delta, abs($weight))`, default = the link's current weight).
6. Appends a row for the page being edited (key = node id, or `0` for a new node), label wrapped in `<span class='book-item-weight-current-item'>…</span>` from `getCurrentTitle()`; its default weight is `lastSiblingWeight + 1`, or the node's existing row weight if already in the tree.
7. Hides the core control: `$form['book']['weight']['#type'] = 'hidden'`.
8. Attaches library `book_link_weight/book_link_weight`.
9. Prepends the static submit handler `bookOutlineSubmit` to every non-`preview` submit action (`array_unshift(...['#submit'])`).

`getCurrentTitle()` resolves the row label from the submitted `title` value, else the title widget `#default_value`, else `$form['#title']` on the standalone outline form, else `t("Current page")`.

## AJAX & JS

- `bookWeightTableUpdate($form, $form_state)` (static) simply returns `$form['book']['table']` to re-render the wrapper when the parent select changes.
- `js/book_link_weight.js` (`Drupal.behaviors.bookLinkWeightAutomaticTitle`): mirrors the node title input into `.book-item-weight-current-item` on keyup, and on `ajaxComplete` for the `book[bid]` trigger fires `change` on `.js-book-parent-select` so siblings load after the book is picked (book core populates `pid` via its own AJAX first).

## Submit — `bookOutlineSubmit($form, $form_state)` (static)

Reads `$values['book']['table']` and, per row:
- If the key is `0` (new node) or equals `$values['book']['nid']` (the edited node), it copies that row's weight into `$values['book']['weight']` and writes it back with `$form_state->setValue('book', …)` — i.e. the current page's placement flows through core's normal book save.
- Otherwise it treats the row as a sibling: `$link = bookManager->loadBookLink(key); $link['weight'] = $item['weight']; bookManager->saveBookLink($link, FALSE)` — persisting the dragged order of the other links immediately.

Only the `weight` field of each link is changed; parents, titles, and nids are untouched. Rows processed are exactly those rendered for the selected parent (Form API maps input only to defined `weight` elements, so unrendered nids cannot be smuggled in). The label markup uses `#markup` (admin-XSS filtered) and reflects the editor's own title/plain book-link titles.

## Notes for operators

- No settings page; behavior is global once enabled. To limit it, limit who can reach book-enabled node forms via core node/Book permissions.
- Works on both the inline node form book widget and the dedicated `node/{node}/outline` form.
- Uninstalling restores core's plain weight select; stored book weights are unaffected.
