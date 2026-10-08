# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies and no third-party PHP libraries — it works with core's
  User and Field UI, which any standard site has.

## Install with Composer

From the project root:

```bash
composer require drupal/show_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/show_email -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en show_email -y
```

## Next steps

Enabling the module makes the user **Email** field display-configurable. To actually
show it, go to the user *Manage display* screen, enable the Email field and pick the
**Show email address** formatter — see [Configuration](../configuration/index.md).
