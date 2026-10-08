# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_modification_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_modification_log -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_modification_log -y
```

## Verify it worked

After enabling, make a change to a piece of content and save it. Then open the
module's modification log report from the administration area — you should see a
new row showing the entity you changed, your user, and a timestamp. If it's there,
the log is recording correctly. See the main guide's
[How to use it](../index.md#how-to-use-it) section for filtering and exporting.

> **Reminder:** the log is a record of who changed what, and exports are a
> concentrated copy of it. Restrict access to both to trusted administrators.
