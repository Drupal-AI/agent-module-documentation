# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other modules are required, and there are no third-party PHP or JavaScript
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_password_reveal -W
```

The Composer package name (`drupal/simple_password_reveal`) matches the module's
machine name (`simple_password_reveal`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_password_reveal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_password_reveal -y
```

That's all it takes — there is no configuration. The toggle appears on the user
login and user edit forms immediately.

## Verify it worked

Log out and visit the user login page (`/user/login`), or as a logged-in user open
your account edit page (`/user/*/edit`). The password field should display in plain
text with a checkbox to conceal it. Remember that this plaintext-by-default
behaviour is intentional — read the [main guide](../index.md) for the
shoulder-surfing caveat before using it on higher-risk sites.
