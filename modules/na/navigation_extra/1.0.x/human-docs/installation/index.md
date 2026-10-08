# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Navigation** module (`navigation`) enabled — this is the new left-sidebar admin
  navigation that Navigation Extra augments. It is the only dependency, and Drupal enables it
  automatically when you turn on Navigation Extra.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/navigation_extra -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_extra -y
```

This also enables core's Navigation module if it wasn't already on. Once enabled, open the
settings page to switch on the sections you want — see
[Configuration](../configuration/index.md).
