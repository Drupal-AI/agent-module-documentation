# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`) — this provider is
  a plugin for it.
- The **[Key module](https://www.drupal.org/project/key)** (`key`) to hold the
  AnythingLLM API key securely.
- A reachable **AnythingLLM** instance (self-hosted or otherwise), with its base
  URL and an API key.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_anythingllm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and Key modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_anythingllm -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_anythingllm -y
```

Enabling it also enables the AI and Key modules if they are not on yet. The module
ships no submodules.

Continue to [Configuration](../configuration/index.md) to set the endpoint URL and
API key.
