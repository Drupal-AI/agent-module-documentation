# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- The **AI Agents** module (`ai_agents`) — this module extends its Views Agent.
- The **AI Core** module with **at least one AI provider** installed and
  configured — the agent needs a provider to talk to.
- The **Charts** module (`charts`) plus a charting submodule such as **Charts
  Highcharts**, so the chart the agent builds can actually be displayed.
- No third‑party PHP or JavaScript libraries of its own.

Because this module needs an AI provider, you will typically be handling a
provider **API key**. Store it in an environment variable rather than in code —
with DDEV, `ddev dotenv set .ddev/.env --<provider>-api-key=<value>` and then
`ddev restart`, and reference it through a **Key** entity as the AI provider
configuration expects. See the project's AGENTS.md for the exact pattern.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_ai_agents -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AI Agents and
Charts dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_ai_agents -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_ai_agents -y
```

Make sure AI Core (with a configured provider), AI Agents, Charts, and a Charts
rendering submodule are all enabled and configured first.

## Verify it worked

Follow the AI Agents documentation to create your Charts AI Agent, then open its
Explore page at
`/admin/config/ai/agents/explore?agent_id=charts_views_agent` (the ID will be your
agent's machine name). Give it a prompt to create a chart from an existing content
type and confirm a working chart View is produced.
