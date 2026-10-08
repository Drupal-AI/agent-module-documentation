# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled.
- The **AI** module (`ai`) and **AI CKEditor** (`ai_ckeditor`) enabled, with a
  working AI provider configured — the accessibility check runs through that
  provider.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_ckeditor_wcag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_ckeditor_wcag -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_ckeditor_wcag -y
```

Then add the WCAG tool to a CKEditor 5 text format's toolbar as described in
[How to use it](../index.md#how-to-use-it).

## A note on secrets

The check relies on the AI module's provider, whose API key must be stored
securely — never in plain configuration. Store the key in an environment variable
(with DDEV, `ddev dotenv set .ddev/.env --openai-api-key=<value>` then
`ddev restart`) and reference it through a **Key** entity, as the AI module
expects.
