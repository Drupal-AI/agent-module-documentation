# Installation

## Requirements

JSON:API Extras runs on **Drupal 9.5, 10, or 11** and needs **PHP 8.1 or
newer**. It has two dependencies, which Composer pulls in automatically:

- **JSON:API** (`jsonapi`) — the core module that JSON:API Extras builds on and
  decorates. It ships with Drupal core, and enabling JSON:API Extras enables it
  as a dependency.
- **Shaper** (`e0ipso/shaper`) — a PHP transformation library that powers the
  field enhancer plugins. Composer installs it for you.

The module also ships an optional submodule, **JSON:API Defaults**
(`jsonapi_defaults`), which lets you set default includes, filters, and sorting
per resource. Enable it separately only if you need those features.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
(such as `e0ipso/shaper`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/jsonapi_extras -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_extras -y
```

This also enables core's `jsonapi` module if it isn't already on. Once enabled,
the configuration screen appears under **Configuration → Web services →
JSON:API → Extras** (`/admin/config/services/jsonapi/extras`).

## Verify it worked

Log in as an administrator and go to `/admin/config/services/jsonapi/extras`.
You should see the **JSON:API Extras** page with its **Settings** and **Resource
overrides** tabs:

![The JSON:API Extras settings page](../images/settings.png)

If the page loads and both tabs are present, the module is installed correctly.
Next, review the [configuration](../configuration/index.md).
