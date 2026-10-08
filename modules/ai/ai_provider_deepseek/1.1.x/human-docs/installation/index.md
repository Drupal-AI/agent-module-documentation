# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`, version **1.0-beta or newer**) — this provider is a
  plugin for it.
- The **Key** module (`key`) — used to store the DeepSeek API key securely
  instead of in plain configuration.
- A **DeepSeek** account with an API key (for the hosted API), or your own
  self-hosted deployment of the open-weight models.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_deepseek -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `ai` and
`key` modules and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_deepseek -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_deepseek -y
```

Drupal enables the `ai` and `key` modules automatically as dependencies if they
are not already on. This module ships no submodules. Continue to
[Configuration](../configuration/index.md).
