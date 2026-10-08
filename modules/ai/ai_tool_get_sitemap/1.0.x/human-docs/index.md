# AI Tool: Get Sitemap — manual setup guide

**AI Tool: Get Sitemap** (`ai_tool_get_sitemap`) provides a single **AI Agents
tool** that fetches your site's sitemap so an AI agent can use it. When an agent
needs to know what pages exist on the site — to plan navigation, find a URL, or
reason about the site's structure — this tool hands it the sitemap.

It builds on Drupal's **AI** module and the **Tool** module, which together
provide the agent/tool framework this plugs into. There is no settings page of
its own; the tool becomes available for agents to call once the module is
enabled.

The data-handling point to be aware of is that when an agent uses the tool, the
site's URLs can be **sent to the configured AI provider** as part of the agent's
reasoning — an external call, so confirm that is acceptable. The provider API
key is stored as a secret in the AI module's configuration (a Key entity or an
environment variable), and the call goes over HTTPS. The module has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the AI and Tool modules.

## Where it lives in the admin menu

There is no dedicated configuration page. The module registers a **tool** that
appears in the AI/Tool agent framework (under **Configuration → AI**,
`/admin/config/ai`), where you assign tools to the agents that may use them.

## How to use it

Enable the module, then make the "get sitemap" tool available to an AI agent in
your agent configuration. When the agent runs, it can call the tool to retrieve
the site's sitemap. Because the agent's provider call is external, keep the
provider key stored as a secret and confirm that sending the site's URLs to that
provider is acceptable for your site.
