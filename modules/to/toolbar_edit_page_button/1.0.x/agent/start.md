<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar Edit Page Button (toolbar_edit_page_button) — agent index

Adds one item to the administration **toolbar** that links to the edit form of the **node** currently
being viewed, labelled `Edit Page (<nid>)`. Implemented entirely in two procedural hooks — no routes,
services, controllers, forms, plugins, config schema or config entities.
`toolbar_edit_page_button_toolbar()` (`toolbar_edit_page_button.module:41`) reads the `node` route
parameter via `\Drupal::routeMatch()->getParameter('node')`; if the current user holds the permission
**and** that parameter is a `NodeInterface`, it emits a `toolbar_item` whose `tab` is a `#type => link`
pointing at `internal:/node/<nid>/edit`. Otherwise it emits a `visually-hidden` placeholder linking to
`<front>` (present in the DOM but not shown). The button therefore appears on node canonical pages
only — never for views, taxonomy terms, users, the front page or other entity types, none of which set
a `node` route parameter.

Gating is by the module's own permission and by whether a `node` route parameter is present — not by
per-node edit access — so the button can appear for a permitted user on a node they cannot actually
edit; clicking then lands on core's normal access-denied page. Following the link grants no access of
its own: `/node/{node}/edit` is a core route (`entity.node.edit_form`) that enforces its own access.
Output caching uses the contexts `user.permissions` and `url`. The nid is also printed in parentheses
next to the label so editors can see which node they are about to open.

- **Depends on:** nothing declared in `.info.yml` (no `dependencies:` key), but requires the core
  **node** module at runtime (uses `Drupal\node\NodeInterface`).
- **Core:** `^8 || ^9 || ^10 || ^11` (info.yml `core_version_requirement`). **Package:** Administration.
- **Settings page / configure route:** none (`configure` null) — nothing to configure.
- **Permissions:** one — `access toolbar edit page button` (`.permissions.yml`).
- **Drush:** none. **Plugin types:** none. **Config schema/install:** none.
  **Libraries / JS / CSS / templates:** none shipped.
- Trivial module: correctly start-only, no topic files.

## How to operate it
- **Show the button to a role** → grant `access toolbar edit page button` (People → Permissions, or
  the `user_role.*` config `permissions` list). The core **toolbar** module must be enabled and the
  user must be able to see the toolbar.
- **Restyle the button** → CSS only; target `a[href^="/node/"].toolbar-icon-edit.toolbar-item`
  (the README's example). The module ships no CSS of its own.
- **Change the label, or support other entity types** → not configurable; only by patching
  `toolbar_edit_page_button_toolbar()`.

## Key facts (real machine names)
- Hooks: `hook_toolbar()` → `toolbar_edit_page_button_toolbar()`; `hook_help()` →
  `toolbar_edit_page_button_help()` (renders the About text on route `help.page.toolbar_edit_page_button`).
- Permission: `access toolbar edit page button`.
- Render item key: `toolbar_edit_page_button` (`#type => toolbar_item`, `tab` → `#type => link`).
- Link target: `internal:/node/<nid>/edit` (core route `entity.node.edit_form`).
- CSS classes on the link: `toolbar-icon`, `toolbar-icon-edit`; hidden-placeholder wrapper classes:
  `edit-toolbar-tab`, `visually-hidden`.
- Cache contexts: `user.permissions`, `url`.
- No routes, services, config keys, plugins, formatters/widgets, or drush commands.
