# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Token** module (`drupal/token`, `^1`) — a hard dependency that
  Composer installs for you.

There are no PHP library requirements. To actually *use* the tokens for canonical
URLs you'll typically also have the **Metatag** module, but that's not a
dependency of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/token_url_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_url_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_url_plus -y
```

Drupal enables the Token module as a dependency at the same time.

## Verify it worked

There's no settings page — the new tokens are ready immediately. Open any
token browser (for example the "Browse available tokens" link on a Metatag field)
and look under the **Current page** group for **url-with-query**. See the
[overview page](../index.md#how-to-use-it) for how to use it in a canonical URL.
