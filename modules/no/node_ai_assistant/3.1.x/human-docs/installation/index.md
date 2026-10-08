# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Node** module (part of standard Drupal).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) — Node AI
  Assistant uses it to talk to your chosen AI provider. Composer installs it for
  you with the `-W` flag.
- An account and API key with a supported AI provider (OpenAI, Anthropic Claude,
  Azure OpenAI, or Google Gemini), configured through the AI module.

## Install with Composer

From the project root:

```bash
composer require drupal/node_ai_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AI module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/node_ai_assistant -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_ai_assistant -y
```

This enables the AI module dependency at the same time.

## Verify it worked

The assistant won't work until you configure an AI provider and grant the
permission (see [Configuration](../configuration/index.md)). Once that's done,
open an **existing** node's edit form and look for the **AI Assistant** tab in
the vertical tabs at the bottom, alongside tabs like *Authoring information* and
*Promotion options*.
