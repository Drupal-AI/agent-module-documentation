<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# on_page_help — creating help items

## 1. Create an OPH type
Go to the On-page Help type collection (`entity.on_page_help_type.collection`) and add a type, or use the shipped default `route_on_page_help`. Each type is independent and gets its own block + generated permissions.

## 2. Place the block
Place the **On-Page Help block** (`on_page_help_block`) in a region. In the block form pick the **On-Page Help Type** it should display. Cache contexts `url.path` + `user` mean it re-resolves per page and per user.

## 3. Author help items
- Add a help item from the block's contextual **Add a new on-page help** link (prepopulates the current route, and the node type when on a node) or from the entity add form.
- Fields: **route** (the route name to match, e.g. `entity.node.canonical`), **node_types** (optional — limit to these bundles), **roles** (optional — viewer must hold *all* listed roles), body/help content, plus publish status.
- Revisions and translations are supported like a node.

## Matching logic (block build)
For the current route the block loads items matching the route + selected type, then keeps the first that (a) passes node-type restriction, (b) whose required roles are all held by the user, and (c) that the user has `view` access to. Unpublished items need `view unpublished on-page help` (or the "own" permission).

## Permissions
Grant from: `add / edit / delete on-page help`, `view published on-page help`, `view unpublished on-page help`, revision permissions, and per-type / own-entity permissions. `administer on-page help` is restricted and bypasses to the type admin form.