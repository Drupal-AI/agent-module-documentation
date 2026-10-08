# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** module (`drupal/jquery_ui`, version `^1.7`) and the **jQuery
  UI Menu** module (`drupal/jquery_ui_menu`, version `^2.1`) — the autocomplete
  widget renders its suggestion list using the menu widget, so both are required.
  Composer installs them for you as dependencies when you require this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and here it also pulls in the required `drupal/jquery_ui`
and `drupal/jquery_ui_menu` modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_autocomplete -y
```

That's all there is to it. Enabling the module makes the
`jquery_ui_autocomplete/autocomplete` asset library available for themes and
modules to attach — there is no configuration and no settings page. Drupal also
enables the required `jquery_ui_menu` and `jquery_ui` modules automatically.

There are **no submodules**.
