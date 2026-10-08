# Installation

## Requirements

Masquerade is lightweight and needs only core:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11.0 || ^12.0`).
- Core's **User** (`user`) module, which every Drupal site already has enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/masquerade -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masquerade -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masquerade -y
```

There are no submodules. Enabling the module does nothing on its own until you
grant the masquerade permissions — until then, no one can switch users. Head to
[Configuration](../configuration/index.md) to grant permissions and, optionally,
place the Masquerade block.
