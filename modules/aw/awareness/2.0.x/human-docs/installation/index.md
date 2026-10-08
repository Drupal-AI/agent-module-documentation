# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) — the only dependency.

There are no third‑party Composer or PHP library requirements. Awareness is a base
API/library module; you typically install it because another module depends on it.

## Install with Composer

From the project root:

```bash
composer require drupal/awareness -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/awareness -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en awareness -y
```

There is nothing to configure — Awareness only provides code (traits and
interfaces) for other modules to use.
