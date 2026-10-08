<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Booktree (booktree) — agent index

Renders a core **Book** outline as a nested HTML navigation tree on a plain page at `/booktree`.
Package `Views`. Core `^10.3 || ^11 || ^12`. **Depends on `book` (core Book module).** License
GPL-2.0-or-later. Version 3.0.0 (version-dir `3.x`). Ships **no** block, entity, plugin,
permission, service or Drush command of its own.

- **The page controller, the three routes, the settings form and config object, how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One controller: `BooktreeController` (`src/Controller/BooktreeController.php`), method `tree()`,
  injected with `config.factory`, `request_stack`, `entity_type.manager`, `database` and
  core's **`book.manager`** (`BookManagerInterface`).
- One config form: `BooktreeConfigurationForm` (`src/Form/BooktreeConfigurationForm.php`, form id
  `booktree_admin_settings`), a `ConfigFormBase` editing the single config object
  **`booktree.settings`**.
- One hook: `booktree_help()` in `booktree.module` (help text on `help.page.booktree` only).
- Assets: a static `booktree.css` (classes `li.booktree` / `ul.booktree`) — note it is **not**
  registered in any `*.libraries.yml`, so nothing attaches it automatically.

## Routes (`booktree.routing.yml`)

- `booktree.tree` — `GET /booktree` → `BooktreeController::tree()`, `_permission: 'access content'`.
  Uses the configured `booktree_start` / `booktree_deep` / `booktree_trim`.
- `booktree.tree.node` — `GET /booktree/{node}/{depth}/{trim}` (node upcast `entity:node`; `depth`
  and `trim` default null) → same method, `_permission: 'access content'`. Per-request override of
  root/depth/trim.
- `booktree.admin_settings` — `/admin/config/booktree` → `BooktreeConfigurationForm`,
  `_permission: 'administer site configuration'`. Menu link under *Configuration → Media*
  (`booktree.links.menu.yml`, parent `system.admin_config_media`).

## Config object (`booktree.settings`)

`booktree_start` (int, default 1 — root node id), `booktree_deep` (int, default 5 — max depth),
`booktree_trim` (int, default 35 — max title length before "..."). Schema in
`config/schema/booktree.schema.yml`; install defaults in `config/install/booktree.settings.yml`.

## Mechanism (from source)

- `tree()` loads the root node (configured `booktree_start`, or the `{node}` argument), 404s if the
  node is missing or `book.manager->loadBookLink()` returns nothing (not part of a book), then
  prints the node's body inside `<p>…</p>` followed by the recursive outline. Returns a `#markup`
  render array with `#cache` contexts `url.path` and per-node + `bid:<bid>` cache tags.
- `booktree_mostra_figli()` recurses to `booktree_deep + 2` levels: for each level it runs a
  `{book}`→`{node}` join `WHERE b.pid = :pid ORDER BY b.weight` (parameterised), renders the
  current node as `$node->toLink($trimmed_title)` in `<li class="booktree">`, and wraps collected
  children in `<ul class="booktree">`. Titles longer than `booktree_trim` are `mb_substr`-trimmed
  with a "..." suffix.
