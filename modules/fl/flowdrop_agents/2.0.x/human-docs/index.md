# FlowDrop Agents — manual setup guide

**FlowDrop Agents** (`flowdrop_agents`) is the bridge between Drupal's **AI Agents**
framework and **FlowDrop**, the visual workflow editor. Once enabled, any agent from
the AI Agents ecosystem becomes a first‑class FlowDrop node: you drop an *AI Agent
Executor* node into a workflow and it runs a chosen agent as one step of the flow,
with full status tracking, structured output, and error handling.

That turns AI agents into building blocks you can chain with the rest of your
workflow logic — generate or update content, make configuration changes, run
conversational flows with chat history, or orchestrate multi‑step AI tasks. Agents
can run in *Direct* mode (they create entities immediately) or *Blueprint* mode
(they return a plan for review before anything is written), and the executor reports
states such as *Solvable*, *Needs Answers*, and *Informs* so the surrounding workflow
can branch on the result.

This is an integration module with **no settings page of its own** — the pieces it
connects are configured where they already live. Agents are defined in the AI Agents
module, the model and credentials come from the **AI** module's provider
configuration, and the workflow itself is built in the FlowDrop editor. Because every
agent run calls the configured AI provider (which usually bills per token) and can
act on real site data, keep this capability in the hands of trusted editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its FlowDrop / AI Agents dependencies.

There is **no configuration page** for this module. Its behaviour is driven by the
agents you define in AI Agents, the provider you set up in the AI module, and the
workflow you build in FlowDrop. See the base
[FlowDrop project](https://www.drupal.org/project/flowdrop) and
[FlowDrop AI Provider](https://www.drupal.org/project/flowdrop_ai_provider) for the
provider and cost setup.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Make sure you have
   at least one agent available in **AI Agents** and a working AI provider configured
   in the **AI** module.
2. Open a FlowDrop workflow in the FlowDrop editor.
3. Add an **AI Agent Executor** node and pick the agent you want to run. The node
   discovers all available AI agents on your site automatically.
4. Choose **Direct** mode (act immediately) or **Blueprint** mode (return a plan for
   review), optionally pass chat history for multi‑turn context, and wire the node's
   structured output into the next step of your flow.

> **Cost and trust.** Each agent run goes through the configured AI provider and may
> create, edit, or delete content and configuration. Set provider‑side spend limits
> and restrict who can build and run these workflows.
