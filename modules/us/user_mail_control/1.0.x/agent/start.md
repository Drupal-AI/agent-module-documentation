<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Mail Control - agent index

Makes the **user email field optional** by overriding core `UserMailRequired`. Version **1.0.2**, core `^8.8 || ^9 || ^10`. Depends on `user`.

- Constraint `UserMailRequiredDisabled` + `UserMailRequiredDisabledValidator` (no-op on empty) replaces core mail-required validation.
- Config `user_mail_control.settings`: `user_form`, `user_register_form`, `mail_domain`, `automatic`.
- No routes/permissions in this build; configured via the config object.