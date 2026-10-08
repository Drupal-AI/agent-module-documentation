# MCP Core — manual setup guide

**MCP Core** (`mcp_core`) is a **developer framework** for building custom **MCP
(Model Context Protocol) servers** in Drupal. MCP is the protocol AI agents use to
discover and call tools, prompts, and resources; MCP Core gives module developers a
structured way to expose Drupal capabilities — data and actions — to MCP‑speaking AI
clients through Drupal's plugin system.

It is a foundation to build on rather than a ready‑made feature. On its own it does
not expose anything; instead, other modules use it to publish their own tools,
prompts, and resources. The [CTX](https://www.drupal.org/project/ctx) module is a
reference MCP server built on MCP Core, and the project ships an example submodule
(`mcp_core_example`) you can enable to see the framework in action.

Because an MCP server exposes site capabilities to AI clients, the important
consideration is **scope**: think carefully about exactly what each server you build
exposes, and treat access to it as trusted. There are no hard dependencies, and it
requires **Drupal 11.3 or newer**.

This guide is written for a **human** developer clicking through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, optionally, the example submodule).

There is **no configuration page** — MCP Core is a framework used from code, not a
site‑builder feature with a settings form. What gets exposed is defined by the plugins
that modules build on top of it.

## Where it lives in the admin menu

MCP Core adds no site‑builder settings page of its own. It provides its own
permission and the plugin infrastructure that modules such as CTX (and your own
custom modules) use to define MCP servers. To see a working example, enable the
`mcp_core_example` submodule.
