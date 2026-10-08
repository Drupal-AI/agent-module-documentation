<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password rules

`/admin/config/people/pcv` (`administer site configuration`). Each rule has an enable flag, a value/threshold and a customizable message:

- `character_enable` + `character_limit` — minimum length.
- `lowercase_enable` — require `[a-z]`.
- `uppercase_enable` — require `[A-Z]`.
- `number_enable` — require `[0-9]`.
- `punctuation_enable` — require a non-alphanumeric character.
- `roles_overwrite` — roles that are **exempt** from validation.

Enforcement: `PcvHooks` adds `pcv_validate` to the front of the core `password_confirm` element's `#element_validate` (unless the current user holds an exempt role) and feeds hint text into `drupalSettings.password` for the JS strength meter. Applies anywhere the core password element is used (registration, user edit, admin-created accounts).
