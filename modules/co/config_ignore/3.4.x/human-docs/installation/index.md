# Installation

## Requirements

Config Ignore runs on **Drupal 8.8 or newer**, including Drupal 9, 10, and 11
(`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`). It has **no other module
dependencies** — it hooks straight into core's configuration import and export
system, so there is nothing extra to install alongside it.

It works with whatever configuration workflow you already use: the built-in
**Configuration synchronization** screens and the `drush config:import` /
`drush config:export` commands.

## Install with Composer

From the project root:

```bash
composer require drupal/config_ignore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any packages it
needs to satisfy the requirement.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_ignore -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_ignore -y
```

Once enabled, an **Ignore** tab appears on the configuration management screens at
**Configuration → Development → Configuration synchronization → Ignore**
(`/admin/config/development/configuration/ignore`).

## Verify it worked

Log in as an administrator and visit
`/admin/config/development/configuration/ignore`. You should see the **Ignore**
tab selected, a **Mode of operation** selector, and a textarea for listing the
configuration you want to protect. If that page loads, the module is installed
correctly. Next, [add your ignore patterns](../configuration/index.md).
