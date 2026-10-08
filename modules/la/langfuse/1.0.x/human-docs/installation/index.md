# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher** — the module uses modern PHP features such as readonly
  properties.
- Core's **Configuration Manager** (`config`) and **System** (`system`) modules.
- A **LangFuse account** — either LangFuse Cloud, or a self‑hosted instance (free
  to run with Docker Compose).
- The **AI module** if you want the automatic AI‑call tracking; the AI Agents and
  AI Search modules if you want their dedicated instrumentation submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/langfuse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the LangFuse PHP
SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/langfuse -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core module first:

```bash
drush en langfuse -y
```

## Submodules — enable only what you need

LangFuse ships optional submodules that add automatic instrumentation. Enable them
individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **AI logging** | `langfuse_ai_logging` | Automatically captures AI module interactions — programmatic calls, the AI Explorer, chat forms, embeddings, moderation — with no code changes. This is the recommended starting point. |
| **AI Agents logging** | `langfuse_ai_agents_logging` | Instruments the AI Agents module: every tool execution becomes a LangFuse span with input/output metadata, and nested agents nest correctly. |
| **AI Search logging** | `langfuse_ai_search_logging` | Instruments AI Search / RAG operations, adding detailed span and trace management. |
| **Example** | `langfuse_example` | Example demonstrations of the integration. Enable it only to explore; leave it off in production. |

For example, to add the automatic AI‑call tracking most people want:

```bash
drush en langfuse_ai_logging -y
```

## Verify it worked

Visit **Configuration → System → LangFuse → Settings**
(`/admin/config/system/langfuse/settings`) and enter your LangFuse URL and
credentials as described in [Configuration](../configuration/index.md). The module
tests the connection automatically when you save.
