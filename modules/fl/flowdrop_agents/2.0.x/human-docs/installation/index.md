# Installation

## Requirements

FlowDrop Agents sits on top of both the FlowDrop and AI Agents stacks, so it needs a
few modules present before it will enable:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **FlowDrop** (`flowdrop`) and **FlowDrop Interrupt** (`flowdrop_interrupt`) — the
  workflow engine and its interruptible‑agent support.
- **AI Agents** (`ai_agents`) — the framework that defines the agents this module
  runs.
- **AI** (`ai`) — the provider abstraction that actually talks to a model. You will
  need at least one AI provider configured with a valid API key (see the
  [FlowDrop AI Provider](https://www.drupal.org/project/flowdrop_ai_provider) project
  for key‑storage and cost guidance).

There are no extra Composer library or PHP version requirements beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/flowdrop_agents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the FlowDrop and AI
Agents dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flowdrop_agents -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flowdrop_agents -y
```

Drupal will enable the required FlowDrop and AI Agents modules as dependencies if they
are not already on.

## Verify it worked

Open a FlowDrop workflow in the FlowDrop editor and look for the **AI Agent Executor**
node in the node palette. When you add it, it should offer a list of the AI agents
available on your site. If the node is missing, confirm `ai_agents` and `ai` are
enabled and that at least one AI provider is configured.
