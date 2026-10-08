# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- A working **AWStats** installation on the server, already generating reports
  for your site's domain. BAWstats only displays AWStats output — it does not
  analyze logs itself.

There are no Composer library or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bawstats -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bawstats -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bawstats -y
```

After enabling, grant the **view site statistics** and **statistics admin**
permissions under **People → Permissions** to the appropriate roles, then point
the module at your AWStats data as described in the
[overview](../index.md#how-to-use-it).
