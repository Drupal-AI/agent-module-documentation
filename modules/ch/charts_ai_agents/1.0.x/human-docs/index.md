# Charts AI Agents — manual setup guide

**Charts AI Agents** (`charts_ai_agents`) connects the **AI Agents** framework to
the **Charts** module so you can build charts by describing what you want in plain
language. It provides an AI agent plugin (extending the AI Agents *Views Agent*)
that can gather information about your Drupal site, send it to your chosen AI
provider, and turn your intent into a working chart configuration — for example,
a Views‑based line chart rendered with Highcharts.

It's aimed at speeding up data‑visualisation setup: rather than clicking through
the Views UI to assemble a chart, you tell the agent what you want and let it wire
up the View and chart style for you. This is an early release
(`1.0.0-alpha1`).

Two things to keep in mind. Because it runs through the AI Agents framework, every
agent action goes through your **configured AI provider, which has a cost**, and
the agent can **modify chart configuration** on your site — so keep its use to
**trusted editors**. And it only makes sense on top of a working Charts setup: you
need AI Core with at least one configured AI provider, the AI Agents module, the
Charts module, and a Charts rendering submodule (such as Charts Highcharts) to
actually display the result.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no dedicated settings form** for this module. You configure and run the
agent through the AI Agents framework, described in "How to use it" below.

## Where it lives in the admin menu

This module adds an AI agent that lives inside the AI Agents framework rather than
a page of its own. You interact with it either through the AI Agents **Explore**
page — `/admin/config/ai/agents/explore?agent_id=charts_views_agent` (the exact
ID is your agent's machine name) — or through the **AI Chatbot**, which you place
as a block on your site.

## How to use it

1. Install and configure **AI Core** with at least one AI provider, plus the **AI
   Agents** and **Charts** modules and a Charts rendering submodule (see
   [Installation](installation/index.md)).
2. Follow the AI Agents documentation to create your Charts AI Agent, using the
   same steps as for the Views Agent.
3. Open the **Explore** page for the agent, or place and use the **AI Chatbot**
   block.
4. Describe the chart you want. For example:

   > Please create a view of Chart Usage Statistics nodes using the chart style
   > plugin. Use the title field as the label and the 7.x field as data provider.
   > Make the chart a line chart using the Highcharts library.

5. Review what the agent creates — remember each request has a provider cost and
   the agent can change chart configuration, so keep this to trusted editors.
