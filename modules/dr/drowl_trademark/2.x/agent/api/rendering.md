<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the ® is appended (attach → drupalSettings → JS)

Two moving parts: a PHP page-attachments hook that decides *when* to run and passes config to the
browser, and a JS behavior that does the DOM work.

## 1. `drowl_trademark_page_attachments(&$page)` (`drowl_trademark.module`)

Runs on every page build and **bails out** unless the page is eligible:

- Skips **admin routes** (`router.admin_context->isAdminRoute()`) — the comment notes it would
  otherwise break the WYSIWYG.
- Skips paths matching **`*/js`** (`path.matcher->matchPath()`).
- Reads `drowl_trademark.settings:drowl_trademark_replacements`; if empty, does nothing.
- Parses the word list with `Tags::explode($replacements)` and joins it with `|` into
  `$replacepattern`. Only if non-empty does it:
  - attach library `drowl_trademark/drowl_trademark`;
  - set `drupalSettings.drowl_trademark.replacepattern` = the pipe-joined words;
  - set `drupalSettings.drowl_trademark.filter` = `drowl_trademark_filter`.

So the library and settings load **only** on eligible pages that actually have words configured.
`drupalSettings` values are emitted by core as HTML-safe JSON.

## 2. `Drupal.behaviors.drowl_trademark` (`js/drowl_trademark.js`)

Library deps: `core/jquery`, `core/drupal`, `core/once`, `core/drupalSettings`.

- Reads `settings.drowl_trademark.replacepattern` and `.filter`.
- Builds a **case-insensitive, word-boundary** regex:
  `new RegExp("\\b(" + replacepattern + ")(?!\\<sup)\\b", "gi")`. The `(?!<sup)` negative-lookahead
  is a light guard against re-marking (note: per the source comment it does not detect a following
  HTML element, only literal text).
- Selects elements once via `core/once` — `"*"` within an AJAX `context`, else `"body *"` on the
  initial load — then drops those matching the `filter` selector with jQuery `.not(filter)`.
- Calls the **bundled** jQuery `replaceText` plugin (v1.1, "Cowboy" Ben Alman, MIT/GPL, defined at
  the bottom of the same file) with replacement string `"$1<sup>®</sup>"` and `c = false`.

### What `replaceText` actually injects

`replaceText` walks each element's **direct child text nodes** (`nodeType === 3`) only. For a node
whose value changes, and because the result contains `<`, it does `$(node).before(result)` (parsing
the fixed `<sup>®</sup>` markup) and removes the original text node; the `$1` backreference is the
element's **own pre-existing text**, and the only added markup is the constant `<sup>®</sup>`. It
does not read any admin/config value into the injected markup, and it does not touch attributes —
only text-node content is modified.

## Behavior summary

- No content is stored or altered server-side; marking exists only in the rendered DOM.
- Re-runs on AJAX-loaded content (behavior fires per `context`).
- Performance caveat (per source comment): `core/once` tags many elements on large pages; the
  `body *` scope and per-text-node walk can be costly on very large DOMs.
