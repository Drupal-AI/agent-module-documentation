# Installation

## Requirements

- **Drupal 10.3 or newer, Drupal 11, or Drupal 12**
  (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **File** module (`file`) enabled — Drupal enables it automatically as a
  dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_delete -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_delete -y
```

Once enabled, File Delete takes over the file delete form site-wide immediately.

## Grant the permissions

The safe default (mark temporary, let cron clean up) is available to anyone who
can delete files. Two extra permissions unlock the more powerful behavior — grant
them only to trusted roles at **People → Permissions**
(`/admin/people/permissions`):

- **Delete files immediately** — skip the temporary/cron step and remove the file
  right away.
- **Delete files override usage** — delete a file even when it still has usage
  records, accepting that links or media may break.

There are no submodules.
