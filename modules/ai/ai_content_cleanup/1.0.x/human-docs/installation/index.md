# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** (`node`) and **Text** (`text`) modules — these are the module's
  only hard dependencies, and Drupal enables them automatically.
- A **working AI provider**. The cleanup workflows run through a configured AI
  model, so in practice you need the Drupal **AI** ecosystem installed with at
  least one chat-capable provider (OpenAI, Anthropic, and so on) set up and its
  API key in place. Without a provider the AI steps have nothing to call.

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
select that Key when you configure your AI provider. Configure the provider in the
AI module first; this module simply reuses whatever provider you have set up.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_cleanup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_cleanup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_cleanup -y
```

After enabling, grant the `access ai content cleanup` permission to your editors
and `administer ai content cleanup` to administrators at **People → Permissions**,
and make sure your AI provider is configured before running any cleanup.
