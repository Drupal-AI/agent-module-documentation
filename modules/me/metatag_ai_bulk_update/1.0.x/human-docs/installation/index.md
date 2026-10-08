# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **PHP 8.1 or newer**.
- **Metatag AI** (`metatag_ai`) — required.
- **AI Core** (`ai`) — required; provides the AI provider abstraction (OpenAI,
  Anthropic, Ollama, and others).
- Recommended: **Metatag** (ensures saved values render) and **Token** (a nicer
  token-browsing UI).

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_ai_bulk_update -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Metatag AI and AI Core along with
the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_ai_bulk_update -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_ai_bulk_update -y
```

This enables Metatag AI and AI Core as dependencies if they are not already on.

## Verify it worked

Before you can run a batch you must configure an AI provider and Metatag AI (see
[Configuration](../configuration/index.md)). Once those are in place, visit
`/admin/metatag-ai-bulk-update` and confirm the **Bulk Metatags Update Using AI**
form loads.
