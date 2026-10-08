# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.
- A working **outgoing email** setup on your site, since reminders are delivered
  by email.

## Install with Composer

From the project root:

```bash
composer require drupal/content_reminders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_reminders -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_reminders -y
```

## Verify it worked

After enabling, go to **People → Permissions** (`/admin/people/permissions`) and
confirm the Content Reminders permissions appear — grant them to the roles that
should manage reminders. Then set up a reminder on a piece of content and check
that the configured recipient receives the notification email (make sure your
site's outgoing mail is working). See the main guide's
[How to use it](../index.md#how-to-use-it) section for details.
