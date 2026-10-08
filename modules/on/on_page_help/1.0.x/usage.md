<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shows editable, revisionable help content in a block that appears only on the routes (and for the roles / node types) you target.

---

On-page Help defines a bundleable content entity (`on_page_help`) with a configurable type entity (`on_page_help_type`). Each help item is tied to a route (via the `route` field), optionally restricted to specific node types and to users who hold ALL listed roles, and can be published/unpublished with full revision and translation support. The `OnPageHelpBlock` block resolves the current route, finds the first help item the current user is permitted to see, and renders it; if none exists and the user may add help, it renders an "Add a new on-page help" link that prepopulates the route (and node type) via the prepopulate dependency.

Setup: create at least one OPH *type*, place the "On-Page Help block" (choosing the type), then author help items from the block's contextual add link or the entity add form. Access is governed by a granular permission set — global `add/edit/delete/view published/view unpublished on-page help`, per-type generated permissions, and "own" variants — enforced by a dedicated access-control handler. `administer on-page help` is marked restricted.

---

- Show contextual help on specific pages by matching the current route.
- Create reusable help items as a revisionable, translatable content entity.
- Define multiple independent On-Page Help *types*, each with its own block.
- Place the On-Page Help block and bind it to a chosen help type.
- Target a help item to a single route (e.g. `entity.node.canonical`).
- Limit a help item to specific node types (bundles).
- Restrict a help item to users who hold all listed roles.
- Publish or unpublish help items to control visibility.
- Keep a revision history of help content and revert to earlier versions.
- Translate help items into multiple site languages.
- Add a new help item from the block's contextual link with the route prepopulated.
- Prepopulate the node type on the add form when creating help on a node page.
- Grant granular permissions (add/edit/delete/view published/view unpublished).
- Grant revision permissions (view all / revert / delete revisions).
- Use per-type generated permissions to delegate help authoring by type.
- Let authors manage only their own help items via the "own" permissions.
- Provide inline onboarding/help without editing theme templates.
- Show an "Add on-page help" prompt to editors on pages that lack help.