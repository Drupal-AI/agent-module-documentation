# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3||^11`).
- A **working AI provider**. The module drafts content by calling an AI model, so
  in practice you need the Drupal **AI** ecosystem installed with at least one
  chat-capable provider (OpenAI, Anthropic, and so on) configured and its API key
  in place. Without a provider there is nothing to generate against.

The module lists no hard module dependencies of its own and has no third-party
Composer or PHP library requirements.

### A note on the provider API key

Never paste an API key into plain site configuration or commit it to Git. On this
project the convention is to store the secret in an environment variable with
DDEV's dotenv command and then expose it to Drupal through a Key entity:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Then create a Key entity that reads the `OPENAI_API_KEY` environment variable and
select it when you configure your AI provider. This module reuses whatever
provider the AI module already has set up.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_creator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_creator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_creator -y
```

Make sure your AI provider is configured before you try to generate content.
