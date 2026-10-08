# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The contrib **Purge** module (`drupal/purge` `^3.0`) — this is a hard
  dependency and Composer installs it for you. You will enable it alongside
  Dropsolid Purge.
- One or more **Varnish** load balancers you can reach, and the ability to apply
  the bundled example VCL to them.

## Install with Composer

From the project root:

```bash
composer require drupal/dropsolid_purge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in the required `drupal/purge` framework.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropsolid_purge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropsolid_purge -y
```

This also enables the Purge framework it depends on. The purger will not load
until it is fully configured — Purge's diagnostics will flag it as incomplete
until you add the `settings.php` configuration described in
[Configuration](../configuration/index.md).
