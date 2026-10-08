<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Lowercase Username

Route: `lowercase_username.settings` → `/admin/config/user-interface/lowercase_username`
Permission: `administer lowercase username`
Config object: `lowercase_username.settings`

Keys:
- `username.numbers` (bool) — also allow `0-9`.
- `username.dots` (bool) — also allow `.`.
- `username.underscores` (bool) — also allow `_`.
- `username.hyphens` (bool) — also allow `-`.
- `username.description` (string) — help text placed under the account name field.

How validation works (`LowercaseUsernameHooks::validateForm()`):
1. Base allowed class is `a-z`.
2. Each enabled toggle appends its characters to the class.
3. The name is tested with `preg_match('/[^<class>]+/', $name)`; any match => form error `The username contains an illegal character.`

Because it only sets a form error (never rewrites `name`), it cannot silently collide two accounts onto the same lowercase value — a would-be colliding name is rejected outright, and core still enforces unique names. To script config, set the keys above via `drush config:set lowercase_username.settings ...`.