# Installation

## Requirements

Statuspal widget needs only **Drupal 9.5, 10, or 11**
(`core_version_requirement: ^9.5 || ^10 || ^11`). There are no additional modules,
third-party Composer packages, or PHP libraries required.

You will also need a **Statuspal** account and the endpoint details for the status
page you want to display.

## Install with Composer

From the project root:

```bash
composer require drupal/statuspal_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/statuspal_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en statuspal_widget -y
```

## After installing

Two steps make the widget appear:

1. Set your Statuspal endpoint and options at
   `/admin/config/services/statuspal/widgetsettings`.
2. Place **both** the button block and the message-container block in your theme
   via **Structure → Block layout**.

See [Configuration](../configuration/index.md).
