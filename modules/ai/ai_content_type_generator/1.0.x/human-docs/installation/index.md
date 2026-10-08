# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** (`node`), **Field** (`field`), and **Text** (`text`) modules.
- The **AI** module (`ai`, "AI Core") with at least one **chat-capable provider**
  configured (OpenAI, Anthropic, and so on) and its API key in place. This is a
  hard dependency — the module has no AI of its own and delegates every call to AI
  Core.
- *(Optional)* core field-type modules, if you want the generator to produce those
  field types — see the field-type list in [Configuration](../configuration/index.md).

There are no third-party Composer or PHP library requirements.

### A note on the provider API key

This module stores **no key of its own** — credentials live with AI Core. Never
paste an API key into plain site configuration or commit it to Git. On this project
the convention is to store the secret in an environment variable with DDEV's dotenv
command and then expose it to Drupal through a Key entity:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<value>
ddev restart
```

Then create a Key entity that reads the `OPENAI_API_KEY` environment variable and
select it when you configure your AI provider in AI Core.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_type_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_type_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_type_generator -y
```

After enabling, make sure AI Core has a working provider, then grant **Generate AI
content types** only to trusted site builders (each generation is a paid AI call)
and keep **Administer AI content type generator** with administrators. Continue to
[Configuration](../configuration/index.md) to pick the provider and model.
