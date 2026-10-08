<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Resets a Drupal site to a pre-install state by deleting the files directory and/or dropping all database tables.
- Offers a UI form, a Drush command (`drush site-reset` / `sr`), and a Drupal Console command.
- After a database reset it redirects to `/install.php` so the site can be reinstalled from scratch.

---

## Install & configure

- Enable the module ONLY on local/development environments — never on production.
- Use the form at `/admin/config/development/drupal_reset` (route `drupal_reset.drupal_reset_form`), gated by the dedicated `drupal reset` permission (marked `restrict access: TRUE`).
- Or run `drush site-reset [all|files|database]` from the CLI (prompts for confirmation).

---

## Usage & behaviour

- The `drupal reset` permission is declared `restrict access: TRUE`, so it is flagged as security-sensitive and should be granted to no one but a trusted developer role.
- The web form gates entirely on that dedicated permission (not just `administer site configuration`), so casual site admins cannot trigger it.
- Options: delete all (files + database), database only, or files only.
- The Drush command requires interactive confirmation (`drush_confirm`) before dropping/deleting.
- `DropDatabase::validateIsSupported()` refuses to run on unsupported setups (multiple DBs, array table prefix), reducing accidental partial wipes.
- Database reset issues a redirect to `/install.php` to begin reinstallation.
- This is inherently a destructive operation — there is no undo and no built-in backup step.
- Take a database and files backup before ever running it, even on dev.
- The Drupal Console command (`DrupalResetCommand`) drops the DB and deletes files with no confirmation, so treat CLI access as equivalent to root on the site.
- Do NOT enable this module on shared or production hosts; a leaked account with the permission equals full site destruction.
- No anonymous or `_access: TRUE` route exists; the form is permission-gated and CLI commands require shell access.
- Useful for repeatedly re-testing the install profile / installer flow.
- Pair with a scripted reinstall (`drush si`) for a fast dev reset loop.
- Files deletion targets the site's files directory as resolved by the service.
- Logging is written to the `drupal_reset` channel for each step.
- Because of its blast radius, review who holds the `drupal reset` permission on every environment where it is enabled.
