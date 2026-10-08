# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No module dependencies. Suggestion works with standard Drupal search, Search
  views, or Apache Solr, but does not require any of them.
- No PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/suggestion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/suggestion -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en suggestion -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Suggestion**
(`/admin/config/suggestion`). You should reach the settings page, where you choose
content types and tune the suggestion thresholds. Bear in mind that suggestions are
built from your content, so a freshly enabled module on a site with little content
may offer few suggestions until content grows or you add priority suggestions —
continue with [Configuration](../configuration/index.md).
