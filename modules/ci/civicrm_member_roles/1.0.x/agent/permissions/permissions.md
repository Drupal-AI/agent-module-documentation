# Permissions

Defined in `civicrm_member_roles.permissions.yml` (one permission).

| Permission | Title | Grants |
|------------|-------|--------|
| `access civicrm member role setting` | Access CiviCRM member role setting | Access to CiviMember Roles Sync: create/edit/delete Association Rules, edit the settings form, and run the manual sync. |

This is the single gate for the whole module:
- It is the `admin_permission` on the `civicrm_member_role_rule` config entity, so the rule
  collection/add/edit/delete/canonical routes require it (via `AdminHtmlRouteProvider`).
- Both non-entity routes — the settings form and the manual-sync form
  (`civicrm_member_roles.routing.yml`) — require it too (`_permission`).

Because holders can map any membership type/status to any Drupal role (except anonymous/authenticated),
this permission is effectively administrative — treat it like an admin-level grant and give it only to
trusted staff.
