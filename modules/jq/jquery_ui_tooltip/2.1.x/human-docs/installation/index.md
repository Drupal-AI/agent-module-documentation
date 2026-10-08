# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **jQuery UI** base module (`jquery_ui`, `drupal/jquery_ui` version **^1.7**) —
  this is a hard dependency. It supplies the actual tooltip library definition and
  the helper libraries (`jquery_ui/widget`, `jquery_ui/position`, and others) the
  tooltip depends on. Installing with Composer pulls it in automatically.

There are no other module dependencies and no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jquery_ui_tooltip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it is what brings in the `drupal/jquery_ui` base module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jquery_ui_tooltip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jquery_ui_tooltip -y
```

Enabling it also enables the `jquery_ui` base module if it isn't already on. Once
enabled, the `jquery_ui_tooltip/tooltip` library is available to attach — see
[How to use it](../index.md#how-to-use-it).

There are no submodules.
