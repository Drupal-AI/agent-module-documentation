# Permissions

`metatag.permissions.yml`:

| Permission | Gates | Notes |
|---|---|---|
| `administer meta tags` | The Metatag settings/defaults admin pages (`/admin/config/search/metatag`). | `restrict access: TRUE`. Does **not** control access to the Metatag *field* on content forms — use the Field Permissions module or a `hook_form_alter()` for that. |

For per-tag field access, enable the **metatag_extended_perms** submodule, which adds an
individual permission for every meta tag. Custom Tags admin is gated by the
**metatag_custom_tags** submodule's `administer custom meta tags` permission.
