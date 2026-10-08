# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **AI** module (`ai`) with an AI provider configured — its API key stored via
  a Key entity / environment variable, never in plain config.
- The **AI Agents** module (`ai_agents`).
- The rest of the AI agent stack this module works within — **AI Assistant API**,
  **AI Chatbot** and **Canvas AI** — which the AI Agents ecosystem provides.

This is an **alpha** release (1.0.0‑alpha4); expect the mode configuration to keep
evolving.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agent_modes -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI and AI Agents
dependencies and updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_agent_modes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agent_modes -y
```

Once enabled, define your modes and grant the module's permission to the roles
that should manage them — see [How to use it](../index.md#how-to-use-it).
