# Configuring CAS Server

Two things to configure: **global settings** (`cas_server.settings`) and one-or-more **Service
definitions** (`cas_server_service` config entities). At least one Service definition is required for the
server to do anything. All admin routes require `administer site configuration`.

## Global settings — `cas_server.settings`
Form `\Drupal\cas_server\Form\CasServerSettings` at `/admin/config/people/cas_server/settings`.
Keys (defaults from `config/install/cas_server.settings.yml`):

- `ticket.login_ticket_timeout` (900), `ticket.service_ticket_timeout` (10),
  `ticket.proxy_ticket_timeout` (10), `ticket.proxy_granting_ticket_timeout` (7200),
  `ticket.ticket_granting_ticket_timeout` (28800) — lifetimes in seconds.
- `ticket.ticket_granting_ticket_auth` (false) — when true, issue a `cas_tgc` ticket-granting **cookie**
  so SSO works across services; when false, SSO relies on the Drupal session (any authenticated user).
- `ticket.ticket_username_attribute` (`name`) — which attribute is sent as the CAS `user`: `name`,
  `mail`, or `uid`.
- `messages.invalid_service` / `messages.not_permitted` / `messages.user_logout` / `messages.logged_in`
  — override the default text on those pages (validated by the `CasUserMessage` constraint).
- `debugging.log` (false) — enable the `DebugLogger` ticket-flow log.
- `login.username_attribute` (`name`) — credential field accepted at login: `name`, `mail`, or `both`.
- `login.reset_password` (false) — show a "Reset your password" link on the CAS login form.

Set via Drush: `drush config:set cas_server.settings login.reset_password true`.

## Service definitions — `cas_server_service` entities
List/add/edit/delete under `/admin/config/people/cas_server/services` (form
`\Drupal\cas_server\Form\ServicesForm`). Exported keys: `id`, `label`, `service`, `sso`, `attributes`.

- **`service`** — the URL pattern an incoming `service=` URL must match. `*` is a wildcard. Matching
  (`CasServerService::matches()`): the pattern is `preg_quote`d then `\*` → `.*`, anchored `^…$`, and
  tested against the parsed service URL's path component (for external URLs that includes scheme+host+path).
  A too-broad pattern (e.g. `https://*`) therefore allows any host — keep patterns tight. Constraint
  `CasServicePattern` rejects patterns that don't compile.
- **`sso`** — if enabled, a login to this service starts an SSO session (issues the TGC when TGC auth is
  on); if disabled, it authenticates for that one request only. Proxy issuance requires the target
  service be SSO-enabled.
- **`attributes`** — a list of **user entity field names** released to the service on successful
  validation (validated against real user fields by `ConfigHelper::validateAttributesConfig`).
- **Per-service role restriction** — the add/edit form (only for users who also hold `administer
  permissions`) exposes "Roles to authenticate with this service"; saving grants/revokes the dynamic
  permission `cas server login to {id} service` on those roles via `user_role_(grant|revoke)_permissions`.
  Admin roles (`is_admin`) and holders of `cas server login to any service` are always allowed; anonymous
  is force-disabled.

Access decision at login: `CasServerService::accountPermitted()` returns TRUE if the account has
`cas server login to any service` or `cas server login to {id} service`. See
[permissions/permissions.md](../permissions/permissions.md).
