<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin actions turns Views Bulk Operations (VBO) actions into one-click buttons rendered directly on an entity's view or edit page, instead of the `/admin/content` bulk dropdown.

---

The module ships a `admin_actions` view (a VBO-enabled block display) and a `hook_form_alter` that detects any `views_form_*` whose view id is `admin_actions` or carries the `admin_actions` tag. For those forms it auto-selects the single result row and visually hides the VBO table, leaving only the operation buttons — so pressing a button runs the chosen action against the current contextual entity. The view is exposed as a block (`views_block__admin_actions_admin_actions_block`) that you place near entity pages via the Block layout. It supplies no actions of its own: you pick actions in the VBO field of the view, drawing on core `action` plugins and contrib actions (e.g. views_bulk_edit). Access to the buttons is governed by the view's own access settings and each action's `access()` check.

The bundled `refresh_date` submodule is an example custom Action plugin (`node_refresh_date_action`) that resets a node's `created` timestamp; its `access()` defers to the node's `update` access. Setup is: enable, place the block, then edit the view at `/admin/structure/views/view/admin_actions` to choose actions and labels. The form_alter is heavily dependent on VBO/Views internals and defensively no-ops on any unexpected structure.
---
Add a one-click "promote to front page" button on a node page.
- Add a one-click "unpublish" button on a node view page.
- Expose a custom action button on node edit forms.
- Surface a "mark as reviewed" business-rule action on content.
- Run a views_bulk_edit field update from an entity page.
- Place the admin_actions block near `/node/*` pages.
- Reposition the action block to fit your theme.
- Tag any custom VBO view with `admin_actions` to reuse the button UI.
- Choose which actions appear by editing the VBO field in the view.
- Relabel action buttons for editors.
- Restrict button visibility via the view's access settings.
- Use the refresh_date example action to bump a node's created date.
- Expose contrib module actions as single-entity buttons.
- Auto-select the single filtered row so no checkbox is needed.
- Hide the VBO results table while keeping the operation buttons.
- Give front-end editors quick workflow actions without the admin content list.
- Build a per-entity "set expiry 3 months out" action.
- Combine multiple actions as separate buttons on one page.
- Add a custom Action plugin under `src/Plugin/Action` for VBO discovery.
- Gate an action with an entity access check inside the plugin's access().
