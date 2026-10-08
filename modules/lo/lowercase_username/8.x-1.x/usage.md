<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lowercase Username enforces a lowercase-only username policy by adding a validation handler to the user account form that rejects any character outside an allowed set.
---
The module alters every user form (registration and edit) through `LowercaseUsernameHooks::formUserFormAlter()` and appends a `validateForm()` callback. That callback builds a character class starting with `a-z` and optionally adds digits, dots, underscores, and hyphens based on `lowercase_username.settings` (`username.numbers`, `username.dots`, `username.underscores`, `username.hyphens`). If the submitted name contains any character outside that class — including uppercase letters — validation fails with "The username contains an illegal character." A configurable help description (`username.description`) is shown under the name field.

Security note: the module **validates and rejects** rather than silently transforming the name, so it does not rename existing accounts and cannot merge two different accounts into one lowercase identity — there is no username-collision or account-takeover vector introduced here (core's existing case-insensitive uniqueness check is untouched). The settings form lives at `/admin/config/user-interface/lowercase_username` behind the `administer lowercase username` permission. Typical setup: enable the module, decide which extra characters (numbers/dots/underscores/hyphens) to permit, and save.
---
- Force new usernames to lowercase letters at registration.
- Allow digits in usernames via the settings toggle.
- Allow dots in usernames (e.g. `first.last`).
- Allow underscores in usernames.
- Allow hyphens in usernames.
- Reject uppercase or special characters on the user edit form too.
- Customise the help text shown under the username field (`username.description`).
- Standardise account names for consistent lookups and URLs.
- Grant `administer lowercase username` only to trusted admins.
- Apply the policy site-wide without writing custom validators.
- Keep the policy in config so it can be exported/deployed.
- Combine with core's unique-username check (unchanged) for clean identities.
- Avoid confusion between `JohnDoe` and `johndoe` by disallowing uppercase.
- Loosen or tighten the allowed character set later by editing config.
- Disable the module to remove the extra validation constraint.