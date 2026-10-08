<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booktree — page, routes & settings

Everything Booktree does lives in one controller plus one config form. There are no plugins,
entities, services or permissions to wire.

## Install / enable

```
composer require drupal/booktree   # pulls drupal/book ^2.0 || ^3.0
drush en booktree -y
```

Requires core's **Book** module (`dependencies: [book:book]`). After enabling, visit
`/admin/config/booktree` and set at least a valid **Root Node ID** — the default `booktree_start`
is `1`, which will 404 unless node 1 exists and is part of a book.

## Config object `booktree.settings`

Edited by `BooktreeConfigurationForm` (`src/Form/BooktreeConfigurationForm.php`, form id
`booktree_admin_settings`, `getEditableConfigNames()` → `['booktree.settings']`). Three integer
keys (schema `config/schema/booktree.schema.yml`, install defaults
`config/install/booktree.settings.yml`):

| Key | Form label | Default | Meaning |
|---|---|---|---|
| `booktree_start` | Root Node ID | `1` | Node id used as the tree root on `/booktree`. |
| `booktree_deep` | Deep Max | `5` | Max tree depth. Controller renders to `booktree_deep + 2` levels. |
| `booktree_trim` | Trimmer | `35` | Max title length; longer titles are `mb_substr`-trimmed + `...`. |

All three fields are `#type => number`, `#required => TRUE`, `#min => 1`. Values are stored verbatim
by `submitForm()` (no extra validation/casting). Example export:

```yaml
# booktree.settings.yml
booktree_start: 42
booktree_deep: 5
booktree_trim: 35
```

## Routes & permissions (`booktree.routing.yml`)

- **`booktree.tree`** — `GET /booktree`, `_permission: 'access content'`. Calls
  `BooktreeController::tree()` with no arguments, so it reads the three config values. `depth`/`trim`
  fall back to config; the controller computes `maxricursione = booktree_deep + 2`.
- **`booktree.tree.node`** — `GET /booktree/{node}/{depth}/{trim}`, `_permission: 'access content'`,
  `{node}` upcast as `entity:node`, `depth` and `trim` default `null`. Overrides the root node and
  (optionally) depth and trim per request. When `depth`/`trim` are omitted the controller uses
  `depth+2` from config-or-arg and a hardcoded `trim` of `256`.
- **`booktree.admin_settings`** — `/admin/config/booktree`, `_permission: 'administer site
  configuration'`. The settings form. Menu link "Booktree" under *Configuration → Media*
  (`booktree.links.menu.yml`, parent `system.admin_config_media`, weight 20).

The module defines **no permissions.yml** — the two page routes rely on the core `access content`
permission and the admin route on core `administer site configuration`.

## What the controller renders (`BooktreeController::tree()`)

1. Resolve the root node: the `{node}` argument, else load `booktree_start` via the node storage.
   Throw a cacheable 404 (`CacheableNotFoundHttpException`) if the node does not exist.
2. `book.manager->loadBookLink($node->id())` — cacheable 404 if the node is not in any book. The
   book id becomes cache tag `bid:<bid>`.
3. Print the root node's `body.value` inside `<p>…</p>` (only if the node has a non-empty `body`
   field), then the recursive child outline.
4. Return `#type => markup` with `#title` = the root node title, `#markup` = the built HTML, and
   `#cache` = `{contexts: [url.path], tags: [node:<id>…, bid:<bid>]}`.

## Recursion helper (`booktree_mostra_figli()`)

Private, recurses while `ricursione < maxricursione`. Per call it runs a parameterised join:

```sql
SELECT DISTINCT b.nid, b.pid, b.weight
FROM {book} b INNER JOIN {node} n ON n.nid = b.nid
WHERE b.pid = :pid ORDER BY b.weight
```

For each child row it loads the node (`entity_type.manager` node storage), adds a `node:<nid>`
cache tag, and recurses. The current node (except the start node itself, which is hidden as the
outline root) is emitted as `<li class="booktree">` wrapping `$node->toLink($trimmedTitle)`;
collected children are wrapped in `<ul class="booktree">`. Titles longer than the trim length are
shortened with `mb_substr(...) . '...'`.

## Operating notes

- **Styling is manual.** `booktree.css` exists but is not declared in a `*.libraries.yml`, so it is
  not attached to the page. Add it via your theme (or a custom library) if you want the
  `li.booktree` / `ul.booktree` styles.
- **Advanced URLs** (README): `/booktree/<root-node>/<depth>/<trim>` — e.g. `/booktree/1834/20/50`,
  `/booktree/1834/20`, `/booktree/1834`. Lets one site show several book trees from different URLs.
- The page is a full-width markup page, not a block or a Views display — link to it from a menu to
  surface it.
