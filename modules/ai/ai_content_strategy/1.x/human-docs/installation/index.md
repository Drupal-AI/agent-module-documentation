# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI** module (`ai`) — a hard dependency the module builds on.
- Core's **Menu UI** module (`menu_ui`).
- At least one **chat-capable AI provider** configured in the AI module (OpenAI,
  Anthropic, and so on) with its API key in place, since the analysis calls a
  model.

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
select it when you configure your AI provider. This module relies on the AI module
for provider credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_strategy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_strategy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_strategy -y
```

After enabling, grant the module's administration permission at **People →
Permissions** to the strategists who will run analyses, and confirm your AI
provider is configured first.
