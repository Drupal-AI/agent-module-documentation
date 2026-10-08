# AI Site Manager — manual setup guide

**AI Site Manager** (`ai_site_manager`) lets an administrator describe a
site-management task in plain English — "enable the Metatag module", "clear all
caches", "turn on maintenance mode" — and turns that request into **one
specific, previewed command** that has to be explicitly confirmed before it
runs. It is deliberately a guided, human-in-the-loop assistant, not an
autonomous agent that acts on its own.

Behind the scenes the request is interpreted into a single command, action, and
set of parameters. Interpretation is done by the configured AI provider (through
the AI module) or, when no provider is set up or the AI's confidence is too low,
by plain keyword matching — so it still works without an AI provider. Before
anything happens you are shown an exact, human-readable preview with a **risk
level**. Version 1 supports three commands: **enable/uninstall a module**,
**clear caches**, and **toggle maintenance mode**.

Safety is built into the design. Anyone with *access AI site manager* can type a
request and see the preview, but only users with the restricted *administer AI
site manager* permission can confirm and execute — and that permission is
re-checked at execution time, not just when the preview is shown. A configurable
flood limit caps how many requests a single user can make, so one account cannot
run up unbounded AI-provider cost. Every interpretation and execution is written
to an **audit log**. The module stores no API key of its own; all provider calls
go through the AI module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the dashboard, the settings form
   (provider, model, flood limit), the two-step safety model, and the audit
   history.

## Where it lives in the admin menu

- **Configuration → AI → Site Manager** (`/admin/config/ai/site-manager`) — the
  chat dashboard where you type a request and see its preview. Needs *access AI
  site manager*.
- **Configuration → AI → Site Manager → Settings**
  (`/admin/config/ai/site-manager/settings`) — provider/model and the flood
  limit. Needs *administer AI site manager*.
- **Reports → AI Site Manager History**
  (`/admin/config/ai/site-manager/history`) — the audit log of every
  interpretation and execution. Needs *administer AI site manager*.

## How to use it

Open the dashboard, describe the task, and read the preview and its risk level.
If you hold the administer permission, confirm to execute; if you only hold the
access permission, you can preview but not run anything. Check the history under
Reports afterwards for a record of who requested what and how it turned out.
