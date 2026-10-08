# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** (`ai`) and **AI Agents** (`ai_agents`) modules — these provide the
  agent framework and function calling the tools plug into.
- The **Key** (`key`) module — used to store your Pexels API key securely.
- Core **Media** (`media`) — where imported photos and videos are saved.
- A **Pexels API key** (free from the Pexels developer site).

Composer pulls the module dependencies in for you when you require Pexels AI.

## Install with Composer

From the project root:

```bash
composer require drupal/pexels_ai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it fetches AI, AI Agents, Key, and Media as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pexels_ai -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pexels_ai -y
```

This also enables the AI, AI Agents, Key, and Media modules if they are not
already on.

## Verify it worked

Log in as an administrator and open **`/admin/config/pexels_ai/settings`** — the
settings page should load. After you store your Pexels API key there (see
[Configuration](../configuration/index.md)), the Pexels search and download tools
become available to your AI agents.
