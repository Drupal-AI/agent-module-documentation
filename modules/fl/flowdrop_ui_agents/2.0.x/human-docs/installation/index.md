# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **AI** (`ai`) — the provider abstraction. You will need a configured provider and a
  valid API key.
- **AI Agents** (`ai_agents`) and the AI Assistant API (`ai_assistant_api`) — the
  agent and assistant configuration this editor writes to.
- **Modeler API** (`modeler_api`) — the modeling layer FlowDrop UI Agents plugs into.
- **FlowDrop UI Components** (`flowdrop_ui_components`) — the FlowDrop canvas UI.

These are enabled automatically as dependencies. There are no extra Composer library or
PHP version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_ui_agents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI, AI Agents, and
Modeler API dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_ui_agents -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_ui_agents -y
```

Drupal will enable the required AI, AI Agents, AI Assistant API, and Modeler API
modules as dependencies if they are not already on.

## Verify it worked

Go to **Configuration → AI → AI Agent** and create or edit an agent. The FlowDrop
visual editor should open over the agent's configuration, showing its nodes and tools
on a canvas. If you instead see only the traditional edit form, confirm
`modeler_api` and `flowdrop_ui_components` are enabled.
