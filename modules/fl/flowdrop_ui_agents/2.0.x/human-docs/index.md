# FlowDrop UI Agents — manual setup guide

**FlowDrop UI Agents** (`flowdrop_ui_agents`) gives Drupal's **AI Agents** a visual
editor. It brings the FlowDrop drag‑and‑drop canvas to agent building through the
**Modeler API**, so you can design, configure, and manage AI agent workflows —
agents, assistants, tools, and chatbots — from one place instead of filling in
separate edit forms.

What makes it practical is that it **writes directly to the existing AI Agent
configuration entities**. You can open an agent you already have, edit it visually, and
still finish up in the traditional edit forms if you prefer — there is no separate
ecosystem or migration to worry about. From the canvas you can manage the tools
available to an agent (sourced from function‑call plugins and the Tool API — anything
written for the Tool API works here) and edit agent parameters such as the system
prompt, orchestration logic, max loops, and triage settings. Node positions are
derived from the agent configuration itself, so the layout is always tidy. Because it
is decoupled through the Modeler API, you could switch the underlying modeler (for
example to BPMN.io) without losing your agents. It also exposes REST endpoints for
retrieving agents, tools, node metadata, and editor sidebar data.

This module has **no settings page of its own**. Agents and assistants are still
created and stored through the AI Agents / AI Assistant configuration — this module
just provides the visual editor over them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its AI, AI Agents, and Modeler API dependencies.

There is **no dedicated configuration page** for this module. You build agents through
the AI configuration pages described in [How to use it](#how-to-use-it), and the AI
provider and its API key are configured in the
[AI](https://www.drupal.org/project/ai) module — see
[FlowDrop AI Provider](https://www.drupal.org/project/flowdrop_ai_provider) for the
key‑storage and cost guidance.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and make sure you have
   a working AI provider and key configured in the **AI** module.
2. To build or edit an **agent**, go to **Configuration → AI → AI Agent** and click
   **New AI Agent** (or edit an existing one). The FlowDrop visual editor opens over
   that agent's configuration.
3. To build or edit an **assistant**, go to **Configuration → AI → AI Assistant** and
   click **New AI Assistant** (or edit an existing one).
4. On the canvas, wire up tools, set the system prompt and orchestration options, and
   save. Your changes are written straight back to the AI Agent configuration.

> **Scope, cost, and trust.** Agents you build here can call the AI provider (egress
> and per‑token cost) and execute tools and actions against your site. Scope and gate
> each agent's tools carefully — an over‑powered agent driven by untrusted input is a
> real risk — keep provider keys in the AI module's Key configuration, and restrict
> agent building to trusted developers. This module adds no access control of its own.
