# samlauth_user_fields — agent start

samlauth submodule that maps SAML attributes to Drupal **user fields** (and can link existing
users by field value). Pure event subscriber to samlauth's `USER_SYNC` / `USER_LINK`. Requires
`samlauth`. Config UI: **`/admin/config/people/saml/user-fields`** (permission `configure saml`);
all data in the `samlauth_user_fields.mappings` config object.

- Set up attribute→field mappings & linking behavior → [configure/samlauth_user_fields.md](configure/samlauth_user_fields.md)

Parent module: [samlauth](../../../../3.14.x/agent/start.md). Event mechanics: [samlauth extend](../../../../3.14.x/agent/extend/samlauth.md).
