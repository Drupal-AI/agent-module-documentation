# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module enabled (used to place the chat widget).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) enabled, with a
  working AI provider configured — answers are generated through that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_chat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_chat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_chat -y
```

After enabling, set up permissions, place the chat block, and index your content —
see [Configuration](../configuration/index.md).

## A note on secrets

The chatbot relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects.
