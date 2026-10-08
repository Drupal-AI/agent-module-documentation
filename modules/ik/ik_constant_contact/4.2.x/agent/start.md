# Constant Contact Module (ik_constant_contact) — agent index

Integrates Constant Contact API v3: OAuth2 auth, enable lists, and submit contacts via blocks,
a webform handler, an entity field type, or a REST endpoint. All API work goes through the
`ik_constant_contact` service. Config UI: `ik_constant_contact.config`
(`/admin/config/services/ik-constant-contact`). One permission: `administer constant contact
configuration` (`restrict access: true`).

- **Credentials (settings.php vs config), OAuth authorize + callback, enabling lists, token
  storage, cron** → [configure/setup.md](configure/setup.md)
- **Signup blocks, the `constant_contact_lists` field type / subscribe-on-save, the webform
  handler** → [configure/integrations.md](configure/integrations.md)
- **The `ik_constant_contact` service: public methods and contact-data shape** →
  [api/service.md](api/service.md)
- **The optional REST endpoint `POST /constant_contact/{list_id}`** → [api/rest.md](api/rest.md)
- **Alter hooks to modify the payload sent to Constant Contact** → [hooks/data-alter.md](hooks/data-alter.md)

Key facts:
- Requires (not enforced in info.yml — a `depencencies` typo): `block` (blocks), `rest`
  (endpoint), `webform` (handler), `datetime` (date custom fields).
- Config objects: `ik_constant_contact.config` (client_id/secret/auth_type),
  `ik_constant_contact.enabled_lists`, `ik_constant_contact.tokens` (legacy), `ik_constant_contact.pkce`.
- Tokens live in DB table `ik_constant_contact_tokens` (access_token, refresh_token, expires_in,
  timestamp); refreshed before each call and on `hook_cron`.
- Credentials are admin-entered (settings.php preferred) — no shipped secrets.
