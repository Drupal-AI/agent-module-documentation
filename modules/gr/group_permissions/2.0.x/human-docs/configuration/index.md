# Configuration

Setting up Group permissions has three parts: switch overriding on for the group
types that need it, grant the right people the permission to override, and then
edit an individual group's permissions.

## 1. Enable overriding for a group type

Per-group overriding is off by default, and the per-group permissions form only
appears where it has been switched on.

1. Log in as an administrator.
2. Go to **Groups → Group types** and edit the group type you want to allow
   overrides for.
3. Enable the group-permissions overriding option for that group type and save.

Only the group types where you do this will offer per-group overrides — leave it
off for the ones that should always follow their type's defaults.

## 2. Grant the "override group permissions" permission

Editing a group's overrides is controlled by Group's in-group **override group
permissions** permission — that is, it is checked *inside* each group, against the
user's role in that group, rather than as a site-wide Drupal permission. This
permission is restricted because it is effectively the power to grant rights to
other members.

Grant it to the group roles that should be able to manage a group's own
permissions — typically a group's administrator/owner role — through the group
type's permissions page. Give it only to trusted roles.

## 3. Edit a single group's permissions

1. Go to the group you want to customise.
2. Open its **Permissions** tab, or navigate to `/group/{group}/permissions`
   (replacing `{group}` with the group's ID).
3. The form shows the permissions for that group, starting from the group type's
   defaults. Adjust them for this group's roles — grant an extra permission,
   restrict one, and so on.
4. Save.

The group now uses its own override set instead of (or on top of) the type's
defaults, and the change applies everywhere access is evaluated, including listings
and queries.

## Reverting and history

- **Revert to defaults:** you can restore a group to its group type's default
  permissions at any time, discarding the override.
- **Revisions:** the module keeps a revision history of override changes, so you
  can see who changed a group's permissions and when.
