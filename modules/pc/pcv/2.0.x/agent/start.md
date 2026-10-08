<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Core Validator (pcv) — agent index

**Enforces configurable password-strength rules on the core `password_confirm` element for selected roles.**

- **Version:** 2.0.x (2.0.0)
- **Core:** ^10.1 || ^11 || ^12
- **Configure:** `/admin/config/people/pcv` (`administer site configuration`)
- **Mechanism:** `PcvHooks` (OOP hooks) alters `password_confirm` via `element_info_alter`, adds after-build + `pcv_validate`; checks length/lowercase/uppercase/number/punctuation; feeds hints to `drupalSettings.password`.
- **Exemption:** roles listed in config `roles_overwrite` skip validation.

**Security:** Config route is `administer site configuration`; no anonymous or mutating endpoints. Rules run in the validation pipeline of the core password element. Note: strength enforcement is skipped for exempted roles by design. (Minor: `PcvHooks` file uses namespace `Drupal\mobile_number_login\Hook` and references `FormattableMarkup` without import — code-quality, not a security issue.) See [configure/rules.md](configure/rules.md)
