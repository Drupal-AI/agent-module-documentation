# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **Key** module (`key`) — used to store DXPR credentials securely instead of
  in plain configuration.
- **DXPR Builder** (`dxpr_builder`, version **2.7.5 or newer**) — DXPR AI is part
  of the DXPR product, so its Builder module must be present.
- A **DXPR** account / credentials that grant access to DXPR AI.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_dxpr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai`, `key`
and `dxpr_builder` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_dxpr -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_dxpr -y
```

Drupal enables the `ai`, `key` and `dxpr_builder` modules automatically as
dependencies if they are not already on. This module ships no submodules. Continue
to [Configuration](../configuration/index.md).
