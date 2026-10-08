# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- No other modules, PHP libraries, or Composer packages are required.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect404_home -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect404_home -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect404_home -y
```

There are no submodules.

## One extra step to make it take effect

For the module to catch 404s, Drupal must actually reach the core `system.404` route.
If your site has a custom **Default 404 (not found) page** set, core serves that instead
and the module never runs. Leave that setting empty:

```bash
drush cset system.site page.404 '' -y
drush cr
```

Then continue to [Configuration](../configuration/index.md) to choose the redirect code
and message — and read the redirect-loop caveat there before going to production.
