# samlauth_user_roles — agent start

samlauth submodule that assigns/revokes Drupal **roles** on SAML login from a SAML attribute or
group claim. Pure event subscriber to samlauth's `USER_SYNC`. Requires `samlauth`. Config UI:
**`/admin/config/people/saml/user-roles`** (permission `configure saml`); data in the
`samlauth_user_roles.mapping` config object.

- Set up attribute→role mapping, defaults, unassign & first-login behavior → [configure/samlauth_user_roles.md](configure/samlauth_user_roles.md)

Parent module: [samlauth](../../../../3.14.x/agent/start.md). Event mechanics: [samlauth extend](../../../../3.14.x/agent/extend/samlauth.md).
