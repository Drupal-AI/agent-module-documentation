# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the
  dependency, and Drupal enables it (along with Layout Discovery) automatically.

There are no third‑party Composer or PHP library requirements, and no permissions of
the module's own — it uses Layout Builder's access control.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_bg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_bg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_bg -y
```

Drupal enables Layout Builder at the same time if it isn't already on.

There are no submodules to enable for normal use. (The `examples/` folder contains
several sample sub‑modules demonstrating usage patterns; they're optional and not
needed to use Layout BG.)

After enabling, the two background layouts become available whenever you add a section
in Layout Builder — see the [main guide](../index.md#how-to-use-it).
