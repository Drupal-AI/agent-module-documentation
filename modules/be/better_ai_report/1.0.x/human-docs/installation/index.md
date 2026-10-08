# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`ai`) — Better AI Report depends on it, and Composer pulls it
  in automatically. You also need a working AI provider (for example OpenAI,
  Anthropic, or another provider supported by the AI module) with an API key.

## Install with Composer

From the project root:

```bash
composer require drupal/better_ai_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the `ai` module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_ai_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_ai_report -y
```

Enabling this also enables the `ai` module if it was not already on.

## Set up the AI provider and its API key

Before you can generate reports you need an AI provider configured in the AI
module, with its API key. **Never hard‑code or commit an API key.** Store it in an
environment variable and reference it through a Key entity:

- With DDEV, save the key into `.ddev/.env` (kept out of version control) with
  `ddev dotenv set .ddev/.env --openai-api-key=<value>`, then `ddev restart`.
- Create a Key entity that reads that environment variable, and point your AI
  provider at it.

See the AI module's own documentation for the exact provider setup; Better AI
Report then simply selects one of the configured providers on its settings page.
