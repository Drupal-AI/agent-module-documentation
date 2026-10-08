<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Book Link Weight (book_link_weight) — agent index

Replaces the core Book outline **numeric "weight" select** with a **drag-and-drop (tabledrag) table** on node add/edit forms, so editors order a page among its siblings by dragging.

- **Version:** 1.3.x · **Core:** `^8 || ^9 || ^10 || ^11` · **License:** GPL-2.0-or-later · **Package:** Book
- **Dependencies:** `book` (core/contrib Book module) — no composer requirements.
- **Provides:** no routes, no permissions, no config, no config schema, no plugin types, no Drush, no `.install`. One service, two form-alter hooks, one JS behavior.

## What it actually is

- **Hooks** (`book_link_weight.module`): `hook_form_node_form_alter()` fires on every node form; a second `hook_form_alter()` catches the standalone form whose id starts `node` and ends `book_outline_form`. Both, when `$form['book']` is set, call `\Drupal::service('book_link_weight.form')->alterBookOutlineForm($form, $form_state)`.
- **Service** `book_link_weight.form` → `Drupal\book_link_weight\Form\BookLinkWeightForm` (`book_link_weight.services.yml`), constructed with `@book.manager` (core `BookManagerInterface`). Note: not a real `FormBase`; a plain alter/handler class with static submit + AJAX callbacks.
- **Library** `book_link_weight/book_link_weight` (`js/book_link_weight.js`, deps `core/jquery`, `core/drupal`): keeps the current row label in sync with the title field, and re-triggers the parent select after the book (`bid`) AJAX so siblings load.

## Mechanism / operation

- **Everything it does, per method** (rebuilding the outline into a tabledrag table, the AJAX parent select, the submit handler that saves sibling weights, delta/title logic) → [forms/book-outline.md](forms/book-outline.md)

No endpoints, no external calls, no DB schema of its own. Access is governed by core node + Book form/permission handling on the surrounding node form.
