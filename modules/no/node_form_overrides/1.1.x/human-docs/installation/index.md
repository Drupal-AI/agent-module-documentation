# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`), which is enabled on any standard Drupal site.
- **Token** (`drupal/token`) is *optional*. Install it if you want token
  replacement in your titles and button labels and a token‑browser link on the
  forms; without it, the values are used as plain, literal strings.

There are no PHP library or other third‑party requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_form_overrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_form_overrides -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_form_overrides -y
```

## Verify it worked

Log in as a user with the **Administer content types** permission and go to
**Configuration → Content authoring → Node Form Overrides**
(`/admin/config/content/node-form-overrides`). If the settings form loads, the
module is installed. Nothing changes on your node forms until you set an override —
see [Configuration](../configuration/index.md).
