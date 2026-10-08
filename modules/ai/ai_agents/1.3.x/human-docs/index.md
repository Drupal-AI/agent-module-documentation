# AI Agents — manual setup guide

**AI Agents** (`ai_agents`) makes a Drupal site *taskable* by AI. It gives you
configurable **agents** that use function‑call **tools** to inspect your site and
perform real administrative actions — creating content types, adding fields,
building taxonomy vocabularies, and more — driven by whichever AI provider you
have configured.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to running your first
agent. If you are looking for terse, token‑cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

![The Configure AI Agents screen listing the three default agents](images/agents-list.png)

## What you get out of the box

Enabling the module ships three ready‑to‑use **triage agents**:

- **Content Type Agent** — creates and edits content types from a description.
- **Field Agent** — adds, edits, and reorders fields on an entity type.
- **Taxonomy Agent** — builds vocabularies and terms.

You can run these as‑is, clone them, override their prompts and tool sets, or
build entirely new agents.

## Before you start

Agents only *do* something once an **AI provider with a valid API key** is
configured (the module talks to providers through the **AI Core** module). Viewing
and editing agents works without a key; actually running an agent does not.

## Contents

1. [Installation](installation/index.md) — install the module, enable it, and pick
   the submodules you need.
2. [Configuration](configuration/index.md) — connect an AI provider and API key so
   agents can run.
3. [Creating an agent](creating-an-agent/index.md) — build or customise an agent
   through the admin form.
4. [Running an agent](running-an-agent/index.md) — drive an agent interactively in
   the Agent Explorer.

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → AI Setup and Configuration**:

- Agents: **Tools & Automation → Configure AI Agents**
  (`/admin/config/ai/tools-automation/agents`)
- Providers / keys: **AI Providers** (`/admin/config/ai/providers`)
- Agent Explorer: **AI Agent Explorer** (`/admin/config/ai/agents/explore`)
