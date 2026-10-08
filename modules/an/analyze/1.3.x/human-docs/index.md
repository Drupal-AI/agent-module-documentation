# Analyze — manual setup guide

**Analyze** (`analyze`) adds a single **"Analyze" tab** to your content entities and
gives developers a plugin API for putting information on it. Instead of five different
modules each adding their own block, tab, or column to explain how a piece of content is
doing, Analyze provides one consistent place where editors can look — word counts,
readability, traffic, SEO, link health, AI insights, and more — as summary gauges and
tables, with fuller reports one click deeper.

The core module is a **framework**: it supplies the tab, the access control, the
per‑content‑type configuration, and the display components (a spectrum "gauge" and a
key‑value "table"). The actual metrics come from **`@Analyze` plugins**, several of which
ship as submodules — **Basic Content Info** (word and image counts), **Node Statistics**
(page views from core's statistics), and **Google Analytics** — plus an example plugin
that documents the API. Other modules add analyzers for Search Console, broken links, and
AI‑based brand voice, sentiment, marketing, and security audits.

Analyze needs a little configuration to be useful: after enabling it and the analyzers
you want, you go to its settings form and toggle **which analyzers run on which content
types**. Then editors open any content entity, click the **Analyze** tab, and their data
is there. Version 1.3.0 also adds a **centralized batch pipeline** (run analyzers across
lots of content at once, from a form or the `drush analyze:batch` command), per‑bundle
analyzer settings, and AI coding‑assistant skill files installable via
`drush analyze:setup-ai`.

Two things are worth keeping in mind. The tab is per entity and the underlying data
often is not free — an analyzer that fetches analytics makes an external request on an
admin page load, so caching and graceful failure are the plugin's responsibility. And
the Analyze tab is designed for **information, not controls**: its value is that an
editor can look without changing anything.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module and
   the analyzer submodules you want.
2. [Configuration](configuration/index.md) — the settings form, choosing which analyzers
   run on which content types, per‑bundle settings, batch processing, and permissions.

## Where it lives in the admin menu

Two admin screens sit under **Configuration → Content authoring**:

- **Content Analysis** (`/admin/config/content/analyze-settings`) — the main settings
  form (route `analyze.analyze_settings`), where you enable analyzers per content type.
- **Batch Analysis** (`/admin/config/content/analyze-batch`) — run analyzers across many
  entities at once.

Both require the **Administer analyze** permission.

## How to use it

The **Analyze** tab appears on every entity type that has a canonical URL (nodes, and
others). To view a tab a user needs the **View analyze reports** permission *and* the
entity's type/bundle must have that analyzer enabled in the settings. Summaries render as
a gauge or a small table; clicking through opens the full report as a secondary tab.
