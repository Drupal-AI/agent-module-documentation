# AI Dashboard — manual setup guide

**AI Dashboard** (`ai_dashboard`) turns Drupal's **Configuration → AI** page
(`/admin/config/ai`) into a single landing dashboard for the
[AI](https://www.drupal.org/project/ai) module ecosystem. From one screen a site
builder can add an AI provider and its API key, check operational status, browse
recommended AI recipes, jump to AI configuration links, and open documentation. It is
part of the AI project and is the anchor page for AI setup in Drupal CMS.

The module does not add a page of its own. Instead it takes over the AI module's
existing `/admin/config/ai` route and renders a **Dashboard** (built with Layout
Builder) in its place. That dashboard lays out six blocks: **Setup** (a form to pick a
provider and save its API key), **Features** (recommended AI recipes, via Project
Browser), **Status** (which model capabilities the configured providers offer),
**Extensions** (a focused module list showing only AI‑related packages),
**Configuration** (the AI admin menu links), and **Documentation** (doc links gathered
from every module).

It also defines a lightweight way for any module to contribute a documentation link
(by shipping a small YAML file) and a service that reports whether a given provider
already has its key configured. Because the dashboard is a Layout Builder entity, you
can rearrange, add, or remove its blocks to suit your site.

AI Dashboard defines **no permissions of its own** — the page is gated by the AI
module's **Administer AI** permission — and has no separate settings form. This guide
is written for a **human**; if you want terse, token‑cheap references for an AI coding
agent — the block ids, the documentation plugin type, and the status service — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with AI, Dashboard, and
   Project Browser) and enable it.
2. [Configuration](configuration/index.md) — using the dashboard, adding a provider,
   editing its blocks, and pointing the recommended‑recipes source at your own feed.

## Where it lives in the admin menu

The dashboard replaces **Configuration → AI** (`/admin/config/ai`) — that is where you
reach it, guarded by the **Administer AI** permission. To edit the dashboard's layout,
go to **Structure → Dashboards → AI Dashboard** and use Layout Builder.
