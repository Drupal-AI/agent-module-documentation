# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** module (`drupal/jquery_ui`, version `^1.7`), which provides
  the jQuery UI core/widget files. Composer installs it for you as a dependency
  when you require this module.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and here it also pulls in the required `drupal/jquery_ui`
module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_menu -y
```

That's all there is to it. Enabling the module makes the `jquery_ui_menu/menu`
asset library available for themes and modules to attach — there is no
configuration and no settings page.

There are **no submodules**.
