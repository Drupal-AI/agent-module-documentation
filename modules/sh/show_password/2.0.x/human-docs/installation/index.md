# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).

There are no other module dependencies and no third-party PHP library requirements.
The module adds no permissions and no routes.

## Install with Composer

From the project root:

```bash
composer require drupal/show_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/show_password -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en show_password -y
```

## Verify it worked

Log out and open the login form at `/user/login`. You should see a **Show Password**
checkbox next to the password field; ticking it reveals the characters you are
typing, and unticking it hides them again. There is no configuration to do.
