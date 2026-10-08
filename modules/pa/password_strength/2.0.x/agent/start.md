<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# password_strength — agent start

Adds a zxcvbn-based **Password Strength** constraint to the `password_policy` module. One
constraint plugin, `password_strength_constraint`, with a single setting: a minimum
`strength_score` (integer 0–4, default 3). Requires `password_policy` (`^3.1 || ^4.0`) and
the `bjeavons/zxcvbn-php` library. Version 2.0 is a **beta** release. No standalone config
UI for the constraint — you configure it inside a Password Policy.

- Add the strength constraint to a Password Policy (config entity, min score) →
  [configure/password-policy.md](configure/password-policy.md)
- Choose which zxcvbn matchers are active site-wide (settings form) →
  [configure/matcher-settings.md](configure/matcher-settings.md)
- Add a custom `PasswordStrengthMatcher` plugin →
  [plugins/matchers.md](plugins/matchers.md)
- Score a password / read entropy in code →
  [api/strength.md](api/strength.md)
