# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`). This module is only relevant
  where core bundles jQuery 4; it does nothing on earlier core.
- No other contributed modules are required.
- The **jQuery Migrate 4.x library file**, placed manually (see below). Following
  Drupal.org's policy, the module does not bundle the third‑party library itself.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_4_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jquery_4_migrate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Place the jQuery Migrate library

Download the built jQuery Migrate 4.x file and place it in your Drupal
installation's `/libraries` directory so this exact path exists:

```
libraries/jquery-migrate/jquery-migrate.min.js
```

Without this file the module has nothing to load.

## Enable the module

```bash
drush en jquery_4_migrate -y
```

## Verify it worked

After enabling, either add `jquery_4_migrate/jquery-migrate` as a dependency to
the library that needs it, or turn on the sitewide toggle (see
[Configuration](../configuration/index.md)). Then load a page that was throwing
errors and check your browser's JavaScript console — the old errors should be
gone. When jQuery Migrate patches a removed API it logs a console warning naming
the call it fixed, which is the fastest way to find exactly which legacy plugin
still depends on it.
