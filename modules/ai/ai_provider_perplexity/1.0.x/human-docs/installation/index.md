# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **AI module** (`drupal/ai`) — the framework this provider plugs into.
  Composer pulls it in automatically.
- A **Perplexity account and API key** from
  [perplexity.ai](https://www.perplexity.ai/) (created at the vendor, not in
  Drupal).

The AI module already brings in the **Key** module, which you should use to hold
the API key as a secret (see Configuration). This is a **beta** release
(1.0.0‑beta2) — test before relying on it.

## ⚠️ Project name vs. machine name

This module has a **name mismatch** you must account for on the command line:

| | Value |
|---|---|
| Drupal project / Composer package | `drupal/ai_provider_perplexity` |
| **Module machine name (for `drush en`)** | **`ai_perplexity`** |

You **require it by the project name** but **enable it by the machine name**.
Enabling `ai_provider_perplexity` will fail — use `ai_perplexity`.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_perplexity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the AI module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_provider_perplexity -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `ai_perplexity`:

```bash
drush en ai_perplexity -y
```

This module ships no submodules. Next, add your API key and register the provider
in [Configuration](../configuration/index.md).
