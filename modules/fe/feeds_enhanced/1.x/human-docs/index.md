# Feeds Enhanced — manual setup guide

**Feeds Enhanced** (`feeds_enhanced`) extends Drupal's
[Feeds](https://www.drupal.org/project/feeds) module with a collection of extra
plugins that have been used in production and are now offered as a beta release
for community testing. Rather than a single feature, it's a toolbox of fetchers,
parsers and a processor you can mix into your feed types when the built‑in options
don't quite fit.

The extras include:

- An **SFTP fetcher** with **Key module** integration, for secure file transfers.
- An **unconditional HTTP fetcher** that always downloads the complete feed (useful
  for retaining historical data rather than only changed rows).
- An **INI file parser** for legacy configuration files, with section support.
- An **enhanced content‑entity processor** that can collect field values from
  multiple rows into a single field, with improved error handling.
- A **Null Data fetcher / Entity Data parser** combo that uses existing data as the
  source — letting you leverage Feeds for bulk data transformation and companion
  entity generation. The Null Data fetcher skips fetching entirely (data is
  provided programmatically), and the Entity Data parser uses existing entity data
  as its source.
- A **FeedPoolRequestor** plugin manager for reusing pools of Feed entities across
  multiple concurrent programmatic imports (aimed at developers driving imports
  from code).

An optional submodule, **Feeds Enhanced — Token Support**
(`feeds_enhanced_tokens`), adds universal token expansion to *all* Feeds and feed
type text fields — URLs, paths, default values and expressions — so you can build
dynamic, environment‑aware imports (for example date‑based SFTP paths or
user‑specific feed URLs) without custom code. It works automatically once enabled,
via an event subscriber, and is available from release 1.0.0‑beta3.

Because this extends the import pipeline, the usual Feeds caution applies:
importing creates content, so validate and trust your source data, and restrict
who can configure and run feeds. This is a **beta** release — the plugins have
been used in production, but you may hit edge cases in different configurations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and its dependencies, and optionally add the Token Support submodule.

There is **no single settings page** for this module — each plugin is selected and
configured on a feed type, described in "How to use it" below.

## Where it lives in the admin menu

Feeds Enhanced adds no admin page of its own. Its fetchers, parsers and processor
appear as options when you create or edit a feed type at **Structure → Feed
types**. The Token Support submodule needs no configuration — it starts expanding
tokens as soon as it's enabled.

## How to use it

1. Create or edit a feed type at **Structure → Feed types**.
2. Choose the enhanced plugin you need for each stage — for example the **SFTP
   fetcher**, the **unconditional HTTP fetcher**, the **INI parser**, or the
   **Null Data fetcher / Entity Data parser** combo — and configure its settings.
3. If you enabled the Token Support submodule, you can now use tokens in text
   fields on the feed type and on individual feeds (for example a date‑based path
   or a user‑specific URL); they are expanded automatically at import time.
4. Map and run the import as you would with any Feeds importer.
