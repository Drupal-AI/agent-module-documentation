# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Two other jQuery UI contrib modules, which Composer and Drupal pull in
  automatically:
  - **jQuery UI** (`drupal/jquery_ui`, `^1.7`) — holds the actual asset files.
  - **jQuery UI Button** (`drupal/jquery_ui_button`, `^2.1`).

There are no other third-party libraries to download and nothing to configure.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_spinner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it will bring in `jquery_ui` and `jquery_ui_button`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_spinner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_spinner -y
```

Drupal enables the two dependency modules automatically. Once they are on, the
`jquery_ui_spinner/spinner` asset library is available to attach — see
[How to use it](../index.md#how-to-use-it) on the overview page.
