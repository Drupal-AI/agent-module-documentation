# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Module dependencies (Composer resolves the contrib ones automatically):
  - core **Views** (`views`)
  - **Entity API** (`entity`)
  - **Entity Link Formatter** (`entity_link_formatter`)
  - **Token** (`token`)
  - **Change Labels** (`change_labels`)

## Install with Composer

Installing with Composer is recommended so the contrib dependencies are pulled in
for you. From the project root:

```bash
composer require drupal/diboo_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/diboo_core -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en diboo_core -y
```

Enabling Diboo core also enables its dependencies (Views, Entity, Entity Link
Formatter, Token, and Change Labels).

## Verify it worked

After enabling, Diboo core's building blocks are available for you to assemble a
game — Rooms, Chains, and Chain links. To scaffold a working setup quickly,
consider the companion **Diboo kickstart** module, and add a drawing tool such as
**Diboo signature pad**. Remember to run cron regularly so locked chains unlock on
schedule.
