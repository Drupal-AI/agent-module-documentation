# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Agents** module (`ai_agents`) — the debugger monitors the agents this
  framework runs. Through it you will also have the base **AI** module and a
  configured AI provider (with its API key held in a Key entity / environment
  variable).

This is a **beta** release (1.0.0‑beta2), intended for development use.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agents_debugger -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI Agents dependency and
updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_agents_debugger -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agents_debugger -y
```

After enabling, grant the module's permission only to trusted developers, and
prefer to keep it enabled on development environments rather than production —
agent traces can expose sensitive prompt, tool and credential data.
