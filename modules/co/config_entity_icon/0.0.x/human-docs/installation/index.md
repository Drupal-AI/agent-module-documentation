# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`) — this is where the
  core Icon API lives.
- **PHP 8.3+**.
- **UI Icons** (`ui_icons`) — the contributed module that backs the Icon API.
- Core's **System** module (always present).
- **At least one installed icon pack** — for example
  [Lucide](https://www.drupal.org/project/lucide) or
  [Bootstrap Icons](https://www.drupal.org/project/bootstrap_icons). Without a pack
  there are no icons to pick from.

## Install with Composer

From the project root:

```bash
composer require drupal/config_entity_icon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in UI Icons. Add an icon pack too, for example:

```bash
composer require drupal/lucide -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_entity_icon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_entity_icon -y
```

Enable your chosen icon pack as well (for example `drush en lucide -y`).

## Verify it worked

Go to **Configuration → User interface → Config Entity Icon** and confirm the
settings form lists your config entity types. Enable a type there, then edit one of
its entities and check that an **Icon** picker appears (look in the *Additional
settings* tab if the form has one). See
[Configuration](../configuration/index.md) for the details.
