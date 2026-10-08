# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** and **System** modules — both part of Drupal core, and enabled
  automatically as dependencies.

There are no third-party Composer packages, PHP libraries or extra PHP version
constraints recorded for this release.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_cache_recommendations -W
```

The Composer package name (`drupal/smart_cache_recommendations`) matches the
module's machine name (`smart_cache_recommendations`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/smart_cache_recommendations -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_cache_recommendations -y
```

## After enabling

Grant the module's permissions at **People → Permissions** — **access smart cache
recommendations** to whoever should read the dashboard, and **administer smart
cache recommendations** to whoever manages it. Then open the Cache Optimization
Dashboard and run a scan to see your first set of recommendations.
