# Installation

## Requirements

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4 || ^12`).
- **PHP 8.3 or newer** — this is a hard requirement (`php: >=8.3`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The variables and skins you edit come from YAML shipped by your
theme (or a module), not from UI Skins itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ui_skins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ui_skins -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ui_skins -y
```

UI Skins ships no submodules. After enabling, go to **Appearance → CSS variables**
(`/admin/appearance/css-variables`) to see which of your themes expose editable
variables. If the list is empty or a theme has no settings screen, that theme
simply hasn't declared any CSS variable plugins yet — see
[Configuration](../configuration/index.md) and the [`agent/`](../agent/start.md)
docs for how those are defined.
