# Installation

## Requirements

Simple Password Reset is self-contained:

- **Drupal 11** (`core_version_requirement: ^11`).
- No third-party Composer packages, no PHP library requirements, and no other
  contrib modules are needed.

It works by overriding Drupal core's `user.reset` route, so no additional setup is
required beyond enabling it.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_pass_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_pass_reset -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_pass_reset -y
```

That's all it takes. The streamlined reset flow is active immediately for every
account. You can optionally set where users land after resetting — see
[Configuration](../configuration/index.md).
