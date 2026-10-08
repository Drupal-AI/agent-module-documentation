# Installation

## Requirements

- **Drupal 8 or newer** — the module declares the loose `core_version_requirement:
  >=8`, and the current release is 2.0.6.
- The contributed **Token** module (`token`) — the meta token plugs into Token's
  machinery, so it's a required dependency. Composer pulls it in automatically.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/token_modifier -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_modifier -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en token_modifier -y
```

This also enables Token if it wasn't already. The module ships no submodules and
needs no configuration — just start writing `[token-modifier:…]` tokens as shown
in the [main guide](../index.md#how-to-use-it).
