# Drupal Reset — manual setup guide

> ## ⚠️ Destructive — development use only
>
> **Drupal Reset wipes your site.** It drops all database tables and/or deletes
> the files directory, then redirects to `install.php` for a fresh install.
> **There is no undo and no built‑in backup.** Never enable it on a production,
> staging, or shared host. Anyone who holds its permission — or has CLI access —
> can destroy the entire site in one action. Always take a full database *and*
> files backup before running it, even on a local development machine.

**Drupal Reset** (`drupal_reset`) is a developer tool for repeatedly resetting a
site back to a pre‑install state. Its purpose is testing install profiles and the
installer flow: you reset, reinstall, and try again, as many times as you need.
It gives you three options — reset **everything** (files and database), the
**database** only, or the **files** only — through an admin form, a Drush command,
or a Drupal Console command.

The problem it solves is the tedium of manually tearing a site down between
install‑profile test runs. Rather than dropping tables by hand, you run one action
and Drupal takes you back to `install.php`. It is deliberately gated behind a
dedicated, security‑sensitive permission (`drupal reset`, flagged
"restrict access") so that ordinary site administrators cannot trigger it — only
a role you explicitly trust.

Because the whole module *is* the destructive action, there is no ordinary
"configuration" to set up. What matters is understanding exactly what each option
does and keeping the permission locked down. This guide keeps that front and
centre.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install it (dev environments only),
   enable it, and lock down the permission.

There is **no ordinary settings page**. The module's only interface is the reset
form itself, described under "How to use it" below — treat it as a destructive
action, not a configuration screen.

## Where it lives in the admin menu

Once enabled, the reset form is at **Configuration → Development → Drupal Reset**
(`/admin/config/development/drupal_reset`, route
`drupal_reset.drupal_reset_form`). It is visible only to users with the
`drupal reset` permission.

## How to use it

> Take a backup first. Every option below is irreversible.

**From the admin UI:**

1. Confirm you are on a local/development environment.
2. Go to **Configuration → Development → Drupal Reset**
   (`/admin/config/development/drupal_reset`).
3. Choose one of the three options — **Reset All** (files + database),
   **Reset Databases**, or **Reset Files** — and submit.
4. After a database reset, Drupal redirects you to `/install.php` to reinstall
   from scratch.

**From the command line (Drush):**

```bash
drush site-reset all       # or: files | database   (alias: drush sr)
```

The Drush command prompts for confirmation before it drops or deletes anything.
Pair it with `drush si` for a fast reset‑and‑reinstall loop while testing an
install profile.

## Things to know

- The `drupal reset` permission is marked **restrict access: TRUE** — grant it
  only to a single trusted developer role, and review who holds it on every
  environment where the module is enabled.
- The Drupal Console command drops the database and deletes files **without a
  confirmation prompt**, so treat CLI access as equivalent to full control over
  the site.
- **Domain Access incompatibility:** if you use the Domain Access module, comment
  out its `settings.inc` include line in `settings.php` before running Drupal
  Reset.
- The "Reset Files" option removes files from the site's files directory but does
  not delete Drupal file entities or module/theme files.
