# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **System** module (`system`), which every Drupal site already has.

There are no third-party PHP libraries or external services to install.

## Install with Composer

From the project root:

```bash
composer require drupal/site_health -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_health -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_health -y
```

## After enabling

Grant the module's monitoring/report permission to the developer and administrator
roles that should be able to view the diagnostics — the reports can include query text
that may contain data, so keep access restricted. Then open the Site Health dashboard to
see query statistics accumulate. Because query monitoring is most useful (and least
intrusive) away from live traffic, consider running it primarily on development or
staging environments.
