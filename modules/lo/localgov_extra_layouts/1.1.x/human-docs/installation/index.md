# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Layout Builder** module (`layout_builder`) — the layouts are only useful
  with Layout Builder enabled. There are no other module or library dependencies.

This module is part of the **LocalGov Drupal** distribution but has no other
council-specific requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_extra_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_extra_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_extra_layouts -y
```

The new layouts are available immediately — there is no configuration to do.

## Verify it worked

Edit any content type or page that uses Layout Builder, click **Add section**, and
confirm that **2 Column – 33:66**, **2 Column – 66:33**, and **2x2** appear in the
list of layouts. If they do, the module is working.
