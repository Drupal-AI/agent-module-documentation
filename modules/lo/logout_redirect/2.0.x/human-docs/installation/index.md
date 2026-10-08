# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- End users must have **JavaScript enabled** — the Back‑button guard is
  implemented in the browser.

There are no module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/logout_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logout_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logout_redirect -y
```

The Back‑button guard is active immediately, defaulting to `/user/login`. To send
visitors somewhere else, see [Configuration](../configuration/index.md).

## Verify it worked

Log in, browse to an authenticated page, then log out. Press the browser's
**Back** button — instead of the cached authenticated page, you should be sent to
the login page (or your configured path).
