# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
- The **Key module** (`drupal/key`) — used to hold the Mistral API key outside of
  exported configuration.

Both dependencies are pulled in automatically by Composer. This is a **release
candidate** (1.1.0‑rc1), so test it before relying on it in production.

You will also need a **Mistral account and API key** from
[console.mistral.ai](https://console.mistral.ai/) (creating one is done at the
vendor, not in Drupal).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_mistral -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI and Key
modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_mistral -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_mistral -y
```

This module ships no submodules. Next, add your API key and register the provider
in [Configuration](../configuration/index.md).
