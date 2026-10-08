# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mail_login -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_login -y
```

Email login is enabled by default the moment the module is on, so users can start
signing in with their email address right away — no configuration required.

## Verify it worked

Log out and go to the login form (`/user/login`). Enter a user's **email address**
and password instead of their username; you should be logged in. To adjust the
behavior (email-only mode, case sensitivity, field labels), see
[Configuration](../configuration/index.md).
