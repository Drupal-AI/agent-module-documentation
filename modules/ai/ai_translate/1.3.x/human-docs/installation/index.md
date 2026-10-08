# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **AI** module (`drupal/ai`, version greater than 1.2.1) — a required
  dependency — **with a working provider configured** (for example an OpenAI or
  Anthropic chat provider that supports the `translate_text` operation). The LLM
  endpoint, model, and API key are set up in the AI module, not here.
- Core's **Content Translation** module (`content_translation`) — a required
  dependency, enabled automatically. Your site must be multilingual, with the
  target languages added and the relevant content types set translatable.

There are no third-party PHP library requirements beyond what the AI provider
itself needs.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI module,
Content Translation's dependencies, and any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_translate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_translate -y
```

This also enables the AI and Content Translation modules if they were not
already on. The module ships no submodules.

## Before you translate

Make sure the AI module has a provider configured and selected for the
**translate text** operation, that your site has more than one language, and that
the content types you want to translate are marked translatable under **Language
→ Content language and translation**. Then head to
[Configuration](../configuration/index.md).
