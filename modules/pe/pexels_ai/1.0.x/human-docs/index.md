# Pexels AI — manual setup guide

**Pexels AI** (`pexels_ai`) adds **AI‑agent tools** for working with **Pexels**
stock media. Once enabled, an AI agent can **search Pexels** for photos and videos
and **download** the matches straight into Drupal **media entities** — for
example, to auto‑illustrate a piece of content without an editor hunting for stock
imagery by hand. It ships as a set of function‑call plugins that plug into
Drupal's AI Agents framework, and it lives in the **AI Tools** package.

The module builds on the **AI** and **AI Agents** modules (which provide the
agent framework and function calling), the **Key** module (which securely stores
your Pexels API key), and core **Media** (which is where the imported photos and
videos land). After you install it, you set your Pexels API key on the module's
settings page and the search/download tools become available to your agents.

A few things worth keeping in mind: the module talks to the **Pexels API** using
an **API key stored via the Key module** — the correct place for a secret, so
don't paste it into plain configuration. Because AI‑agent actions can drive real
API calls (and therefore usage and potential cost), **scope what agents are
allowed to do** so untrusted input can't trigger unwanted searches or downloads.
And remember that imported media is **third‑party stock** — mind Pexels' licensing
terms for how you use it. Pexels AI has no access‑control role beyond the
permission it provides.

> **Note:** at this version the module is an **alpha** release and is **not
> covered by Drupal's security advisory policy**; parts of it (including the API
> connector) were generated with AI coding agents, per the maintainer's
> disclosure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it along with the AI, AI Agents, Key, and Media dependencies.
2. [Configuration](configuration/index.md) — store your Pexels API key and make
   the tools available to your agents.

## Where it lives in the admin menu

The settings page is at **`/admin/config/pexels_ai/settings`**, where you point
the module at your Pexels API key. Once that is set, the Pexels search/download
tools are available to your AI agents. See [Configuration](configuration/index.md).
