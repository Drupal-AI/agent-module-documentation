# Installation

## Requirements

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`ai`) — a hard dependency the module builds on.
- The **Field Widget Actions** module (`field_widget_actions`) — a hard dependency
  used to place the suggestion buttons next to the fields.
- At least one **chat-capable AI provider** configured in the AI module (OpenAI,
  Anthropic, and so on) with its API key in place.

There are no third-party Composer or PHP library requirements. Composer will pull
in both module dependencies for you.

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
composer require drupal/ai_content_suggestions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI and Field
Widget Actions modules and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_suggestions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_suggestions -y
```

After enabling, grant the module's permissions at **People → Permissions** to the
editors who should see AI suggestions, and confirm your AI provider is configured
first.
