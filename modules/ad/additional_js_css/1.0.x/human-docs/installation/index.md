# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- The **jQuery UI Resizable** module (`jquery_ui_resizable`) — this is a required
  dependency (it makes the code textareas resizable). Composer pulls it in
  automatically with the command below.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/additional_js_css -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `jquery_ui_resizable` dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/additional_js_css -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en additional_js_css -y
```

Drush enables the `jquery_ui_resizable` dependency at the same time. Once enabled,
open the editors at **Configuration → Development → Additional JS CSS** — see
[Configuration](../configuration/index.md).
