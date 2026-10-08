# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI CKEditor** module (`ai_ckeditor`, part of the
  [AI](https://www.drupal.org/project/ai) project) enabled, with a working AI
  provider (OpenAI, Ollama, etc.) configured — every tool dispatches its request
  to that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_ckeditor_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_ckeditor_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_ckeditor_extras -y
```

Then add the tools to a text format's CKEditor toolbar and configure each one's
provider/model and prompt as described in
[How to use it](../index.md#how-to-use-it).

## A note on secrets

The tools rely on the AI module's provider, whose API key must be stored securely
— never in plain configuration. Store the key in an environment variable (with
DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then `ddev restart`)
and reference it through a **Key** entity, as the AI module expects.
