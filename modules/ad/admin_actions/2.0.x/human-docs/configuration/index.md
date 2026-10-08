# Configuration

Admin actions has no settings form of its own. You configure it in two places: the
**view** decides which action buttons exist and who may use them, and **Block
layout** decides where the buttons appear.

## 1. Choose the actions in the view

1. Go to **Structure → Views → Admin actions**, or navigate directly to
   `/admin/structure/views/view/admin_actions`.
2. Under **Fields**, open the **Global: Views bulk operations** field.
3. Select the actions you want to offer as buttons — core actions, actions from the
   Action module, or contrib actions such as Views Bulk Edit. You can relabel each
   one so editors see a clear button caption (for example "Promote to front page"
   or "Unpublish").
4. Save the view.

Each action you tick becomes a separate button; combine several to offer a small
toolbar of one-click operations on an entity.

## 2. Restrict who sees the buttons

Access to the buttons is governed by the view's own **access** settings plus each
action's internal access check. In the view, set the access (by role or
permission) under the view's access section so only the right editors see the
buttons. Even if a button is visible, an action that checks entity access (like the
Refresh date example, which requires node update access) will still refuse to run
for a user who lacks permission.

## 3. Place the button block

The buttons are rendered by a block, so nothing appears on entity pages until you
place it:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** and choose the **Admin actions** block
   (`views_block__admin_actions_admin_actions_block`).
3. Set its **visibility** so it shows on the pages you want — for example on
   `/node/*` pages — and position it in a suitable region.
4. Save the block.

The action buttons now appear alongside those entity pages. The module
auto-selects the single contextual entity and hides the bulk-operations table, so
there is no checkbox to tick — the editor just presses a button.

## Reusing the button UI on your own view

You are not limited to the bundled view. Give any VBO-enabled view the
administrative **tag** `admin_actions`, and the same behaviour (auto-select the
single row, hide the table, show only the buttons) applies to that view's block
form too.

## Adding a custom action

Developers can add their own action as a plugin under `src/Plugin/Action/` with an
`@Action` annotation that declares a `type` (VBO ignores actions with no type),
implement `execute($entity)`, and gate it in `access()`. The bundled **Refresh
date** submodule is a minimal working example — its `access()` returns the node's
`update` access.
