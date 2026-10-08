# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No modules outside of Drupal core are required.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tab_title_attention -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tab_title_attention -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tab_title_attention -y
```

The module does nothing until you activate and configure the animation, so head to
[Configuration](../configuration/index.md) next.

## Verify it worked

After enabling, go to **Configuration → User interface → Tab Title Attention
settings** and confirm the settings form loads. Once you have activated an
animation, open your site, switch to another browser tab, wait a moment, and watch
the inactive tab's title animate.
