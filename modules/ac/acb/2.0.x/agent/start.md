<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Control Bridge (acb) — agent index

**Access Control Bridge** makes several Drupal **node-access** modules combine with **AND**
logic instead of core's default **OR**. No routes, no config, no permissions, no plugins,
no services, no blocks — the entire module is three files of hook implementations that
rewrite node grants. Version **2.0.2**, core `^9.5 || ^10 || ^11`, GPL-2.0-or-later.
Zero dependencies: it bridges whatever grant-issuing modules are present (Content Access,
Domain Access, Workflow, Organic Groups, Taxonomy Access Control, ACL, …).

## The core problem it solves
Drupal's node access grants table combines with **OR**: a node is viewable/editable if
**any** participating module grants it. So adding a second access module usually makes
content **more** accessible, not less — teams expect restrictions to intersect, and instead
they union. The module's own help text: these modules "tend to break each other's
functionality if used together." ACB intersects them.

## How it actually works (source: `acb.module`)
- `acb_get_modules()` — enumerates every module implementing `hook_node_grants` and/or
  `hook_node_access_records` (excludes `acl`, and optionally `acb` itself). This is the set
  of "access-controlling modules" it bridges.
- `hook_node_access_records_alter()` — splits a node's access records by originating module
  (via realm-prefix matching in `acb_is_module_realm()`). **Only if more than one module
  controls the node**, it replaces the records with a cross-product of cascaded `acb&…`
  realm records. Grant flags are **multiplied** (`grant_view * grant_view …`), so a combined
  record allows an operation only when *every* participating module allows it — that is the
  AND. Single-module nodes are left untouched.
- `hook_node_grants_alter()` — computes the current user's matching `acb&…` grants so the
  user is admitted to exactly the combined realms they satisfy in all modules. Special-cases
  `all`/`acl` realms, Domain Access domain IDs, and reads the `acl` table for ACL id→module
  mapping.
- `_acb_cascade_grants()` — the recursive cross-product engine shared by both alters.
- `hook_modules_installed()` — triggers `node_access_needs_rebuild(TRUE)` when a new
  access-controlling module is enabled.

## Install/lifecycle (source: `acb.install`)
- `hook_install()` sets module weight to **500** so its alter hooks run **last**.
- `hook_enable()`/`hook_disable()` both call `node_access_needs_rebuild(TRUE)`.

## Operating cautions (highest-consequence category on a site)
- **Testing is the deliverable.** Enumerate roles × content states — including the
  **anonymous** row — and verify each cell before and after enabling.
- Because access becomes an intersection, you must grant access in **every** controlling
  module for content to be reachable (e.g. Content Access must grant view even when Workflow
  is the state you care about).
- Any grants change needs `node_access_rebuild()`; watch the site while it runs — a
  partially rebuilt grants table is a live disclosure, not a cosmetic glitch.

## Files here
- `../data.json` — metadata.
- `../usage.md` — summary, dense paragraph, use-case bullets.
- `hooks/node-access.md` — the exact hooks and grant-cascade mechanism.
