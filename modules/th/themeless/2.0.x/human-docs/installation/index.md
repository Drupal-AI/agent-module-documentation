# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** — the 2.0.x branch requires it.
- Core's **Node** module (`node`), which is standard on most sites.

There are no third-party Composer libraries to add.

> **Coming from Drupal 7?** Version 2.0.x is a complete rewrite. There is no
> upgrade path from the old 7.x-1.x branch — the URLs, configuration, and format
> selection all changed. Treat it as a fresh install.

## Install with Composer

From the project root:

```bash
composer require drupal/themeless -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/themeless -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en themeless -y
```

If you want the sample content for a quick test, also enable the demo submodule:

```bash
drush en themeless_demo -y
```

## Verify it worked

After enabling, grant the access permission and turn on the Themeless display for
at least one content type (see [Configuration](../configuration/index.md)), then
request an entity — for example `curl https://example.com/api/node/1`. You should
get JSON back with no theme wrapper.
