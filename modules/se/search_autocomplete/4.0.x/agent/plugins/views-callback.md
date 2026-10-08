<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Suggestion sources from a View

A configuration's `source` can be `view_id::display_id`. The module ships three Views plugins to build
the JSON suggestion endpoint that such a source points at:

| Plugin type | Class | Purpose |
|---|---|---|
| Views **display** | `Drupal\search_autocomplete\Plugin\views\display\AutocompletionCallback` | An "Autocompletion callback" display that returns suggestions as JSON at a path. |
| Views **row** | `Drupal\search_autocomplete\Plugin\views\row\CallbackFieldRow` | Maps each result row to a suggestion (fields → label/value/link). |
| Views **style** | `Drupal\search_autocomplete\Plugin\views\style\CallbackSerializer` | Serializes the rows (JSON) for the autocomplete widget. |

The shipped configs use views `autocompletion_callbacks_nodes`, `autocompletion_callbacks_users`,
`autocompletion_callbacks_words`, each with an Autocompletion callback display.

## How `source` is resolved

When `source` is `view_id::display_id` (see `search_autocomplete.module` → `attach_configuration_to_element()`):
1. The view + display are loaded; the callback URL becomes the display's path.
2. Exposed filter identifiers are collected and appended as query params (`q` plus each exposed filter,
   and contextual filters exposed as `query_parameter`).
3. If `source` is not `a::b`, it is treated as a direct callback URI.

## Build your own suggestion view

1. Create a view over the entity you want to suggest.
2. Add an **Autocompletion callback** display (`AutocompletionCallback`).
3. It uses the CallbackFieldRow + CallbackSerializer to emit JSON; add the fields that become the
   suggestion label/value/link.
4. Point a configuration's `source` at `your_view::your_display`.
