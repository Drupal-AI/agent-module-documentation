# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`) — note this
  provider does *not* support Drupal 10.
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`) — this provider is
  a plugin for it.
- The **[Key module](https://www.drupal.org/project/key)** (`key`) to hold API keys
  securely where an endpoint requires one.
- One or more **OpenAI-compatible** endpoints you want to register.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_universal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and Key modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_universal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_universal -y
```

Enabling it also enables the AI and Key modules if they are not on yet. The module
ships no submodules.

Continue to [Configuration](../configuration/index.md) to define your servers and
models.
