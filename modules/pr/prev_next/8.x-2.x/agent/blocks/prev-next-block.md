<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prev/Next block & read API

## Block plugin
`Drupal\prev_next\Plugin\Block\PrevNextBlock` (id `prev_next_block`, admin label "Prev/Next").
- **Context**: `context_definitions` requires `node` = `@ContextDefinition("entity:node")`, so the
  block only renders where a node is in context (node view pages, or a manually mapped context).
- **DI** (`create()`): `request_stack`, `module_handler`, `prev_next.helper`.
- **Per-instance settings** (`blockForm`/`blockSubmit`, `defaultConfiguration`):
  - `prev_display` (bool, default TRUE), `prev_text` (default `«prev`).
  - `next_display` (bool, default TRUE), `next_text` (default `next»`).

### build()
Reads the context node, then calls
`prevnextHelper->getPrevnextId($node->id(), 'prev')` and `… 'next'`. A side of the pair is added to the
render array only when its id exists **and** its `*_display` is on **and** its `*_text` is non-empty.
Renders via `#theme => 'prev_next_block'`.

### Template
`templates/prev-next-block.html.twig` (theme hook `prev_next_block`, vars: `prev_display`,
`prev_text`, `prev_id`, `next_display`, `next_text`, `next_id`). Outputs:
```
<div class="prev"><a href="/node/{{ prev_id }}">{{ prev_text }}</a></div>
<div class="next"><a href="/node/{{ next_id }}">{{ next_text }}</a></div>
```
Links are plain `/node/<id>` paths (node ids only, no titles). The target node still enforces its own
view access when followed.

### Placing it
Block layout (*Structure › Block layout*), or Layout Builder, on a region shown on node pages. Restrict
visibility to the relevant content types if you only indexed some.

## Read API (custom code)
`$helper = \Drupal::service('prev_next.helper');` — `Drupal\prev_next\PrevNextHelper`:
- `getPrevId($nid)` → `SELECT prev_nid FROM {prev_next_node} WHERE nid = :nid`.
- `getNextId($nid)` → `SELECT next_nid FROM {prev_next_node} WHERE nid = :nid`.
- `getPrevnextId($nid, $op='next')` → dispatches to the two above; any `$op` other than
  `prev`/`next` returns `0`.

Returns the stored neighbour nid (or falsy/`0` when none). Values are `0` when no neighbour was found
at index time. This is a lookup only — it does not recompute; if the index is stale (e.g. a node was
imported without triggering the entity hooks), re-save or re-index first (see
[config/settings.md](../config/settings.md)).
