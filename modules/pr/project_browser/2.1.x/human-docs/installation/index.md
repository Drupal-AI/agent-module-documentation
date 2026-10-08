# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- PHP's **SimpleXML** extension (`ext-simplexml`) and Composer runtime API
  (`composer-runtime-api ^2`) — both are standard in a normal Drupal environment.
- No required contrib dependencies.
- **Optional but recommended for in‑UI installs:** Drupal core's **Package
  Manager** module. Without it, Project Browser can still browse and show the
  `composer require` command, but cannot install from the UI.

> **Composer conflicts:** Project Browser conflicts with `drupal/automatic_updates`
> below version 4 and `drupal/gin` below 4.0.6. Make sure those are up to date if
> present.

## Install with Composer

From the project root:

```bash
composer require drupal/project_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_browser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_browser -y
```

To use experimental in‑UI installation, also enable core's Package Manager:

```bash
drush en package_manager -y
```

Then go to **Extend → Browse** to start browsing, and to **Configuration →
Development → Project Browser** to configure sources — see
[Configuration](../configuration/index.md).

## Submodule

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Project Browser Source Example** | `project_browser_source_example` | A fixture‑backed example source plugin, useful as a template for developers building their own catalog source. |

## Drush

Project Browser provides a command to clear its stored/cached data:

```bash
drush project-browser:storage-clear   # alias: pb-sc
```
