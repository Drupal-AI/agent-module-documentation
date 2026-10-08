# AI Agent Modes — manual setup guide

**AI Agent Modes** (`ai_agent_modes`) adds a **mode selector** to the AI agent
experience. A "mode" is a named focus — you pick one, and the module prepends a
scoped instruction to the agent so the orchestrator routes the work to the right
**curated subset of sub‑agents** instead of considering every agent on the site.
In other words, it lets you steer a broad AI agent toward the task you actually
have in mind.

It sits inside the wider Drupal AI agent stack, working alongside the AI, AI
Agents, AI Assistant API, AI Chatbot and Canvas AI modules. On its own it does
not answer questions — it shapes how the underlying agent framework decides which
sub‑agents to use for a given conversation.

Like everything in the AI agent stack, it **sends prompts and content to your
configured AI provider** (data leaves your site for the LLM). Confirm that is
acceptable for your content, and keep the provider credentials as secrets managed
by the AI module. The module adds its own permission so you can control who may
manage the available modes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI‑stack
   dependencies with Composer, and enable it.

## Where it lives in the admin menu

AI Agent Modes provides its own permission for managing modes. Once enabled, the
mode selector appears as part of the AI agent / chatbot interface it plugs into,
and you define the available modes (each mapped to the sub‑agents it should steer
toward) through the module's configuration.

## How to use it

1. Install and enable the module on top of a working AI agent setup (AI + AI
   Agents, with an AI provider configured).
2. Define one or more **modes**, giving each a scoped instruction and the subset
   of sub‑agents it should route to.
3. When using the agent, pick a mode from the selector. The agent is then steered
   toward that mode's curated sub‑agents for the rest of the exchange, giving more
   focused, predictable behaviour than an unscoped agent.
