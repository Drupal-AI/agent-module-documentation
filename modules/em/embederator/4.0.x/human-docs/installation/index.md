# Installation

## Requirements

Embederator is self‑contained:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other contributed modules are required, and there are no third‑party
  Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/embederator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/embederator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en embederator -y
```

The module ships no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to create your first embed type and
embed.
