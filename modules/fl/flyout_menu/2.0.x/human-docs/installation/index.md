# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).

Flyout Menu has **no module dependencies** and no third‑party Composer or PHP library
requirements — the animation library ships with the module. It uses core's Block system
to place the menu and toggle, which is always available.

## Install with Composer

From the project root:

```bash
composer require drupal/flyout_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flyout_menu -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flyout_menu -y
```

## Verify it worked

Go to **Structure → Block layout** and confirm the two Flyout Menu blocks — the flyout
menu (panel) and the flyout toggle — are available to place. Once you place both (see
[Configuration](../configuration/index.md)), a toggle control should appear on the front
end and open the sliding panel when clicked.
