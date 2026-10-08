# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's **[AI](https://www.drupal.org/project/ai)** module with a working AI
  provider configured — this module moderates comments through OpenAI via the AI
  module's provider system. (The AI module is not listed as a hard package
  dependency, so make sure it is installed and configured yourself.)
- Drupal's core commenting in use, since the module screens submitted comments.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_comment_moderation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_comment_moderation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_comment_moderation -y
```

Then configure the AI provider it should use.

## A note on secrets

Moderation sends comment text to OpenAI, whose API key must be stored securely —
never in plain configuration. Store the key in an environment variable (with DDEV,
`ddev dotenv set .ddev/.env --openai-api-key=<value>` then `ddev restart`) and
reference it through a **Key** entity, as the AI module expects. Remember that the
text of every screened comment is transmitted to that provider.
