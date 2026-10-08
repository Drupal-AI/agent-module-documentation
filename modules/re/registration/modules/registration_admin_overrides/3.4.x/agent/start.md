<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Administrative Overrides — agent index

Lets privileged accounts bypass specific registration limits. No settings form and no configure
route. Configuration is **five third-party booleans on each `registration_type`** plus **five
permissions**; an override applies only when the type has it enabled AND the account has the
matching permission.

- **The five overrides, where they are stored, and the checker service** →
  [configure/overrides.md](configure/overrides.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)

Key fact: third-party settings live at `registration.type.<id>` under
`third_party_settings.registration_admin_overrides.{status,maximum_spaces,capacity,open,close}`
(each boolean). Service `registration_admin_overrides.checker`
(`RegistrationOverrideChecker::accountCanOverride($host, $account, $setting, …)`) gates the relaxed
validation via two event subscribers.
