# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no module dependencies and no third‑party PHP or JavaScript library
requirements. The module registers an HTTP middleware (priority 250, so it runs
before the page cache).

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_bot_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookie_bot_protection -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_bot_protection -y
```

Enabling the module alone changes nothing: the middleware stays a no‑op until you
add at least one protected URL pattern.

## Verify it worked

Go to **`/admin/config/cookie_bot_protection/settings`**. If you can open the
settings form, the module is installed. Add a protected URL pattern (see
[Configuration](../configuration/index.md)), then request that URL in a browser —
it should still load normally after following the challenge redirect, while a
cookie‑less client (for example a bare `curl` without cookie handling) is denied.
