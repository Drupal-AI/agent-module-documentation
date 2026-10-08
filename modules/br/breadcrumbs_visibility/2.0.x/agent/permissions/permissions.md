# Permissions

Defined in `breadcrumbs_visibility.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer breadcrumbs visibility config` | Setting the "Display breadcrumbs" value on the node form and the per-content-type default on the node type form. |

Constant `BREADCRUMBS_VISIBILITY_PERMISSION` in the `.module` file. Enforcement is UI-level:
when the current user lacks the permission, the checkbox is rendered `#disabled` on both the
node edit form and the node type edit form, and the description changes to "Your account does
not have permission to set the breadcrumb visibility."

Notes:
- The permission is not marked `restrict access: true`. Its only capability is toggling whether
  the breadcrumb block renders on a node — a display-only effect.
- The `display_breadcrumbs` base field has no dedicated field-access handler, so the restriction
  is enforced by the disabled form widget rather than by entity field access.
