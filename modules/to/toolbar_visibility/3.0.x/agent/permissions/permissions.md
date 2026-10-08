# Toolbar Visibility — permissions

Defined in `toolbar_visibility.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer toolbar visibility` | Access to the settings form at `/admin/config/toolbar-visibility` (route `toolbar_visibility.settings`). |

- This is the only permission the module defines, and it gates nothing beyond its own config form.
- It is not marked `restrict access: true`, but it only lets the holder choose on which themes/domains
  the toolbar is hidden — a cosmetic/UI toggle with no boundary-crossing capability.
