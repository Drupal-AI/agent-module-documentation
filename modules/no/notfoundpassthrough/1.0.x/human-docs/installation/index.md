# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Redirect** module (`redirect`) — a required dependency, pulled in by
  Composer.
- One or more **trusted fallback hosts**, reachable over HTTPS, that hold the
  legacy content you want to fall back to.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/notfoundpassthrough -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Redirect module
and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/notfoundpassthrough -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with Redirect (Drush will pull Redirect in as a dependency, but
naming it is harmless):

```bash
drush en redirect notfoundpassthrough -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Page Not Found Passthrough (Redirect
on 404)**. If the settings form loads, the module is active. It won't do anything
useful until you add fallback domains **and** point Drupal's default 404 page at the
module — continue to [Configuration](../configuration/index.md).
