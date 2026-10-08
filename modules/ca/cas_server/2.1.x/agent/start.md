# CAS Server — agent index

Drupal as a CAS identity provider: apps ("services") delegate login to Drupal, which issues/validates
CAS tickets. Configure at `/admin/config/people/cas_server` (route `cas_server.settings`). Requires
HTTPS. Do NOT enable with the CAS *client* module. Depends only on core `user`. One submodule:
`cass_attributes` (attribute-alter demo, nested docs).

- **Global settings + Service definitions (URL patterns, SSO, attributes, per-service roles)** →
  [configure/services.md](configure/services.md)
- **Protocol endpoints (`/cas/login|logout|validate|serviceValidate|proxy…`), ticket types, and the
  two alter events** → [api/protocol.md](api/protocol.md)
- **Permissions (static + dynamic per-service)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Service definitions are `cas_server_service` config entities (`config_prefix: cas_server_service`),
  admin permission `administer site configuration`. Matching: `CasServerService::matches()` converts the
  stored pattern (with `*`) to a regex against the parsed service URL path.
- All tickets are `Crypt::randomBytesBase64(32)` (256-bit) in table `cas_server_ticket_store`; purged by
  `cas_server_cron()`. Timeouts configurable in `cas_server.settings`.
- No Drush. Provides config schema. Login form is `\Drupal\cas_server\Form\UserLogin` (single-use login ticket).
