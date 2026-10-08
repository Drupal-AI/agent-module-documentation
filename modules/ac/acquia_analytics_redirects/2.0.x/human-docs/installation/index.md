# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- A site hosted on **Acquia Cloud** (behind Acquia's Varnish), which is where the
  `X-Acquia-Stripped-Query` header this module relies on is produced. On any other
  host that header is normally absent, so the module simply does nothing — it is
  designed for the Acquia Varnish tier (see the [main page](../index.md#how-to-use-it)).

There are no other module dependencies and no third-party Composer or PHP library
requirements (`composer.json` declares no dependencies).

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_analytics_redirects -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_analytics_redirects -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_analytics_redirects -y
```

That's the entire setup. There is **no configuration** — the module's event
subscriber begins re-attaching stripped analytics parameters to 301/302 redirects
right away.
