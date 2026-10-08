<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Registration — agent index

Restricts user self-registration by email-domain allowlist/blocklist (with `*`/`?`
wildcards). Adds a validate handler to the user register form. One permission, one admin
form. No Drush, no plugins.

- **Admin settings (method, pattern, message), the matching logic, the service, and the
  permission** → [configure/settings.md](configure/settings.md)

Key facts:
- Configure route `domain_registration.admin_form` at `/admin/config/system/domain_register`
  (permission `administer domain registration`, `restrict access: TRUE`).
- Config `domain_registration.settings`: `method` (0 allow / 1 deny, default 0),
  `pattern` (newline-separated domains, `*`/`?` wildcards), `message`.
- Enforcement is ONLY on the standard user registration form
  (`domain_registration_user_register_validate`); admin/programmatic user creation bypasses it.
- Fragile behavior: pattern list is split on `\r\n` only; config set with `\n` newlines collapses
  into a single unusable pattern.
