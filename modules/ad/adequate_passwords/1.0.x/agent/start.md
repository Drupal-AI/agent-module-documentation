<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adequate Passwords (adequate_passwords) — agent index

**Enforces a minimum password strength matching Drupal core's strength indicator**, turning core's advisory meter into a hard requirement.

- **Version:** 1.0.x
- **Core:** `^8.8.0 || ^9 || ^10 || ^11`  · package Security
- **Route:** `adequate_passwords.admin_settings` (`/admin/config/people/adequate_passwords`, permission `administer site configuration`).
- **Enforcement:** `hook_element_info_alter()` → `#after_build` on `password_confirm` → `adequate_passwords_validate` unshifted to the front of the validation chain; scores via `adequate_passwords_evaluate_password_strength()`.
- **Config:** `adequate_passwords.settings` (`strength`, `roles`, `enable_adequate_message`).

**Security:** admin route gated by `administer site configuration`; the module is strictly additive — it only ever *adds* a `setErrorByName('pass1')` when strength is below threshold and never weakens or bypasses core auth. It skips the CLI-install random password so installs don't break. Confirmed a strengthening module, not a weakening one. No security findings.

See [configure/policy.md](configure/policy.md)
