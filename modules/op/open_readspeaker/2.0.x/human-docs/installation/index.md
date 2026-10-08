# Installation

## Requirements

- **Drupal 10.2, or 11** (`core_version_requirement: ^10.2 || ^11`).
- A valid, paid **ReadSpeaker customer account** — the module is a bridge to
  ReadSpeaker's hosted service and does nothing without a customer ID.
- No other Drupal modules are required. Two are *suggested* but optional:
  [Token](https://www.drupal.org/project/token) (adds a token‑browser link on
  the settings form) and [CSP](https://www.drupal.org/project/csp) (lets the
  module extend a strict Content‑Security‑Policy to allow ReadSpeaker's host).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/open_readspeaker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/open_readspeaker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en open_readspeaker -y
```

Or enable **Open ReadSpeaker** from **Extend** (`/admin/modules`).

Enabling the module does not make anything visible yet — nothing appears on the
front end until you set your customer ID and place the *"Listen"* block. Head to
[Configuration](../configuration/index.md) next.

There are no submodules.
