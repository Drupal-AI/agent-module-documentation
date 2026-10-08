# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`) enabled, with a
  working AI provider configured — the analysis runs through that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_advisor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_advisor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_advisor -y
```

Then grant the module's permission to the editors who should be able to request
recommendations.

## A note on secrets

The advisor relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects. Remember that the content you analyse is sent to that provider.
