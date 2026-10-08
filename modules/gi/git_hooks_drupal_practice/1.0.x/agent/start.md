<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Git Hooks Drupal Practice (git_hooks_drupal_practice) — agent index
**Writes Git pre-commit/commit-msg hooks that run PHPCS (Acquia strict) + Drupal Rector on staged files.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 (PHP 8.1)
- **Install action:** writes scripts into `.git/hooks` (pre-commit + commit-msg)
- **commit-msg rule:** must start with a ticket number (e.g. `ABC-123:`), ≥10 chars after the colon
- No routes, permissions, services, or config UI.

**Security:** local developer-workflow module operating on `.git/hooks`; no site request-path code, endpoints, or permissions. Intended for dev environments only.
