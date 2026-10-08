# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI CKEditor** module (`ai_ckeditor`, part of the
  [AI](https://www.drupal.org/project/ai) project) enabled, with a working AI
  provider configured — the CEFR rewrite runs through that provider.
- Core's **Taxonomy** module (a declared dependency).

## Install with Composer

From the project root:

```bash
composer require drupal/ai_ckeditor_cefr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_ckeditor_cefr -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_ckeditor_cefr -y
```

Then add the CEFR tool to a text format's CKEditor toolbar as described in
[How to use it](../index.md#how-to-use-it).

## A note on secrets

The rewrite relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects.
