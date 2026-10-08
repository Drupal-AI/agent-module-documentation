# Configure the Next Previous block

No admin settings page. Place the block via *Structure → Block layout → Place block* → **Next
Previous link** and configure it on the block form. All settings are stored on the block instance
(`block.block.*` config), so multiple instances can target different content types.

## Block settings (`blockForm`)

| Key | Type | Required | Default | Meaning |
|---|---|---|---|---|
| `content_type` | select (node bundles) | yes | — | The single content type the navigation applies to. |
| `previous_text` | textfield | yes | — | Label for the previous link. |
| `next_text` | textfield | yes | — | Label for the next link. |
| `previouslink_class` | textfield | no | `btn` (fallback) | CSS class added to the previous link. |
| `nextlink_class` | textfield | no | `btn` (fallback) | CSS class added to the next link. |

Options come from `node_type_get_names()`. Empty class falls back to `btn` at render time.

## How the neighbour node is chosen (`build` / `generateNextPrevious`)

1. `build()` reads the `node` route parameter. It renders **only** if that is a `NodeInterface`
   whose `getType()` equals the configured `content_type`; otherwise returns an empty array.
2. For each direction it queries the `node` storage:
   - **previous**: `nid < current`, `sort nid DESC`, take first → nearest lower id.
   - **next**: `nid > current`, `sort nid ASC`, take first → nearest higher id.
   - Both add `condition('type', <bundle>)`, `condition('status', 1)`,
     `condition('langcode', <current node langcode>)`, `range(0, 1)`, `accessCheck(TRUE)`.
3. Ordering is purely by **node id** (creation order) — not by created date, title, or menu weight.
4. Each hit becomes `Link::fromTextAndUrl(<label>, internal:/node/<nid> path)` rendered with
   `#attributes.class = ['nextpre__btn', <your class>]`. Missing neighbour → that link is omitted.

Result render array keys: `prev` and/or `next` (either may be absent at the ends of the range).

## Caching

- `getCacheContexts()` merges `route` (output depends on the current node page).
- `getCacheTags()` merges `node:*` when a node is present, so adding/editing any node invalidates
  the block. (`node:*` is broad — it invalidates on any node change, favouring correctness over
  granularity.)

## Notes

- The block emits no wrapper markup of its own beyond the two links; style via the
  `nextpre__btn` class or your configured class.
- Because selection is id-based, "next/previous" follows node creation order, which may differ from
  any date field or manual ordering you display elsewhere.
- To navigate by a different order (e.g. published date), this module does not support it — use a
  View or a custom block instead.
