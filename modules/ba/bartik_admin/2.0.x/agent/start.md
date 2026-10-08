<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bartik Admin - agent index

**Bartik Admin** provides a Bartik-based admin theme with a per-user opt-in. Version **2.0.1** (`2.0.x`). Core `^8 || ^9 || ^10`.

## Key files
- `src/Theme/ThemeBartik.php` - theme negotiator.
- `src/Form/BartikAdmin.php` - per-user form + `checkAccess()`.

## Routes
- `/user/{user}/bartik-admin` requires role `administrator` + custom access. No anonymous exposure.