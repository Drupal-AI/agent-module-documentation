# Chromium Tool — manual setup guide

**Chromium Tool** (`chromium_tool`) makes a **headless Chrome/Chromium browser**
available to Drupal as a reusable service. Its headline capability is capturing a
**screenshot of a given URL** — it renders the page in a real browser and returns
an image. It's built primarily as a building block for the AI ecosystem: it
registers a **function/tool that an AI agent can call** to take a screenshot of a
page, and it also exposes a service layer (a browser factory and screenshotter)
that other modules and custom code can drive for browser-based tasks.

Because it's a base service rather than an end-user feature, there's no editor
workflow and no site-wide settings page in the usual sense — you install it so that
the AI module (or your own code) can use it. It depends on the **AI** module
(`ai`) and core's **Image** module (`image`), and it defines a permission that
governs use of the tool.

**Two things to get right before it works:**

- **A Chrome/Chromium binary must be installed** in the environment where Drupal
  runs, and the module needs to know its executable path. That path is set by an
  administrator (with the *Administer site configuration* permission). In a DDEV
  project you'll typically install Chromium inside the web container and point the
  module at that binary.
- **The screenshot service fetches URLs from the server.** It renders whatever URL
  its caller provides using a real browser running in your Drupal environment, so
  treat it as a privileged, server-side capability: keep the runner environment
  trusted and grant the module's permission only to trusted roles. Callers that pass
  in externally-influenced URLs should validate them against their own allow-list.

> **Note:** this project is **not covered by Drupal's security advisory policy**.
> Weigh that against your site's risk tolerance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, provide a
   Chromium binary, and enable the module.

There is **no editor-facing configuration page**. The one setting — the Chrome
executable path — is described in Installation, and the tool is otherwise driven by
the AI module or your own code.

## Where it lives

Chromium Tool adds no menu items for content editors. It provides a service and an
AI tool; the Chrome executable path is set by an administrator, and the tool is
invoked by the AI module or by custom code that calls the screenshot service.
