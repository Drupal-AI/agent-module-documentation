# Field Permissions Group — manual setup guide

**Field Permissions Group** (`field_permissions_group`) extends the
[Field Permissions](https://www.drupal.org/project/field_permissions) module with a
**Group-aware** permission type. Instead of controlling create / edit / view access
to a field with site-wide roles, it lets you control that access based on the user's
membership and roles *within a [Group](https://www.drupal.org/project/group)*. So a
field can be made visible or editable only to members who hold a particular group
permission — a finer-grained, group-scoped level of field access than site-wide
roles can express.

This is a genuine access-control feature, and it is **fail-closed**: its
`CustomGroupAccess` plugin grants access to a field only when the account actually
holds the relevant group permission for the operation. No membership and no matching
permission means no access — which is the correct restrictive default. And because
it hooks into Drupal's entity/field access system, the restriction is enforced
wherever field access is checked, not just on a form.

It is meant for Group-based sites — communities, organizations, membership sites —
where some fields on a group or group-content entity should only be seen or edited
by the right members. It requires both **Field Permissions** and **Group**. This
3.x branch supports **Group 3** on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Field Permissions and Group.

There is **no dedicated configuration page** for this module. It adds a new field-
permission *type* to the existing Field Permissions machinery; you configure it on
each field and in your group roles, as described below.

## How access is configured

Field Permissions Group does not add a settings form of its own — it plugs into two
places you already use:

1. **On the field.** Edit the field (on a group or group-content entity) at its
   **Field settings**, where Field Permissions adds a **Field visibility and
   permissions** section. Choose the **group-based** permission option this module
   provides, so access to that field is governed by group permissions rather than
   by site-wide roles or a public/private setting.
2. **On your group roles.** Grant the resulting field permissions to the appropriate
   **group roles** at **Groups → *(group type)* → Manage permissions** (or
   `/admin/group/types` → the group type's permissions). A member gets access to the
   field only if their group role holds the matching permission for the operation
   (create, edit, or view).

Because the access check fails closed, review your group-role permission assignments
after enabling this so the fields are visible and editable to exactly the members
you intend — and remember the restriction applies anywhere entity/field access is
evaluated.
