# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules — it has no contrib dependencies. It builds on core's user
  login form and authentication.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_login_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ajax_login_popup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_login_popup -y
```

The login form is now available in a modal for anonymous visitors. Next, set
where users are redirected after login — see
[Configuration](../configuration/index.md).
