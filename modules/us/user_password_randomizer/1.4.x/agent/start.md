<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Password Randomizer — agent index

**Security hardening:** prevents **password-based login by user 1** by setting its password to a random
value (neutralizes brute force / leaked uid-1 password). Requires **PHP 8.1**. Config at
`user_password_randomizer.settings`; provides permissions. Version **1.4.0**. Core `^10.2||^11`.

Positive control (superuser protection). **Retain another way to do superuser tasks** (admin role,
`drush uli`) before randomizing uid 1 — don't lock yourself out.
