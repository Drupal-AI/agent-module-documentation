# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A working **Varnish** server sitting in front of your Drupal site, configured with
  VCL compatible with the module's BAN/ESI approach. The module is the Drupal side of
  the integration; it does not install or configure Varnish itself.

There are no other Drupal module dependencies and no third-party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/adv_varnish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/adv_varnish -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en adv_varnish -y
```

## Next steps

Point the module at your Varnish server, turn on caching, and (if you want tag-based
purging) enable the built-in purger — all covered in
[Configuration](../configuration/index.md). Nothing is cached through Varnish until you
enable the master **Enable cache** switch.
