# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- **PHP 8.1 or newer**.
- The **Token** module (`drupal/token`, `^1.0.0-alpha2`) — this is a hard
  dependency, since the name pattern is built from tokens. Composer installs it
  automatically when you require Real Name.

## Install with Composer

From the project root:

```bash
composer require drupal/realname -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/realname -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en realname -y
```

Drupal enables the Token module at the same time as a dependency. Out of the box
the pattern defaults to `[user:account-name]` (the login name), so nothing
visibly changes until you set a real pattern — see
[Configuration](../configuration/index.md).
