# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Drush** — this module is driven entirely through Drush commands and cron.
- No other modules are required, and there are no third‑party Composer or PHP
  library requirements.

> **Release note:** the documented version is a beta (`1.0.0-beta3`). Test it on a
> non-production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_delete_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_delete_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en revision_delete_tools -y
```

## Verify it worked

Confirm the command is registered:

```bash
drush rdt:remove-revisions --help
```

You should see the command's arguments and the `--keep` option. **Do not run it on
real data until you have taken a backup** — deletion is irreversible. See "How to
use it" on the [overview page](../index.md) for the safe sequence (queue, then run
the queue).
