# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drush** — the module is driven entirely from the command line.
- No other modules are strictly required.

### Recommended

- **Webform** — needed only if you want to remove Webform submissions (the
  webform-submissions task).
- **Config Filter** — if you want the module and its sanitised values kept out of
  your exported configuration in local environments.

This release tracks the **1.2.x-dev** branch, so treat it as development software.

## Install with Composer

From the project root:

```bash
composer require drupal/local_data_sanitiser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/local_data_sanitiser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en local_data_sanitiser -y
```

The module is **hidden** from the Extend (modules) UI on purpose — it is a
developer CLI tool, so you enable it with Drush rather than looking for it in the
admin interface.

## Verify it worked

Confirm the command is available:

```bash
drush local-data:sanitise --list-tasks
```

This should list the available sanitiser tasks (webform submissions, user
accounts, content-entity fields). See the
[overview](../index.md#how-to-use-it) for how to run them — and remember the tool
refuses to run outside a detected local environment unless you pass `--force`.

> **Warning:** This tool permanently deletes and anonymises data in place. Only
> run it against a local or otherwise disposable copy of a database, never against
> production.
