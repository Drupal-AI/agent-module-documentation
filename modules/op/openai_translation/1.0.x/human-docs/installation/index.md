# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A multilingual setup — the languages you want to translate into should be
  enabled on your site (core **Language** module).
- An **OpenAI API key**, or an **Azure OpenAI** account and key.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/openai_translation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openai_translation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openai_translation -y
```

## Verify it worked

After enabling, go to [Configuration](../configuration/index.md) to connect your
OpenAI (or Azure OpenAI) account and choose the languages you want translations
for. Then generate a test translation and confirm you can copy the result.
