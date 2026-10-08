<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Denied (admin_denied) — agent index

Hardens the Drupal superuser (**uid 1**) by making password login for it impossible: on every
cron run it randomizes uid 1's `name` and stores a random, deliberately-invalid `pass` for it.
No dependencies, no config UI, no permissions, no routes. Core `^9.1 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.1 (version dir `2.x`).

- **How it works, the settings.php prefix, recovery, and operating it** →
  [api/hardening.md](api/hardening.md)

## What it actually is

- One file of procedural code: `admin_denied.module`. No `src/`, no services, no plugins, no
  entities, no config objects, no schema, no Drush commands.
- `admin_denied_cron()` (Implements `hook_cron()`): generates a unique random 16-char username
  (via core `password_generator`, optional `admin_denied_prefix`), then a direct DB `UPDATE` on
  `users_field_data` sets uid 1's `name` and `pass` to random strings. The `pass` value is a raw
  16-char string, not a hash, so `password->check()` can never match → uid 1 password login fails.
  Logs success/failure to the `admin_denied` logger channel.
- `admin_denied_form_system_site_maintenance_mode_alter()` + `_submit()`: adds a submit handler
  that writes a watchdog notice whenever maintenance mode is toggled. (Convenience only.)

## Configuration

- Only tunable is `$settings['admin_denied_prefix']` in `settings.php` (default `''`), prepended
  to the generated uid 1 username. Read via `Settings::get()` — not Drupal config.

## Operating notes

- Effect applies **only after cron runs** (and re-applies each run). Before the first cron run
  after enabling, uid 1 keeps its old credentials.
- Password login for uid 1 is removed — recover with `drush uli`. **Do not use if you cannot run
  Drush.** Ensure a trusted named account has the administrator role before relying on it.
