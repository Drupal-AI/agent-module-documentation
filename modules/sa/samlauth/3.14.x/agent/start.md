# samlauth — agent start

Makes Drupal a SAML 2.0 **Service Provider**: users authenticate at an external **IdP**, the
`/saml/acs` endpoint validates the response (via `onelogin/php-saml`), and the user is logged
in to Drupal through `externalauth`. Depends on `externalauth:externalauth`. All settings live
in the `samlauth.authentication` config object. Config UI:
**Admin → Config → People → SAML authentication** (`/admin/config/people/saml`); the SP/IdP
certificate + endpoint form is at `/admin/config/people/saml/saml`.

- SP/IdP setup, endpoints, certs, Unique ID, attribute/user mapping, config keys → [configure/samlauth.md](configure/samlauth.md)
- The `/saml/*` routes (login, acs, sls, metadata, reauth, logout, changepw) → [configure/samlauth.md](configure/samlauth.md)
- `SamlService` + reading SAML attributes in code → [api/samlauth.md](api/samlauth.md)
- Events to link accounts / sync attributes / alter the toolkit config → [extend/samlauth.md](extend/samlauth.md)
- Permissions → [permissions/samlauth.md](permissions/samlauth.md)
- Submodules: [samlauth_user_fields](../../modules/samlauth_user_fields/3.14.x/agent/start.md) · [samlauth_user_roles](../../modules/samlauth_user_roles/3.14.x/agent/start.md)
