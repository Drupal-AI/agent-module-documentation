# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **Drush 10, 11, 12, or 13** — this module *is* a set of Drush commands, so a
  working Drush is essential.
- Shell access to the server (or DDEV container) where the site's files live, with
  enough privilege to change file ownership.

There are no other module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/file_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_permissions -y
```

## Run the command

The whole point of the module is the `drush fp` command:

```bash
drush fp
```

Useful options:

- `--user=<name> --group=<name>` — set the web server user/group manually if
  auto-detection fails.
- `--dry-run` — show what would change without applying anything.

A root user is generally required (the command may prompt for `sudo`), but do not
reach for `sudo` reflexively — running as root can leave files owned by `root`.

## Verify it worked

After running `drush fp`, check Drupal's status report at **Reports → Status
report** (`/admin/reports/status`). The warnings about the `files` or `private`
directories not being writable should be gone, and both directories should exist
with their `.htaccess` files in place.
