# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **User** module (`user`), enabled on every standard Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/lowercase_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lowercase_username -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lowercase_username -y
```

The lowercase policy is active immediately, allowing only `a–z` until you enable
extra characters in the settings — see [Configuration](../configuration/index.md).

## Verify it worked

Go to the registration form (or edit a user) and try to save a username
containing an uppercase letter, such as `TestUser`. You should get the error
*"The username contains an illegal character."* A lowercase name like `testuser`
should save normally.
