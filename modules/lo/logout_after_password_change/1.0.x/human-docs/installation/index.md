# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/logout_after_password_change -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logout_after_password_change -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logout_after_password_change -y
```

That's all — there is no configuration to do.

## Verify it worked

Log in as a test user, change that user's password (on their `user/{uid}/edit`
page), and save. You should be logged out and sent to the login page, where you
then sign back in with the new password.
