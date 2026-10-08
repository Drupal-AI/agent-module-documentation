# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
  Composer pulls it in automatically.
- A **Moonshot AI account and API key** from the Moonshot developer platform
  (created at the vendor, not in Drupal).

The AI module already brings in the **Key** module, which you should use to hold
the API key as a secret (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_moonshot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_moonshot -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_moonshot -y
```

This module ships no submodules. Next, add your API key and configure the
connection in [Configuration](../configuration/index.md).
