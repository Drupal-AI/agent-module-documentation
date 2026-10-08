# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Link** module (`link`), which Drupal enables automatically as a
  dependency. This module extends the core Link field.
- A **Bootstrap‑based theme** for the buttons to look right. This isn't enforced by
  Composer, but the classes the module emits (`btn`, `btn-primary`, and so on) are
  Bootstrap's, so without Bootstrap's CSS the "buttons" render as plain links.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/enhanced_button_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/enhanced_button_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en enhanced_button_link -y
```

There are no submodules. Once enabled, the **Enhanced Button Link** widget and
formatter become available on any Link field, and the settings form appears at
**Configuration → Content authoring → Enhanced Button Link**.

## Verify it worked

Go to a Link field's **Manage display** tab and open the **Format** select — you
should see **Enhanced Button Link**. Set it, then view content with that field; the
link should render as a Bootstrap button. Next, tune the available styles on the
[Configuration](../configuration/index.md) page.
