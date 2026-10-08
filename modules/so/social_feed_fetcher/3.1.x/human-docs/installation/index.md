# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (`node`), which stores the fetched posts. Drupal enables
  it automatically as a dependency.
- An API app and access token for each social platform you want to fetch from (see
  [Configuration](../configuration/index.md)) — this is the real work of setting
  the module up, not the install itself.

There are no third-party Composer or PHP library requirements declared by the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/social_feed_fetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_feed_fetcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_feed_fetcher -y
```

## Verify it worked

After enabling, grant the **administer socialpost entity** permission to the roles
that should manage feeds, then open the module's settings form to enter your
platform credentials. Nothing will be fetched until at least one platform is
configured with a valid token.
