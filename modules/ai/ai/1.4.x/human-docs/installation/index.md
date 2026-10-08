# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- The **Key** module (`drupal/key` `^1.18`) — AI Core stores all API keys through
  Key, so this is required. Composer installs it for you.
- Core's **File** module (`file`).
- Three PHP libraries, installed automatically by Composer: `league/html-to-markdown`
  (`^5.1`), `yethee/tiktoken` (`^0.5.1`, the tokenizer), and `openai-php/client`
  (`>=v0.10.1`). Optionally `league/commonmark` for chunk previews and chatbot
  formatting.
- **At least one AI provider module.** AI Core is only the abstraction layer — it
  cannot call any vendor on its own. Install a provider such as
  `ai_provider_openai`, `ai_provider_anthropic`, or `ai_provider_ollama` (for local
  development) to actually run requests.

## Install with Composer

From the project root:

```bash
composer require drupal/ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in the Key module and the PHP
libraries. Add a provider the same way, for example:

```bash
composer require drupal/ai_provider_openai -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai -y
```

Enable your provider module the same way (`drush en ai_provider_openai -y`).

## Store your API key with the Key module

Never put a vendor API key in configuration or `settings.php`. Store it as a **Key
entity** — the environment‑variable key provider is recommended so the secret stays
out of exported config — and then select that Key in the provider's settings form.
Your host's guidance on saving secrets as environment variables and creating a Key
entity applies here.

## Submodules

AI Core ships a large set of optional submodules — enable only what you need. Some
notable ones, documented separately, include:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI API Explorer** | `ai_api_explorer` | An interactive tester for AI requests. |
| **AI Assistant API** | `ai_assistant_api` | Framework for building AI assistants. |
| **AI Automators** | `ai_automators` | Automate field population with AI. |
| **AI Chatbot** | `ai_chatbot` | A chatbot UI. |
| **AI CKEditor** | `ai_ckeditor` | AI tools inside the CKEditor editor. |
| **AI Search** | `ai_search` | Vector/semantic search (experimental). |
| **AI Observability** | `ai_observability` | Insight into AI requests. |

Enable one with, for example:

```bash
drush en ai_api_explorer -y
```

Several other submodules ship with the project but are marked deprecated in their
own metadata (for example `ai_content_suggestions`, `ai_eca`,
`ai_external_moderation`, `ai_logging`, `ai_translate`, `ai_validations`,
`field_widget_actions`); check each submodule's status before relying on it.

## Next steps

Configure the default provider and model per operation, and tune the global
settings — see [Configuration](../configuration/index.md).
