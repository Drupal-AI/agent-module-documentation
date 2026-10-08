# Installation

## Requirements

Mail Debugger is deliberately lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, no third‑party Composer packages, and no PHP library
  requirements.

It is declared a **development** package, so it will appear under the
"Development" heading on the Extend page.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_debugger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_debugger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_debugger -y
```

## Grant the permission

Both forms are controlled by a single permission, **`access mail_debugger`**.
Give it only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`). Note that this permission is not marked
"restricted" in the UI even though it lets the holder send mail from your site's
own identity — so assign it deliberately. See the safety note in the
[overview](../index.md#a-safety-note--keep-this-on-development-sites-only).

## Verify it worked

Log in as a user with the permission and visit
`/admin/config/development/mail_debugger`. You should see the test-email form.
Send yourself a message and confirm it arrives — if it does, your site's mail
transport is working.
