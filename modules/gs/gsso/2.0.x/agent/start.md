<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group SSO (gsso) — agent index

**Maps SSO/SAML IdP claims to Drupal roles, Group memberships and group roles on login.**

- **Version:** 2.0.x
- **Core:** `^8 || ^9 || ^10 || ^11`  •  **Depends:** group
- **Config route:** `gsso.settings` → `/admin/group/sso` (permission `administer group`)
- **Services:** `gsso.gsso` (claim storage + membership sync), `plugin.manager.sso_types`
- **Entry point:** `hook_simplesamlphp_auth_user_attributes()` in `gsso.module` — runs inside SimpleSAMLphp's verified login; not a standalone callback.
- **Storage:** custom `gsso_claims` table (uid → claims string).

**Security:** No login endpoint of its own — it hooks the already-authenticated SimpleSAMLphp attribute flow, so SAML assertion verification / state / CSRF are handled upstream by SimpleSAMLphp, not here. The only route is the `administer group`-gated settings form. Note: a login fully re-derives authorization (strips then re-adds all roles/memberships), so mapping config is the sole source of truth.

See [configure/gsso.md](configure/gsso.md).
