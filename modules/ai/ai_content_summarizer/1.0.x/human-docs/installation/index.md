# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Node** module (`node`) — the only hard dependency, enabled
  automatically.
- Access to at least one supported **AI provider**: OpenAI, Anthropic (Claude), or
  Google Gemini (each needs an API key), or a local **Ollama** install (no key,
  runs on your own hardware).

Note that this module does **not** depend on the shared Drupal AI module — it has
its own built-in provider layer, so you do not need to install or configure the AI
module for it to work. There are no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_content_summarizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_content_summarizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_content_summarizer -y
```

## Next steps

Enabling the module creates its storage table but does nothing until you configure
a provider. Head to [Configuration](../configuration/index.md) to choose a
provider, enter its settings, and select which content types can be summarized.
