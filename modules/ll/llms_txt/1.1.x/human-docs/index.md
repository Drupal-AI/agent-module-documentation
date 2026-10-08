# /llms.txt — manual setup guide

**/llms.txt** (`llms_txt`) serves a dynamic **`/llms.txt`** file for your site — a
Markdown "homepage for large language models". The
[llms.txt convention](https://llmstxt.org) is an emerging standard that gives AI
agents and crawlers a clean, well-organized summary of your site and pointers to the
content that matters, instead of leaving them to scrape HTML. This module lets you
author and manage that file from the Drupal admin.

It assembles the file from two sources so you can keep the generic parts in code and
the site-specific parts in the database. The **configuration** body (edited on the
settings form) is stored as exportable Drupal config and supports **tokens**, so it
is ideal for the structural skeleton that should be identical across all
environments. The **sections** are `llms_txt_section` content entities stored in the
database, so per-instance additions stay out of your exported config. Sections are
rendered after the config body as `## Title` blocks, ordered by weight.

A nice touch is a set of Markdown-menu tokens: `[llms_txt_markdown_menu:main]` (and
one per menu) renders a whole Drupal menu as a nested Markdown link list, so you can
drop a navigation map straight into your llms.txt. When the optional
`markdownify_views` module is installed, additional tokens can render Views output as
Markdown too.

The module needs configuration to be useful (you author the content), and it needs
one **web server** change: because `.txt` files in the web root are often served or
blocked by the server before Drupal sees them, you must configure your web server to
route `/llms.txt` to Drupal. It requires core **Text**, and it conflicts with the
`llmstxt` and `llms_txt_generator` modules — enable only one of these.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and configure your web server to serve `/llms.txt`.
2. [Configuration](configuration/index.md) — author the config body, manage
   sections, and use the Markdown-menu tokens.

## Where it lives in the admin menu

- **Content → llms.txt** (`/admin/content/llms-txt`) — the configuration form where
  you author the tokenised top-matter body.
- **Content → llms.txt → Sections** (`/admin/content/llms-txt/sections`) — the
  collection where you add, edit, reorder, and delete the database-stored sections.
- The public endpoint itself lives at **`/llms.txt`** and is served as
  `text/markdown`.
