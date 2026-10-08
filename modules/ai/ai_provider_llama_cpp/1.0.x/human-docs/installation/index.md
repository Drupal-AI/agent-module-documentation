# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`) — this provider is
  a plugin for it.
- A running **llama.cpp** server with its **OpenAI-compatible `/v1` API** enabled,
  reachable from your Drupal server.

Unlike the cloud providers, a local llama.cpp server usually needs no API key, so
there is typically no Key/secret to set up. There are no additional PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_llama_cpp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_llama_cpp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_llama_cpp -y
```

The module ships no submodules.

Continue to [Configuration](../configuration/index.md) to point the provider at
your server.
