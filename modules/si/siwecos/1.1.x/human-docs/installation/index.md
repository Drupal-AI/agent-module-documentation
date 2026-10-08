# Installation

> **Before you start:** the SIWECOS service is being discontinued and this module
> is marked unsupported/obsolete. Its own project page recommends disabling and
> uninstalling it. Install it only to maintain an existing setup.

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Note it
  does not declare Drupal 11 support.
- A free **SIWECOS account** — register at siwecos.de and copy your credentials
  from there. Without an account the module has nothing to log in to.
- A **publicly reachable site**. The scanners run from outside, so there is no
  support for sites behind `.htpasswd` or otherwise not publicly accessible.

There are no dependent Drupal modules and no additional PHP or library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/siwecos -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/siwecos -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en siwecos -y
```

## Next steps

Once enabled, head to [Configuration](../configuration/index.md) to enter your
SIWECOS account email and password, after which the module logs in, registers
your site's domain, and makes the report available under **Reports → Siwecos**.
