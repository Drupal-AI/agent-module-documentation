<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Composer Forced (composer_forced) — agent index

Disables core Update Manager's **install and update forms**. Depends on core `update`.
Core requirement `^8 || ^9 || ^10 || ^11`.

Key facts:
- Whole module: `src/ComposerForced.php` + `composer_forced.module`. No routes, no permissions,
  no config, nothing to set up beyond enabling it.
- **Update availability reporting is unaffected.** `/admin/reports/updates` still lists
  available and security releases; only the actions that write to the filesystem are removed.
  That is the right split — you keep the warnings, you lose the footgun.
- The problem it prevents: a UI-installed module is invisible to `composer.json` /
  `composer.lock`, so the next `composer install` deletes it. The failure surfaces later, on a
  deploy or a fresh clone, far from its cause.
- **It is a guardrail, not a security control.** Anyone with `administer modules` plus file
  access, or shell access, can still change the codebase. Do not present it as hardening.
- Very wide core range for a maintained module; the `.info.yml` still carries the legacy
  `version: '8.x-1.5'` packaging string.
