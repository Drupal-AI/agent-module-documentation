# Permissions

Defined in `cas_server.permissions.yml` + dynamic callback `CasServerPermissions::servicePermissions`.

| Permission | Type | Gates |
|---|---|---|
| `cas server login to any service` | static | Holder may authenticate to **every** registered service (checked first in `accountPermitted()`). |
| `cas server login to {service_id} service` | dynamic (one per service) | Holder may authenticate to that specific service. |
| `administer site configuration` | core | All admin routes: global settings and Service definition add/edit/delete (also the `cas_server_service` entity `admin_permission`). |

Notes:
- The per-service dynamic permissions are generated for each `cas_server_service` entity. They can be set
  on the standard *People → Permissions* page, or via the Service edit form's "Roles to authenticate with
  this service" checkboxes (which call `user_role_grant/revoke_permissions`) — that section only appears
  to users who also hold `administer permissions`.
- Admin roles (`is_admin = true`) are always treated as permitted. **Anonymous** is force-disabled for all
  CAS login permissions (`cas_server_form_alter` disables the anonymous checkboxes) — anonymous can reach
  `/cas/login` to authenticate, but cannot hold a "login to service" grant.
- None of these are `restrict access: true`; treat `cas server login to any service` as sensitive (it
  grants access to all delegated apps).
