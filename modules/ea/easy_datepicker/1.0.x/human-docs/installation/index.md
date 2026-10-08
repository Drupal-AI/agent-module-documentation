# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **No external libraries or dependencies** — the picker is a single self‑contained
  JavaScript file.
- *Optional:* the [Webform](https://www.drupal.org/project/webform) module, only if
  you want the Webform "Text field" integration. Easy Datepicker works standalone
  without it — the Webform hook simply doesn't fire when Webform isn't installed.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_datepicker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_datepicker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_datepicker -y
```

## Verify it worked

Visit `/easy-datepicker/demo` to see and try the widget immediately. Then set your
site‑wide defaults at **Configuration → Content authoring → Easy Datepicker**
(`/admin/config/content/easy-datepicker`) — see
[Configuration](../configuration/index.md) — and start using the picker via any of
its three integration methods (see the [overview](../index.md)).
