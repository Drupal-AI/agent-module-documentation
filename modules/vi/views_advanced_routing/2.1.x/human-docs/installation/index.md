# Installation

## Requirements

- **Drupal 10.1 or newer** (`core_version_requirement: >=10.1`), including
  Drupal 11.
- Core's **Views** module (`views`) enabled — this is the only dependency, and it
  is part of standard Drupal. You'll also want the **Views UI** module on to
  configure things through the admin screens.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_advanced_routing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_advanced_routing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_advanced_routing -y
```

There are no submodules. Enabling the module makes the display extender
*available*, but you still have to switch it on in the Views settings and then
configure it per display — see [Configuration](../configuration/index.md).
