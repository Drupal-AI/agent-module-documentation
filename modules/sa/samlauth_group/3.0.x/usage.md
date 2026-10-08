<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
samlauth_group maps SAML attributes to group memberships and roles.

---

samlauth_group extends the SAML Authentication (samlauth) module to map **SAML attributes to Drupal group
memberships and roles** — so, on SAML SSO login, a user's group/role attributes from the identity provider
(IdP) are used to sync their Drupal Group memberships and role assignments. It depends on the samlauth
module, in the User Authentication package.

Use it to provision group memberships/roles from SAML. This is a standard SAML provisioning feature.
Security-critical points: because it **grants group memberships and roles based on IdP-supplied attributes**,
the whole trust rests on the **SAML assertion being genuine — samlauth core must be configured to validate
the IdP's assertion signature** (so the attributes can't be forged); trust only a **trusted IdP**; and
configure the attribute→membership/role **mappings carefully** — a mapping to a privileged role grants that
privilege to anyone the IdP places in that group (over-permissive mapping = privilege escalation). Review the
mappings and prefer least privilege. It has no other access-control role. Configure the mappings.

---

- Map SAML attributes to groups and roles.
- Provision memberships/roles from the IdP on login.
- Sync Group memberships from SAML.
- Depend on the samlauth module.
- Assign roles from SAML group attributes.
- Rely on samlauth validating the assertion signature.
- Trust only a trusted IdP.
- Configure attribute->membership/role mappings carefully.
- Avoid over-permissive role mappings (privilege escalation).
- Prefer least privilege in mappings.
- Review the mappings.
- Have no other access-control role.
- Configure the mappings.
- Handle SAML provisioning.
- Map attributes to roles.
- Sync roles from SAML.
- Handle group mapping.
- Configure SAML groups.
- Provision from SAML.
- Map SAML groups.
