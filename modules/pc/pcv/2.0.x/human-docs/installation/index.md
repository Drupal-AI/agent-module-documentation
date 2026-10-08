# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No third-party Composer libraries and no extra modules — it builds on the core
  password element.

## Install with Composer

From the project root:

```bash
composer require drupal/pcv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pcv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pcv -y
```

## Verify it worked

Log in as an administrator and go to **`/admin/config/people/pcv`**. You should see
the password rules form. Turn on a rule or two (see
[Configuration](../configuration/index.md)), save, then try setting a weak password
on a user account — the form should refuse it with your configured message.
