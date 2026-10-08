# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`) — this is
  **unusually tight at both ends**. It will not install on 10.4 or earlier, nor on
  11.0/11.1. Check your core version first.
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
- The **Key module** (`drupal/key`) — holds the OpenRouter API key outside
  exported configuration.

Both module dependencies are pulled in automatically by Composer. You will also
need an **OpenRouter account and API key** from
[openrouter.ai](https://openrouter.ai/) (version 1.1.6).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_openrouter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI and Key
modules and update any shared dependencies as needed. If Composer refuses the
install, confirm your Drupal core version satisfies `^10.5 || ^11.2`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_openrouter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_openrouter -y
```

This module ships no submodules. Next, add your API key and register the provider
in [Configuration](../configuration/index.md).
