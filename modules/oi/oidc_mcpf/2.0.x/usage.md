<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OIDC My Citizen Profile Flanders provides integration with ACM/IDM, the My Citizen Profile of the Flemish Government, via OpenID Connect.

---

OIDC My Citizen Profile Flanders integrates Drupal authentication with ACM/IDM — the "My Citizen
Profile" identity system of the Flemish Government — via OpenID Connect, so citizens/users can log in with
their Flemish government identity. It depends on the OIDC module and core Telephone, ships an
`oidc_mcpf_user_purge` submodule, includes audience validation (`Audience.php`) and role mapping
(`RoleMapType.php`), and is in the Authentication package.

Use it on Flemish-government-adjacent sites that authenticate against ACM/IDM. It is an external-
authentication integration built on OIDC. Security notes typical of SSO/OIDC: store the OIDC client secret
as a secret, ensure the ID-token **audience** is validated (this module ships audience handling) and the
standard OIDC state/nonce checks (provided by the OIDC layer) are in force, and configure the group/role
mappings carefully (they decide what roles SSO users receive — a permissive mapping over-grants). It has no
content-access role beyond authentication/role-mapping. Configure the ACM/IDM connection and role
mappings.

---

- Log in via Flemish gov ACM/IDM.
- Integrate OpenID Connect SSO.
- Authenticate with My Citizen Profile.
- Depend on the OIDC module and Telephone.
- Validate the ID-token audience.
- Map SSO claims to roles.
- Ship a user-purge submodule.
- Store the OIDC client secret as a secret.
- Rely on OIDC state/nonce checks.
- Configure role mappings carefully.
- Avoid over-permissive role mapping.
- Have no content-access role beyond auth.
- Configure the ACM/IDM connection.
- Handle gov identity login.
- Authenticate citizens.
- Map groups to roles.
- Configure SSO.
- Secure the OIDC flow.
- Log in with gov identity.
- Integrate ACM/IDM.
