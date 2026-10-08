# Installation

## Requirements

- **Drupal 11.4 or newer** (`core_version_requirement: >11.3`). This contrib project only
  installs where core has *stopped* shipping Contact. On Drupal 11.3 and earlier, the
  identical module is part of core — you don't install this project there; you just enable
  the core module of the same name.
- Optionally, core's **Field UI** module if you want to add custom fields to a contact
  form (see [Configuration](../configuration/index.md)).

There are no third‑party Composer packages or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/contact -W
```

This only resolves on Drupal 11.4+. The `-W` (`--with-all-dependencies`) flag lets
Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

> **On Drupal ≤ 11.3?** Don't require this project — the module is already in core. Just
> enable it: `drush en contact -y`. When you later upgrade past 11.3, this contrib project
> takes over transparently (same machine name and config), so there's no migration step.

## Enable the module

```bash
drush en contact -y
```

Enabling the module gives you the admin UI and the special *personal* contact form, but
**not** a site‑wide form — `/contact` will 404 until you create one. Head to
[Configuration](../configuration/index.md) to create your first form.
