# Permissions

Defined in `web_accessibility.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `administer_web_accessibility` | Administer Web Accessibility | Access to both admin routes — the settings form (`web_accessibility.settings`) and the delete-service confirm form (`web_accessibility.delete_service`), i.e. adding and removing the validator services listed on the node edit form. |

Notes:
- The machine name is spelled with underscores (`administer_web_accessibility`), which is
  unusual for a Drupal permission string but is the exact key checked by both routes'
  `_permission` requirement.
- No `restrict access: true` flag is set on the permission.
- This is the only permission the module defines; the node-form section itself
  (see [hooks/node_form.md](../hooks/node_form.md)) is gated by ordinary node edit access,
  not by this permission.
