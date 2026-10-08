<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Status (crossword_status) — agent index

Submodule of **crossword**. Client-side framework that adds completion-status CSS classes to rendered
crossword fields. Dep: `crossword:crossword` only. Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides

- **`hook_preprocess_field()`** (`crossword_status_preprocess_field`): for a non-empty field of type
  `crossword`, sets `attributes['data-crossword-fid']` to the first item's `target_id` and attaches
  library `crossword_status/crossword_status`.
- **Library** `crossword_status/crossword_status` = `js/status.js` (deps jquery, drupal, once,
  drupalSettings). The JS reads per-puzzle progress kept client-side and applies status classes
  (e.g. solved / in-progress) to the tagged field wrappers.

## Notes

- No routes, permissions, config, services, or server-side storage — purely a preprocess hook + JS
  behavior. Intended as a "simple framework" hook point for theme CSS/JS. (The hook docblock has a
  typo `hook_prpeprocess_field`, but the function name `crossword_status_preprocess_field` is correct,
  so it fires.)
