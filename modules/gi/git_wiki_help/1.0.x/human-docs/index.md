# Git wiki help — manual setup guide

**Git wiki help** (`git_wiki_help`) takes a **cloned Git wiki** (for example a
GitLab project wiki) and presents it as **Drupal help pages**. The result is
similar to core's help topics, but the content comes from your wiki's Markdown
files and lives in its own section named *Git wiki help*, so a project's
documentation is available right inside the admin interface.

An important thing to understand up front: the module does **not** run any Git
commands itself — it never fetches, checks out, or syncs. **You** clone the wiki
into a directory on the server (and update it) manually; the module simply reads
the Markdown files it finds there. It detects the Markdown files in the configured
directory and converts them to HTML using the well‑regarded
[league/commonmark](https://commonmark.thephpleague.com/) library. Images found in
the wiki's uploads are turned into Drupal **managed files** so they render
properly.

The rendered pages use a Twig template that lays each page out in three columns:
the page's table of contents, the page content, and an index of the other wiki
pages. Optionally, adding a Mermaid integration library lets diagrams in your
Markdown render as diagrams.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which brings in the CommonMark library) and enable it.
2. [Configuration](configuration/index.md) — point the module at your cloned wiki
   directory, choose the text format, and set the source link.

## Where it lives in the admin menu

The wiki content appears under **Help** in a section named **Git wiki help**. The
module's own settings form (where you set the wiki directory, text format, and
source URL) is reached from the module's *Configure* link on **Extend** or under
**Configuration**.

## How to use it

1. Clone your Git wiki repository into a directory on the server (see
   [Configuration](configuration/index.md) for where).
2. Configure the directory, the text format, and the origin URL on the settings
   form.
3. Visit the **Git wiki help** section under Help to read the rendered pages.
4. When the wiki changes upstream, pull/clone the updated files yourself — the
   module reflects whatever Markdown is currently in the directory.
