# AI Playwright — manual setup guide

**AI Playwright** (`ai_playwright`) gives Drupal's AI agents "eyes" on your own
site's rendered pages. It uses **Playwright** driving headless Chromium to open a
page of the site and return what a browser actually sees — a screenshot, the page
title, the visible text, and any console errors. That lets an AI agent (for
example the Drupal Canvas AI assistant) verify what it just built, rather than
reasoning only about the underlying markup. It is config-driven and
framework-agnostic about the front end.

It is an add-on to the AI Agents part of the Drupal AI ecosystem, depending on
the core **AI** module, the **AI Agents** module, and core's **File** module. It
targets a recent Drupal (11.2+).

Because it launches a headless-browser subprocess and renders pages of your site,
you should keep the Playwright/runner environment **trusted**. Access is gated by
two permissions: **Use AI Playwright** (`use ai playwright`) for the agents/users
that capture pages, and **Administer AI Playwright** (`administer ai playwright`)
for setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, confirm its AI Agents dependency, and set up the Playwright runner.

## Where it lives in the admin menu

Setup lives under the module's own administration, gated by **Administer AI
Playwright** — this is where you point it at the base of the site to render and
configure the runner. The AI agent side is wired through the **AI Agents**
module.

## How to use it

Configure the runner and the base URL of the site it should open, then let your
AI agents call the tool to render a page and get back a screenshot, title,
visible text, and console errors. The agent uses that to check what it built.
Grant **Use AI Playwright** to the agents/users that should be allowed to capture
pages, and keep the runner host trusted since it executes a browser subprocess.
