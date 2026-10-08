# AI Drush Agents — manual setup guide

**AI Drush Agents** (`ai_drush_agents`) lets you drive the Drupal **AI Agents**
framework from the command line. Instead of using the agents through the browser
UI, you run them with Drush — issuing a prompt, running an agent, and inspecting
its output right in your terminal.

This is aimed at developers and operators. It is handy for scripting agent
tasks, testing how an agent behaves, and folding AI agent runs into deployment
or automation pipelines where a browser isn't available.

An important caution: Drush commands run with **full site privileges**, and
agents can invoke tools (function calls) that read or modify site data. Treat
command-line access to these commands as trusted-operator-only — anyone who can
run them can make an agent act on your site.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the AI Agents dependency.

## Where it lives in the admin menu

Nowhere — this is a command-line tool with no admin page or settings form. You
interact with it entirely through Drush.

## How to use it

Once enabled, run the module's Drush commands to work with AI agents from the
CLI: list and run agents, send prompts, and read the agents' responses in the
terminal. Because the AI Agents framework calls your configured AI provider,
each run may incur provider cost, and the provider's API key must already be
configured in the AI stack (stored as a **Key** entity, never in plain config).

To discover the exact commands the module provides on your version, run:

```bash
drush list --filter=ai
```

Run these commands only in environments and by operators you trust, since agents
execute with full site privileges.
