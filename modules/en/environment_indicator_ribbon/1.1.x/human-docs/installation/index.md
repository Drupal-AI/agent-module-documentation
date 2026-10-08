# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Environment Indicator** module (`environment_indicator`) — a hard
  dependency. Composer pulls it in automatically with the command below, and Drupal
  enables it when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/environment_indicator_ribbon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Environment Indicator alongside the
ribbon.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/environment_indicator_ribbon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en environment_indicator_ribbon -y
```

Drupal will enable Environment Indicator too if it isn't already on.

## Verify it worked

Configure an environment name and colour in Environment Indicator (see
[Configuration](../configuration/index.md)), then load any page as a user who has
the **`access environment indicator ribbon`** permission. A ribbon showing the
environment name should appear in a corner of the viewport. If you don't see it,
confirm the environment has a name set and that your account has the permission.
