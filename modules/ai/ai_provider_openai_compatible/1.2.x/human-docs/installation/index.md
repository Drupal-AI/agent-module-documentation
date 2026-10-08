# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
  Composer pulls it in automatically.
- An **OpenAI‑compatible endpoint** to point at: a cloud service such as
  DeepSeek, a self‑hosted/local LLM server, or any other gateway that exposes an
  OpenAI‑style API — plus an API key for it where the endpoint requires one.

The AI module already brings in the **Key** module, which you should use to hold
the API key as a secret (see Configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_openai_compatible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_openai_compatible -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_openai_compatible -y
```

This module ships no submodules. Next, set the endpoint and key in
[Configuration](../configuration/index.md).
