# Installation

## Requirements

Login Switch is a small, self‑contained module. It needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- No third‑party Composer or PHP libraries, and no other contrib modules — it works
  entirely with Drupal core's routing system.

## Install with Composer

From the project root:

```bash
composer require drupal/login_switch -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_switch -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_switch -y
```

Enabling the module changes nothing on its own — every route override starts out
switched off. Head to [Configuration](../configuration/index.md) to move or disable
your authentication pages.

> **Remember to clear the cache after configuring.** Because Login Switch rewrites
> route paths, the new URLs only resolve once Drupal rebuilds its router. The settings
> form does this for you on save, but if you change the config another way (Drush,
> `settings.php`), run `drush cr` afterward.
