<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Charts AI Agents (charts_ai_agents) — agent index

AI Agent plugin that generates Drupal **Views rendered as charts** from natural-language prompts. It extends the Views Agent shipped by the AI Agents module and adds Charts style-plugin settings.

- **Version dir:** 1.0.x (installed 1.0.0-alpha1). Core `^10.3 || ^11`. License GPL-2.0-or-later. Package: Charts.
- **Requires (composer):** `drupal/ai_agents ^1.0`, `drupal/charts ^5.1`.
- **Requires (enabled modules):** `ai_agents`, `charts`. Also needs the **`ai_agents_extra`** sub-module (its `ViewsAgent` is the parent class), a configured **AI provider** (AI core), and one Charts rendering sub-module (e.g. Charts Highcharts). See `isAvailable()`.

## What it provides
- One **AiAgent plugin**: id `charts_views_agent`, class `Drupal\charts_ai_agents\Plugin\AiAgent\ChartsViewsAgent` (extends `ai_agents_extra`'s `ViewsAgent`).
- Four **sub-agent prompt YAMLs** under `prompts/charts_views_agent/`: `determineViewsTaskCharts`, `determineFieldsTaskCharts`, `determineFieldConfig`, `determineFilterTypes`.
- No routes, services, permissions, config schema, hooks, install file or Drush commands of its own. It reuses the AI Agents framework's routes/services and the core `administer views` permission.

## Access & entry points
- Gated by the `administer views` permission (`hasAccess()`).
- Explore UI: `/admin/config/ai/agents/explore?agent_id=charts_views_agent` (id is your agent's machine name).
- Or the AI Chatbot block.

## Solution docs
- Plugin behavior, actions, view/chart construction: [agent/plugins/charts_views_agent.md](plugins/charts_views_agent.md)
