# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Luzmo account** with an API key and token (created under your Luzmo
  integrations).
- The **Luzmo embed web component** (`@luzmo/embed`). You can load it remotely
  (the default) or host it locally; the location is set in the module's settings.

There are no additional contrib‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/luzmo_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/luzmo_viewer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en luzmo_viewer -y
```

## Verify it worked

After enabling, go to **Configuration → System → Luzmo settings**
(`/admin/config/system/luzmo-settings`). If the settings form loads, the module
is installed. The next step is to enter your Luzmo API credentials and add a
field — see [Configuration](../configuration/index.md).
