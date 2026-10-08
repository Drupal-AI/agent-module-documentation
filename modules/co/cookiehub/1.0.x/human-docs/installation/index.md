# Installation

## Requirements

- **Drupal 8.9+, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- A **CookieHub account** — register at cookiehub.com and add your domain in the
  CookieHub dashboard to get your 8‑digit code. (The cookie‑declaration field
  requires a CookieHub premium subscription to work.)

Cookiehub has no Drupal module dependencies and no third‑party PHP/JavaScript
library requirements — the consent script loads at runtime from CookieHub's servers.

## Install with Composer

From the project root:

```bash
composer require drupal/cookiehub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookiehub -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiehub -y
```

Enabling alone does not attach the banner — you must enter your CookieHub code and
tick the enable box.

## Verify it worked

After configuring (see [Configuration](../configuration/index.md)), load any page
that is not on your exclusion list and inspect the HTML `<head>`. You should see the
CookieHub loader script (from `cookiehub.net/c2/<id>.js`, or `dash.cookiehub.com/dev/<id>.js`
in dev mode) and the consent banner appearing on the front end.
