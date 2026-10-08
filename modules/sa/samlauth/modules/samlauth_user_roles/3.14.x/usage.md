A samlauth submodule that assigns (and optionally revokes) Drupal roles when a user logs in via SAML, based on the values of a SAML attribute or group claim sent by the IdP.

---

`samlauth_user_roles` subscribes to samlauth's `USER_SYNC` event and adjusts a user's roles from the SAML response. It reads a configured `saml_attribute` (e.g. a `groups`, `memberOf` or `role` claim), optionally splitting multi-valued strings on a `saml_attribute_separator`, and maps each incoming value to a Drupal role via a `value_map` (`attribute_value` → `role_machine_name`). Beyond the value map it can grant `default_roles` to every SAML user and remove `unassign_roles` first, so role membership stays in sync with the IdP on each login. The `only_first_login` option limits changes to the user's first SAML login (leaving later manual role edits intact), and `log_unknown` logs attribute values or mapped roles that don't resolve to a real role. Configuration lives in the `samlauth_user_roles.mapping` config object and is edited at **Admin → Config → People → SAML → SAML user roles** (`/admin/config/people/saml/user-roles`), gated by the parent module's `configure saml` permission. It requires the `samlauth` module.

---

- Grant a Drupal role to users who belong to a specific IdP group (e.g. `staff` → `editor`).
- Map an Azure AD / Entra `groups` claim to Drupal roles automatically on login.
- Map an LDAP-style `memberOf` attribute to roles via the value map.
- Split a delimited multi-value attribute (e.g. `a;b;c`) into several role assignments.
- Assign one or more `default_roles` to every user who logs in through SAML.
- Remove `unassign_roles` before applying mapped roles so stale roles are cleared.
- Keep Drupal role membership continuously in sync with the IdP on every login.
- Grant an `administrator` role only to members of an IdP admin group.
- Restrict role changes to the user's first SAML login via `only_first_login`.
- Preserve manually-assigned roles by only acting on first login.
- Log unmapped/unknown attribute values or roles via `log_unknown` for debugging.
- Provision new SAML-created accounts with the right roles immediately.
- Centralise authorization in the IdP and reflect it as Drupal roles.
- Deploy the role-mapping configuration between environments as config.
- Map several IdP group values to the same Drupal role.
- Combine default roles plus attribute-based roles in one login flow.
- Extend samlauth without writing a custom USER_SYNC subscriber for roles.
