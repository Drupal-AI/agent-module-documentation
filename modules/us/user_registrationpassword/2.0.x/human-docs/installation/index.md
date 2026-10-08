# Installation

## Requirements

- **Drupal 10.1 or newer, or Drupal 11** (`core_version_requirement: ^10.1 ||
  ^11`).
- Core's **User** module (`user`), which is always present.

There are no third-party libraries. One optional module is worth knowing about:

- **Registration Password Tokens** (`drupal/rpt`) — adds a `[user:password]`
  token so you can include the chosen password in the welcome email.

## Install with Composer

From the project root:

```bash
composer require drupal/user_registrationpassword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/user_registrationpassword -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en user_registrationpassword -y
```

On install the module sets the "verify with password on the form" mode as the
default. To review or change how registration behaves, go to
[Configuration](../configuration/index.md).

This module has no submodules.
