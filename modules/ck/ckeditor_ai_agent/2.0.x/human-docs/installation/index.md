# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI module** (`drupal/ai`) — required. It routes AI requests server-side
  through Drupal so provider API keys never reach the browser, and it works with
  any AI provider plugin.
- An **AI provider module** (for example DXPR AI Provider, OpenAI, Anthropic, or
  Ollama) with valid credentials.
- Core's **CKEditor 5** module (`ckeditor5`).

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_ai_agent -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
update any shared dependencies as needed. Install your chosen provider module the
same way (for example `composer require drupal/ai_provider_openai -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor_ai_agent -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_ai_agent -y
```

Enable the AI module and your provider module too (Drush will enable `ai` as a
dependency, but the provider module you enable explicitly, e.g. `drush en
ai_provider_openai -y`).

## Storing the provider API key safely

Never hard-code or commit a provider API key. The recommended pattern on this
project is to keep it in an environment variable and expose it to Drupal through
a **Key** entity. With DDEV:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Then create a Key with the built-in environment provider (install the Key module
first if needed) and point your AI provider at that Key in its settings. Your
provider module's own documentation will tell you exactly which key type it
expects. Keep `.ddev/.env` out of version control.

## Verify it worked

After enabling everything, continue to [Configuration](../configuration/index.md)
to select a default chat provider, grant the *Use CKEditor AI Agent* permission,
and add the AI Agent button to a text format's toolbar. Then edit content with
that format and confirm that typing `/` opens the AI command menu.
