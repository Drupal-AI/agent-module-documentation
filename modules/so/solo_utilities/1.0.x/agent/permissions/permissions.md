# Solo Utilities — permissions

Defined in `solo_utilities.permissions.yml`. They gate the Color Schemes Rules admin UI only
(node-width and block-title features piggy-back on core node/block edit access + theme settings).

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer Color Schemes Rules` | true | All operations on color-scheme rules |
| `view Color Schemes Rules` | **false** | Viewing the rules list/overview |
| `create Color Schemes Rules` | true | Add-rule form |
| `edit Color Schemes Rules` | true | Edit-rule form (+ `_entity_access: update`) |
| `delete Color Schemes Rules` | true | Delete-rule form (+ `_entity_access: delete`) |

## Access check

All rule routes also require the custom access service `solo_utilities.access_check`
(`ColorSchemesAccessCheck`). It **first** denies access if Solo/sub-theme is not the active default
theme, then allows if the account holds any of `administer|view|edit|delete Color Schemes Rules`.
The AJAX enable/disable operation route additionally requires `_entity_access: update` and a
`_csrf_token`.

Note: `view Color Schemes Rules` is the only non-restricted permission and grants read-only access to
the rules overview — no state change, so no privilege concern.
