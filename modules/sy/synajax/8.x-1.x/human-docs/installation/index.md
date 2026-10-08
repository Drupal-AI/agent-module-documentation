# Installation

## Requirements

SynAjax is deliberately lightweight. It needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's contact form functionality to apply it to.

There are no third-party module, Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/synajax -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/synajax -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synajax -y
```

## Verify it worked

After enabling, open the SynAjax settings form (the `synajax.config` route) to
confirm the module is present and to switch on AJAX-only submission for your
contact forms — see [Configuration](../configuration/index.md). Then submit a
contact form in a browser to confirm it still works normally for real visitors.
