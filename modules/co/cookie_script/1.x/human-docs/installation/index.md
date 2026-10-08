# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Cookie-Script.com account** and its ID — the banner cannot load without it.

There are no module dependencies and no third‑party PHP or JavaScript library
requirements (the Cookie-Script code is loaded at runtime from the service).

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_script -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_script -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_script -y
```

Enabling alone does not show the banner — you must enter your Cookie-Script ID.

## Verify it worked

After configuring (see [Configuration](../configuration/index.md)), load any page
and confirm the Cookie-Script consent banner appears and that the Cookie-Script code
is present in the page. Then check in the Cookie-Script dashboard that your
analytics/marketing scripts are set to be blocked until consent.
