<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Search Snippet — agent start

**What**: Views field handler `views_search_snippet` on the `node_search_index` table that
renders a highlighted search excerpt per node. Depends on `views` + core `search`.

## Set up
1. `drush en views_search_snippet -y`.
2. In a View of **Content** (or search index), add a **core Search** filter (Search: Fulltext
   search) and expose its `keys`. This is required — the snippet self-excludes without it.
3. Add the field **Snippet** (group *node_search_index* / "Snippet").
4. The field renders only when the search filter shares the field's relationship.

## Key facts
- Class: `Drupal\views_search_snippet\Plugin\views\field\Snippet`.
- `query()` sets `exclude=TRUE` unless a handler with `search_score` on the same
  relationship exists; then it adds the index `langcode` field.
- `render()` view-builds the node in the `search_result` view mode, renders it, then calls
  core `search_excerpt($keys, $html)`; `$keys` comes from `getExposedInput()['keys']`.
- Node view access is enforced by the entity view builder during rendering.
- No settings form, routes, or permissions of its own.
