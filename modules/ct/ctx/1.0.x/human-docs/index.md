# CTX — manual setup guide

**CTX** (`ctx`) exposes your Drupal site's structure and context to AI coding
assistants over the **Model Context Protocol (MCP)**. Instead of manually
describing your data model to an agent, you connect the agent to CTX and let it
explore your entity types, fields, bundles, configuration, database schema, and
plugin definitions on its own.

Under the hood it provides MCP tools (surfaced via Drush) that read structure,
configuration and state and hand them to the agent. It is built on
[MCP Core](https://www.drupal.org/project/mcp_core) (`mcp_core`) and also depends
on core's **File** module. It requires **Drupal 11.3 or newer**.

Because CTX surfaces site context and runs through Drush at the command line,
treat access to it as **trusted‑operator‑only** — anyone who can run these
commands can read the site's structure. There is no end‑user UI to configure;
the setup is enabling the module and wiring it into your agent's MCP client.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its MCP Core dependency.

There is **no configuration page** for this module — you use it by connecting an
AI agent's MCP client to the tools CTX exposes, as described in "How to use it".

## How to use it

CTX is a bridge between your site and an AI coding assistant:

1. Install and enable the module (see [Installation](installation/index.md)),
   which also brings in MCP Core.
2. Point your AI agent's MCP client at the site's MCP server (provided by MCP
   Core). CTX registers its context tools there.
3. Ask the agent to explore the site — it can now enumerate entity types, fields,
   bundles, configuration, the database schema, and plugin definitions through
   CTX rather than you describing them by hand.

Keep this access limited to trusted operators, since the tools reveal how the
site is built.
