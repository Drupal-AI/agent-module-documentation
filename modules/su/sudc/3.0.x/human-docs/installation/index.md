# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1** or newer.
- The **`firebase/php-jwt`** library (`^6.10`), used to sign the per-user JWT — it
  is pulled in automatically by Composer, so there is nothing to install by hand as
  long as you require the module with Composer.
- A **SearchUnify account** with the CDN, provision key, endpoint, and UID /
  Search-URL details you will enter during configuration.
- No Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/sudc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `firebase/php-jwt`
and any shared dependencies. Installing with Composer (rather than downloading the
module by hand) is important here, so the JWT library is present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sudc -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sudc -y
```

## Verify it worked

Log in as an administrator and open the settings page at `/admin/config/sudc`
(*Administer site configuration*). You should reach the SearchUnify configuration
form; there is also a help page at `/admin/config/sudc/help`. Continue with
[Configuration](../configuration/index.md).
