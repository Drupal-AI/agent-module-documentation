# Permissions

All `restrict access: TRUE`. Each gates a manual access-grant admin form (grant/revoke a user's access
without them entering the password).

| Permission | Gates |
|---|---|
| `entity_access_password_user_data_backend_access_entity_form` | Per-entity user-data form (edit access grants for one entity). |
| `entity_access_password_user_data_backend_access_bundle_form` | Per-bundle user-data form. |
| `entity_access_password_user_data_backend_access_global_form` | Global user-data form (`/admin/config/content/entity_access_password/user_data/global`). |
| `entity_access_password_user_data_backend_access_user_form` | A specific user's user-data form (`/user/{user}/password_user_data`). |

Since these forms can grant any user access to protected content, treat them as trusted-admin only.
