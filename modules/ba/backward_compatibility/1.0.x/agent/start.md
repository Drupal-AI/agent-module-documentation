<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backward Compatibility (backward_compatibility) — agent index

Turns off Drupal's core-compatibility gate so a module whose `core_version_requirement`
excludes the running core can still be installed and enabled. It restores **no** APIs.

- **Version:** 1.0.2 (2023), package `Custom`, declares `^9 || ^10 || ^11`.
- **Provides:** no permissions, no routes, no services, no config, no Drush commands, no plugin types.
- **Dependencies:** none. **Requires:** PHP/core per Drupal 9/10/11.

## What it actually does (the whole module is ~40 lines)

Two hooks in `backward_compatibility.module` plus one in `.install`:

1. **`backward_compatibility_system_info_alter(&$info, Extension $file, $type)`** sets
   `$info['core_incompatible'] = FALSE;` — **unconditionally, for every extension** Drupal
   inspects. This suppresses the "incompatible with this version of Drupal" block on the
   module-install screen. There is no per-module check; the flag is cleared for all of them.
2. **`backward_compatibility_install()`** calls `module_set_weight('backward_compatibility', -1000)`
   so the alter runs before other modules' info alters. (Verified on-site: weight is `-1000` in
   `core.extension`.)
3. **`backward_compatibility_help()`** adds a one-paragraph help page at
   `help.page.backward_compatibility`. That is the entire module.

## Critical correction vs. the module name

It is **not** a compatibility/polyfill layer. It defines no functions, no `class_alias`, no
`.services.yml`, no shims. If an enabled module calls a function or service that core genuinely
removed, it will still **fatal at runtime** — this module only removes the *install-time* refusal.
The maintainer says so directly: "This module does not fix old Drupal modules with deprecated code."

## Solution docs

- **Install, mechanism, and the honest test workflow** → [operate/mechanism.md](operate/mechanism.md)

## Files

- `data.json` — metadata (categories from the canonical taxonomy).
- `usage.md` — short / dense / use-case bullets.
- No config/routes/permissions/services/CLI surface exists; the one solution page covers all of it.
