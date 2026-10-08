# Installation

## Requirements

- **Drupal 11.1+ or 12** (`core_version_requirement: ^11.1 || ^12`).
- Core's **Language** (`language`), **Content Translation** (`content_translation`),
  and **Locale** (`locale`) modules — all hard dependencies, enabled automatically.
  You will also need at least one non-default language added and your content set
  up as translatable, which is standard core multilingual setup.
- A **chat-capable AI provider** configured through the AI module (OpenAI,
  Anthropic, and so on) with its API key in place, since the module translates by
  calling that provider.

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
select it when you configure your AI provider. The module relies on the AI provider
for credentials rather than storing a key of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_translator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_translator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_translator -y
```

After enabling, add your languages and mark content as translatable in core, make
sure your AI provider is configured, then grant **`translate content with ai`** to
editors and keep **`administer ai content translator`** with administrators at
**People → Permissions**.
