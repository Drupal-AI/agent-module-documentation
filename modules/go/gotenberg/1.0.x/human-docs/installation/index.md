# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The `gotenberg/gotenberg-php` PHP package, which Composer pulls in for you.
- A running **Gotenberg service** you can reach from the Drupal server — ideally
  one you host yourself on a trusted network (see
  [Configuration](../configuration/index.md)).
- *Optional:* the [Entity Print](https://www.drupal.org/project/entity_print)
  module, if you want to use Gotenberg as its PDF back-end.

## Install with Composer

From the project root:

```bash
composer require drupal/gotenberg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including `gotenberg/gotenberg-php`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gotenberg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gotenberg -y
```

## Verify it worked

Open the module's settings form (via the **Configure** link on `/admin/modules`,
which needs the *administer gotenberg settings* permission) and confirm it loads.
Next, set your Gotenberg endpoint as described in
[Configuration](../configuration/index.md), then try generating a PDF.
