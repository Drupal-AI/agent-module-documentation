<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shared Email — agent index

Lets one email address be used by more than one user account by replacing core's `UserMailUnique`
constraint with its own `SharedEmailUnique`. Depends on `user`. No Drush.

- **Settings form, config keys (`sharedemail_msg`, `sharedemail_allowed`), allowlist behaviour** →
  [configure/settings.md](configure/settings.md)
- **How the validation constraint & permission-gated bypass work** → [api/mechanism.md](api/mechanism.md)
- **The three permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts: `configure` route `sharedemail.settings_form` → `/admin/config/people/shared-email`; config
object `sharedemail.settings` (`sharedemail_msg`, `sharedemail_allowed`). Uniqueness is only bypassed for
users with `create shared email account` when the address is allowlisted (or the allowlist is empty).
