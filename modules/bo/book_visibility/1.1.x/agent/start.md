<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Visibility (book_visibility) — agent index

Enhances core **Book** with one **block-visibility Condition plugin** (id `book`) that shows/hides a
block depending on which book the current node belongs to. Package `Book`. Version 1.1.1. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. No composer/module deps declared in
`.info.yml` (relies on core `book` + `block` at runtime).

This is **block visibility (presentation) only** — it decides whether a *block* renders, NOT who may
read book content. Book-page access stays with core node access. No routes, no permissions, no
services, no config schema, no Drush.

- **The condition plugin — every method, config shape, form, JS summary, and how to operate it** →
  [plugins/book-condition.md](plugins/book-condition.md)

## What it actually is (from source)

- One plugin: `BookVisibility` (id **`book`**, label *"Book"*) in
  `src/Plugin/Condition/BookVisibility.php`, extending core `ConditionPluginBase` and implementing
  `ContainerFactoryPluginInterface`. Injects `book.manager`, `current_route_match`,
  `entity_type.manager`.
- `book_visibility.module`:
  - `hook_help()` for `help.page.book_visibility`.
  - `hook_form_block_form_alter()` — attaches library `book_visibility/block` to the block form's
    visibility vertical tabs when the `book` condition is present.
- `book_visibility.libraries.yml` — library `block` = `assets/js/booklet_condition.js` (depends on
  `block/drupal.block`); JS sets the vertical-tab summary text ("The block is restricted to specific
  books." / "Not restricted").
- No `.routing.yml`, `.permissions.yml`, `.services.yml`, `.install`, or `config/` — nothing beyond
  the plugin, the two hooks, and one JS file.
