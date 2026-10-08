# Installation

## Requirements

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal
  10 and 11.
- Core's **Filter** (`filter`) and **Media** (`media`) modules — these are
  dependencies and Drupal enables them automatically.

There are no third‑party PHP library requirements — Blazy bundles its own
front‑end assets.

## Install with Composer

From the project root:

```bash
composer require drupal/blazy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/blazy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en blazy -y
```

Enabling the base module makes Blazy's formatters, text filter, Views plugins,
and services available. To actually lazy‑load something you then pick a Blazy
formatter on a field's **Manage display**, or enable the Blazy filter on a text
format — see the *How to use it* section of the [main guide](../index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Blazy UI** | `blazy_ui` | A global settings form for Blazy at **Configuration → Media → Blazy UI** (`/admin/config/media/blazy`). Enable it if you want to change Blazy's site‑wide defaults; the base module runs fine without it. |
| **Blazy Layout** | `blazy_layout` | A dynamic‑region layout for Layout Builder, for building flexible grid‑based sections. |

For example, to add the global settings UI:

```bash
drush en blazy_ui -y
```

Each submodule requires the base Blazy module, which is already present once you
have installed it above.
