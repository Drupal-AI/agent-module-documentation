# Permissions

Defined in `google_index_api.permissions.yml`.

| Permission | Machine name | Guards |
|---|---|---|
| Administer Google Index API Settings | `administer google index api` | Both routes: the settings form (`/admin/config/services/google-index-api`) and the bulk-update form (`/admin/config/services/google-index-api/bulk-update`). |

This is the module's only permission and the only access gate it defines. It controls who can upload
the service-account credential, set the base domain, and run bulk submissions. Grant it to trusted
administrators only. The service (`google_index_api.client`) itself is not permission-gated — access
to it is whatever your calling code enforces.
