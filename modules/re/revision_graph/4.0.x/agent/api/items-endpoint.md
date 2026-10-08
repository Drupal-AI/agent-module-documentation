<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Items endpoint, payload & provenance field

The graph is data-driven: a thin controller serves the node's revision history as JSON, and the
standalone TS renderer (`js/revision-graph/revision-graph.iife.js`, library `revision_graph/renderer`)
draws it. Use this to consume the payload from another module or your own client.

## Routes

| Route | Path | Returns | Access |
|---|---|---|---|
| `entity.node.version_history.revision_graph` | `/node/{node}/revision_graph` | The tab page (render array, attaches the library + `drupalSettings.revisionGraph`) | `_entity_access: node.view all revisions` |
| `entity.node.version_history.revision_graph_items` | `/node/{node}/revision_graph_items` | The JSON payload (GET only) | `_entity_access: node.view all revisions` |

`{node}` must be numeric. Both are node-operation routes; the tab appears at weight 21. Controller:
`\Drupal\revision_graph\Controller\RevisionGraphController` (`revisionOverview` / `revisions`).

## Paging

Query params on the items endpoint: `offset` (default 0) and `limit` (default & hard cap 50,
`RevisionGraphController::PAGE_LIMIT`). `limit` is clamped: absent, zero or oversized → 50, so no
request can load the whole history at once. **Page using `next_offset`, not by counting commits** —
paging is counted in *revisions*, and one revision yields one commit per affected language (or none).

## Payload shape (`GraphPage::toArray`)

```jsonc
{
  "commits": [ /* Commit objects, see below */ ],
  "node": {
    "default_vid": 9,        // the node's default revision id
    "latest_vid": 9,         // the newest revision id (entity-wide)
    "live": { "en": 5, "af": 8, "bn": 9 }  // langcode -> revision holding that language's live content
  },
  "next_offset": 50,         // offset to request next, or null when exhausted
  "total": 42               // total revisions (includes revisions that yield no commit)
}
```

`node` repeats identically on every page (it is page-independent), so a client never assembles it.
An **empty `commits` page with a non-null `next_offset` is legal** (a revision affecting no language)
— do not stop paging at the first empty page.

### Commit object (`Commit::toArray`)

A commit is one **(revision, language)** pair.

| Key | Meaning |
|---|---|
| `key` | `${langcode}:${vid}` — the **only** unique-across-commits id; maps/edges are keyed by this |
| `id` | revision id as a string (for display; NOT unique — a revision affecting 2 langs → 2 commits, one `id`) |
| `branch` | langcode this commit sits on |
| `parents` | parent commit **keys** (inferred topology, E2). `[]` only for a root |
| `provenance` | *recorded* provenance edge keys (E3); `[]` where nothing was recorded (see field below) |
| `state` | exactly one of `live`, `current_unpublished`, `pending`, `historical` (role in this language's live history) |
| `trunk` | bool — was this ever the default revision (`revision_default`). Always TRUE without content moderation |
| `published` | bool — is this language of the revision published (`status`, per-language) |
| `branch_tip` | bool — newest revision affecting this language (per-language "latest"; ≠ entity `latest_vid`) |
| `workflow_state` | content-moderation state **label**, or `null` when unmoderated |
| `workflow_state_id` | state stored id, or `null` — compare against this, not the label |
| `tags` | render-time label structures (`name`/`label`/`color`); most commits carry none. NOT a fact source |
| `author` | revision author label (entity-wide; `Unknown` if the user was deleted) |
| `timestamp` | raw revision-created value, **string** |
| `message` | rendered revision log HTML (server-filtered through `Xss::getHtmlTagList()`) |
| `urls` | ordered action links, each `{name, label, url}`; `name` ∈ `view`/`revert`/`delete` — branch on `name`, not the translated `label`. Access-checked, so an absent action is one this user may not take |

Notes: `parents` is the topology the graph draws; `provenance` flags which of those edges the module
actually *recorded* (versus inferred). When provenance was recorded the resolver takes the edge's
other end from the recorded revision, so `parents` already points at that same commit — in the
payload `provenance` is therefore either empty or exactly equal to `parents`, and the endpoint never
emits a commit whose `parents` and `provenance` are both set and different. The renderer draws a
recorded edge heavier: `stroke-width` `3` instead of `2`, and it adds the `recorded` token to the
edge's `revision-graph__connection` class (`RevisionGraphGenerator.ts`). It does not add a `<title>`.

## Provenance base field (`revision_graph_parent`)

4.0 adds a **revisionable, non-translatable integer base field on nodes**, `revision_graph_parent`
(`\Drupal\revision_graph\RevisionGraph\ProvenanceField`, installed via
`hook_entity_base_field_info` in `RevisionGraphHooks`). It stores, per revision, the id of the
revision that save was derived from — written in `hook_entity_presave` from `getLoadedRevisionId()`
(presave, not postsave: postsave would make every revision its own parent). New nodes and
save-in-place (no new revision) record nothing.

- **Run `drush updb` after upgrading** to install the field. Until then the graph draws from
  inferred edges only; nothing breaks.
- **Existing revisions are not backfilled** — they keep empty `provenance` and inferred edges.
  Provenance is recorded from the next save onward. Uninstalling the module drops the column.

## drupalSettings on the tab page

The tab attaches `drupalSettings.revisionGraph.palette` (resolved colour list) and
`.branchColors` (resolved langcode → colour map). See [configure/colors.md](../configure/colors.md).
