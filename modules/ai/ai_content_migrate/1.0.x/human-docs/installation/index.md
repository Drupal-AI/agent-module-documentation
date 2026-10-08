# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** (`node`) and **Media** (`media`) modules.
- The **AI Agents** module (`ai_agents`) — the migration is driven by AI agents,
  so this is a hard dependency.
- A **chat-capable AI provider** configured through the AI ecosystem (OpenAI,
  Anthropic, and so on) with its API key in place, since the agents call a model
  to infer the content model.

There are no third-party Composer or PHP library requirements.

### A note on the provider API key

Never paste an API key into plain site configuration or commit it to Git. On this
project the convention is to store the secret in an environment variable with
DDEV's dotenv command and then expose it to Drupal through a Key entity:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Then create a Key entity that reads the `OPENAI_API_KEY` environment variable and
select it when you configure your AI provider. The module reuses whatever provider
the AI ecosystem has set up — it stores no key of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in AI Agents and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_migrate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_migrate -y
```

After enabling, grant **`administer ai content migrate`** only to the trusted
administrators who will run migrations — and only run migrations against sources
you trust, because the importer fetches remote URLs and downloads media
server-side.
