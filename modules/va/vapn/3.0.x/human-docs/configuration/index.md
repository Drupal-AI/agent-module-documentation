# Configuration

Setting up VAPN is two steps: choose which content types it applies to, then set
the allowed roles on individual nodes.

## 1. Enable VAPN on content types

VAPN does nothing until you switch it on for one or more node types.

1. Log in as a user with the **Administer VAPN** permission.
2. Go to **Configuration → People → View access per node**
   (`/admin/config/people/vapn`).
3. Tick the content types that should get per-node view access, and **Save**.

Saving attaches the **View access per node** field to those content types. (The
setting is stored in the `vapn.settings` configuration object, so it exports and
deploys with your site config.)

## 2. Set which roles can view a node

Once a content type is enabled, edit any node of that type. In the right-hand
sidebar you'll find a **View access per node** vertical tab. It shows a list of
role checkboxes:

- **Tick one or more roles** to restrict the node so that only users holding at
  least one of those roles may view it. Everyone else — including anonymous
  visitors, unless you tick the *Anonymous user* role — is denied.
- **Leave every box unticked** to let VAPN abstain for that node. It applies no
  restriction, and core/other modules decide access as usual.

Roles that already have core's *Bypass content access control* are not offered in
the list (they can see everything anyway).

## How view access is decided

When someone tries to **view** a node of an enabled type, VAPN applies this logic:

1. If the user has the **Bypass VAPN** permission → allowed, always.
2. Otherwise, if the node has one or more roles selected → allowed only if the
   user has at least one of those roles; if not, access is **denied**.
3. If the node has no roles selected → VAPN stays neutral and lets other access
   rules apply.

Only the **view** operation is affected — creating, editing and deleting are
untouched. Because VAPN works through Drupal's standard node-access hook, it
composes with other access modules: any module that denies access still wins.

## Things to keep in mind

- Selecting even a single role turns VAPN on for that node and hides it from
  everyone without a matching role, including anonymous users.
- To keep a node public, simply leave its role list empty.
- Who may **change** a node's role list is governed by the **Use VAPN** and
  **Administer VAPN** permissions (see the [permissions
  reference](../agent/permissions/permissions.md) in the agent docs).
