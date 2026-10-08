# Installation

## Requirements

jQuery UI Accordion is a lightweight library provider. It needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The base **jQuery UI** module (`drupal/jquery_ui: ^1.7`), which ships the actual
  jQuery UI assets. Composer installs it automatically as a dependency, and Drupal
  enables it as a dependency when you turn on this module.

There are no additional third‑party libraries or PHP requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed and pull in the base `jquery_ui` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_accordion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_accordion -y
```

That's the entire setup. There are no submodules, no permissions, and no
configuration. Once enabled, the `jquery_ui_accordion/accordion` asset library is
available for your themes and modules to attach — see
[How to use it](../index.md#how-to-use-it) on the overview page for the attach‑and‑
initialize pattern.
