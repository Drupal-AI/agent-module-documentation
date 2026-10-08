# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) enabled, with a
  working AI provider (OpenAI, Ollama, etc.) configured — the block renders its
  output by calling that provider.
- Core's **Block** and **Configuration Manager** (`config`) modules (Block is
  what lets you place the block; both are pulled in as dependencies).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_block -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_block -y
```

Then place and configure the block from **Structure → Block layout** as described
in [How to use it](../index.md#how-to-use-it).

## A note on secrets

The block relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, which is how the AI
module reads provider credentials.
