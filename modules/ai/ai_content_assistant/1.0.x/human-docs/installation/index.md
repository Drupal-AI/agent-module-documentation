# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Node** module (a declared dependency).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) enabled, with a
  working AI provider configured — generation runs through that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_assistant -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_assistant -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_assistant -y
```

Then grant the module's permission to the editors who should be able to generate
content.

## A note on secrets

The assistant relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects. Remember that the content and prompts you generate from are sent to that
provider.
