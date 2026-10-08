# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **AI Agents** module (`ai_agents`) — this module extends its agent
  framework.
- The AI module's **AI Assistant API** submodule (`ai_assistant_api`).

Because those depend in turn on the base **AI** module, you will need an AI
provider configured (with its API key stored via a Key entity / environment
variable) for the agents themselves to function — AI Agent Memory just persists
their state.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_agent_memory -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the AI Agents and AI Assistant
API dependencies and updates shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_agent_memory -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_agent_memory -y
```

Enabling it will pull in `ai_agents` and `ai_assistant_api` if they are not
already on. There is no configuration step — once enabled, agents built on the AI
Agents framework retain their memory across conversation turns.
