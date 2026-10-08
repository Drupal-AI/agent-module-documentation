<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Legal — agent index

Shows a Terms & Conditions statement on registration (and optionally login / profile edit)
and requires an "Accept" checkbox before an account is created; records acceptance per
version and forces re-acceptance when a new version is published.

- **Admin routes, `legal.settings` keys, display styles, T&C entry, Views** →
  [configure/settings.md](configure/settings.md)
- **T&C storage (entities/tables), versioning, helper functions, adding terms in code, token** →
  [api/terms.md](api/terms.md)

Key facts:
- Configure route `legal.config_legal` → `/admin/config/people/legal` (enter/save T&C).
  Settings form `legal.config_settings` → `/admin/config/people/legal/settings`.
  Permissions: `administer Terms and Conditions`, `view Terms and Conditions`.
- T&C text is **content, not config**: stored in the `legal_conditions` entity/table
  (versioned per language). Acceptances in `legal_accepted`.
- Behaviour config object `legal.settings` (display style, accept-every-login, exempt roles,
  profile display, redirect URL).
- Depends on core `user` + `views`. No Drush commands. Ships a public `/legal` page,
  a `[legal:tc]` token, and two Views (`legal_terms`, `legal_users`).
