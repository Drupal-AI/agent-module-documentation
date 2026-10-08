# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Analyze** module (`analyze`) — the framework this plugs into.
- The **Key** module (`key`) — used to store your Google Search Console credentials
  securely.
- A **Google Search Console** property for your site, plus API credentials (for example
  a service-account or OAuth credential) that can read its performance data.

## Install with Composer

From the project root:

```bash
composer require drupal/analyze_search_console -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/analyze_search_console -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en analyze_search_console -y
```

This also enables the Analyze and Key modules if they are not already on. Next, follow
[Configuration](../configuration/index.md) to store your Search Console credentials and
grant the viewing permission.
