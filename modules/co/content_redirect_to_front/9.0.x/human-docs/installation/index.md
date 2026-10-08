# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies beyond Drupal core, and no third‑party Composer or PHP
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_redirect_to_front -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_redirect_to_front -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_redirect_to_front -y
```

## Verify it worked

Go to `/admin/config/content/content_redirect_to_front_settings`. If the settings
form loads with a list of content types you can tick, the module is installed.
Then configure a content type to redirect (see
[Configuration](../configuration/index.md)), **clear caches**, and — as an
anonymous or non-privileged user — open one of that type's canonical URLs; you
should be redirected to the front page.

> **Remember:** every time you change redirect settings, clear the caches
> (`drush cr`) for the change to take effect.
