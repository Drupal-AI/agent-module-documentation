# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text** module (`text`) — Drupal core, enabled automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/asm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/asm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en asm -y
```

After enabling, add the addresses you want to block — see
[Configuration](../configuration/index.md). This is a beta release (1.0.0‑beta2);
test it before relying on it. A common workflow is to enable it (and populate the
blocklist) only on staging/development environments, and to keep it off — or leave
the list empty — in production.

This module has no submodules.
