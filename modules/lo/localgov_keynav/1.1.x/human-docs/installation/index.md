# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module or third-party library dependencies. This module is part of
the **LocalGov Drupal** distribution but works on any Drupal 10/11 site.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_keynav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_keynav -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_keynav -y
```

## Verify it worked

After enabling, the module does nothing visible until you grant the *Use LocalGov
keynav* permission — nobody receives shortcuts by default. Head to
[Configuration](../configuration/index.md) to grant the permissions and (optionally)
add custom key sequences. Once a permitted user reloads a page, typing a defined key
sequence should navigate them to its destination.
