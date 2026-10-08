# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8.0 || ^9 || ^10`).
- **A Zoho SalesIQ account**, so you have a widget-code snippet to paste in.

There are no dependent modules, no submodules, and no third-party PHP or JavaScript
library requirements.

## Install with Composer

Note the Composer package name is `drupal/salesiq`, even though the module's machine
name is `zohosalesiq`. From the project root:

```bash
composer require drupal/salesiq -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/salesiq -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `zohosalesiq` (not `salesiq`):

```bash
drush en zohosalesiq -y
```

## Verify it worked

Go to **Configuration → Web services → Zoho SalesIQ**
(`/admin/config/services/zohosalesiq`). If the settings form loads, the module is
active. Nothing appears on your pages yet, though — the widget only shows once you
paste in your Zoho widget code. See [Configuration](../configuration/index.md).
