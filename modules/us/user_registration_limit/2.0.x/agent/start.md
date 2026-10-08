<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Registration Limit (user_registration_limit) — agent index

Caps total user accounts. Version **2.0.0**. Sets a numeric limit on `user.settings`; blocks the
registration form once reached.

- **Config**: numeric limit added to `/admin/config/people/accounts`; warning message at
  `/admin/config/user-registration-limit` (needs `access administration pages`).
- **Enforcement**: `hook_form_user_register_form_alter` throws `AccessDeniedHttpException` when
  `UserRegistrationLimitHelper::canUserRegister()` is FALSE. `administer users` is exempt.
- **Scope caveat**: only the interactive registration form is guarded. Programmatic / REST /
  JSON:API user creation is NOT limited. Treat as anti-flood UX, not a hard control.
