# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI** module (`drupal/ai`) — Gutenberg AI Tools makes its LLM calls through
  it.
- A **provider submodule for the AI module** matching your chosen provider (OpenAI,
  Azure OpenAI, Google Gemini, etc.), installed and configured. See the AI module's
  own documentation for which package to require.
- The **Gutenberg** module (`drupal/gutenberg`).
- Core's **REST** module (`rest`).
- An **API key/account** with your chosen AI provider.

## Install with Composer

From the project root:

```bash
composer require drupal/gutenberg_ai_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the AI, Gutenberg, and REST dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gutenberg_ai_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en gutenberg_ai_tools -y
```

Then, following the **AI** module's documentation, enable and configure the
provider submodule for your AI service (OpenAI, Azure, Gemini, …) and set up its
API key.

## Verify it worked

Once the AI provider is configured and the AI Block is allowed on a content type
(see [Configuration](../configuration/index.md)), open the Gutenberg editor, click
the **+** (Add block) icon, and search for **AI Block**. If it appears and returns
an answer when you type a question and click **Ask AI**, the whole chain is working.
