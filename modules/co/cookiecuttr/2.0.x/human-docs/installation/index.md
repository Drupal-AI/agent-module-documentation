# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **JS Cookie** module (`js_cookie`) — CookieCuttr depends on it to store the
  visitor's consent choice, and Composer/Drupal will bring it in as a dependency.

There are no additional third‑party PHP library requirements (the CookieCuttr jQuery
plugin ships as a library used by the module).

## Install with Composer

From the project root:

```bash
composer require drupal/cookiecuttr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `js_cookie` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookiecuttr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiecuttr -y
```

This also enables **JS Cookie** (`js_cookie`) if it is not already on.

## Verify it worked

Go to **Configuration → User interface → CookieCuttr**
(`/admin/config/user-interface/cookiecuttr`). If you can open the settings form, the
module is installed. Enter your notice text and policy link (see
[Configuration](../configuration/index.md)), then load the front end as a visitor —
the cookie‑consent notice should appear.
