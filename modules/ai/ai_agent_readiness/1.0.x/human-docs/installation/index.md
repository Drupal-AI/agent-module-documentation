# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That is all. Unlike most modules in the AI ecosystem, AI Agent Readiness has **no
dependency on the AI module or on an LLM provider** — it only publishes static
discovery documents, so there is no API key to configure and no per‑request cost.
It has no other Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agent_readiness -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_agent_readiness -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agent_readiness -y
```

As soon as it is enabled, the discovery endpoints (`/llms.txt`,
`/.well-known/…`, and their `/api/ai-agent/*` mirrors) are live and publicly
crawlable.

## Next step

Open [Configuration](../configuration/index.md) to tailor what those documents
advertise about your site.
