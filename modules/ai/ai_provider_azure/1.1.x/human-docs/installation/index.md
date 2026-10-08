# Installation

## Requirements

Microsoft Azure AI is a provider for the AI module, so it builds on a few other
pieces:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`drupal/ai` `^1.1.0`) — the framework this plugs into.
- The **Key** module (`drupal/key` `^1.18`) — used to store the Azure API key
  securely.
- The **`openai-php/client`** PHP library (`>=v0.10.1`), pulled in automatically
  by Composer.

You also need an **Azure AI Studio / Azure OpenAI deployment**: a Target URI
(endpoint) and an API key from the Azure portal.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_azure -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI module, the
Key module, and the `openai-php/client` library alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_azure -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_azure -y
```

This enables the module together with its `ai` and `key` dependencies. Next,
store your Azure key and add a model — see [Configuration](../configuration/index.md).
