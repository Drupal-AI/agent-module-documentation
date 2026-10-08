<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SAML Rules (saml_rules) — agent index

**Applies admin-defined rules on SAML login to add roles, set email, and map SAML attributes into user fields.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** samlauth
- **Permissions:** `administer saml rules`
- **Routes:** all under `/admin/config/people/saml-rules/*` (authentication rules + user-field rules matrices, add/edit/delete forms, settings) — every route `administer saml rules`
- **Logic:** `hook_user_login()` in `saml_rules.module` reads the SAML response and applies `saml_rules.authentication_rules` / `saml_rules.user_field_rules`
- **Services:** route subscriber; `SAMLRulesAnonymousLogin` request subscriber (optional force-login)

See [configure/rules.md](configure/rules.md)
