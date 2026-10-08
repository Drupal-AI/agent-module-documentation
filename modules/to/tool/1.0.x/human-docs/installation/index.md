# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- No other Drupal module or PHP-library dependencies for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tool -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tool -y
```

Remember that the base module ships **no ready-made tools** — it is the framework. You
either enable a module that provides tool plugins, or write your own (see the ["How to use
it" section](../index.md#how-to-use-it)).

## Submodules — enable only what you need

Tool ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Tool AI Connector** | `tool_ai_connector` | Exposes every tool as an AI-module function call, so an LLM can invoke your tools — no per-tool wiring. |
| **Tool Explorer** | `tool_explorer` | An admin UI to browse the available tools and run them by hand (gated by the **Administer tool** permission). |

Enable them individually, for example:

```bash
drush en tool_explorer -y
```
