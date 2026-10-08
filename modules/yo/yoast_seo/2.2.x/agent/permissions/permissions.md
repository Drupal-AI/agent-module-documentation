# Permissions

Defined in `yoast_seo.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer yoast seo` | Access the global settings page (`/admin/config/yoast_seo`) and configure per-content-type settings. `restrict access` (trusted admins). |
| `use yoast seo` | View/edit the Real-time SEO analysis field on individual entities. |

Field access (`yoast_seo_entity_field_access()`) grants the `yoast_seo` field to any user with
`use yoast seo` **or** `administer yoast seo`; everyone else is denied that field.
