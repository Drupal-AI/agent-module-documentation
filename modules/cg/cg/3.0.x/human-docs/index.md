# Content Guide — manual setup guide

**Content Guide** (`cg`) puts editorial guidance right next to the fields it
applies to. You write help and documentation in **GitHub-Flavored Markdown**, and
Content Guide renders it beside the matching widget on your entity forms — so when
an author is creating a node, the conventions for each field appear inline, either
as a tooltip or as an expanded description, instead of living in a separate manual
nobody reads. This improves the authoring experience and guides content creators
through your house style as they work.

Guidance is attached **per field**: on a form display you point a widget at a
Markdown file (via the widget's third-party settings), and at runtime a small
JavaScript behavior fetches and renders that file. The rendered guidance is
processed with the Parsedown library, internal links are resolved to site URLs,
and the output is filtered through Drupal's admin XSS filter. Language-specific
variants (`name.{langcode}.md`) are served automatically when present, so
guidance can be localized per interface language. Event subscribers extend
coverage to **Paragraphs**, **Media**, and **entity-reference** widgets, and the
optional **`cg_field_group`** submodule wires guidance into Field Group.

It depends on core's **Filter** module and the `erusev/parsedown` PHP library
(installed via Composer). Development is sponsored by undpaul.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Parsedown) and enable the module and, if you use Field Group, the submodule.
2. [Configuration](configuration/index.md) — set the base directory for your
   Markdown files and attach a guide to a field.

## Where it lives in the admin menu

The global settings form is at **Configuration → Content authoring → Content
Guide** (`/admin/config/content/content_guide`), gated by **administer content
guide**. Per-field guidance is set on each entity's **Manage form display**.
