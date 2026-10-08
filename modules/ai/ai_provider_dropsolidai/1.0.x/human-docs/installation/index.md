# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) — this provider is a plugin for it.
- The **AI Provider LiteLLM** module (`ai_provider_litellm`), which this module
  builds on to speak to the Dropsolid endpoint. Composer pulls it in
  automatically.
- A **Dropsolid AI** endpoint URL and an API key.

Storing the key through the **Key** module is the project convention (see
Configuration). There are no additional PHP library requirements. Be aware this is
an **alpha** release (1.0.1-alpha1).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_dropsolidai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`ai_provider_litellm` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_dropsolidai -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_dropsolidai -y
```

Drupal enables the `ai` and `ai_provider_litellm` modules automatically as
dependencies if they are not already on. This module ships no submodules. Continue
to [Configuration](../configuration/index.md).
