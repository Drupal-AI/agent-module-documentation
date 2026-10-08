# LocalGov Publications — manual setup guide

**LocalGov Publications** (`localgov_publications`) turns long formal documents —
strategies, plans, annual reports — into structured **HTML publications** with
chapters and navigation, so a council can publish readable, accessible web pages
instead of a PDF. HTML publications are searchable, work well on mobile, meet
accessibility obligations, and can be updated one chapter at a time.

The module builds on Drupal's core **Book** module for chapter hierarchy and
navigation, **Pathauto** for tidy chapter URLs, and LocalGov's own media and
paragraph components for the content within each chapter. It provides two content
types: **Publication page** (the pages that make up a publication, optionally
arranged in a hierarchy that becomes the in‑publication navigation) and
**Publication cover page** (an optional landing/link page that can point to one or
more publications and hold a downloadable document such as a PDF for people who
prefer one). Single‑page publications are supported too, with in‑page jump links
generated from the page's headings.

To import existing PDFs into publications automatically, pair this with the
**LocalGov Publications Importer** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   contrib Book module) and enable the module and its LocalGov dependencies.

This module has **no central settings form**. You configure it by creating content
and by managing publication structure through the Book‑based reorder screen (below).
It provides one permission, **access publication views**, which governs the
administrative publication listings — grant it to your editorial roles at **People →
Permissions**.

## Where it lives in the admin menu

- Create content at **Content → Add content → Publication page** (and, optionally,
  **Publication cover page**).
- Reorder a publication's chapters at **Structure → Publications →
  *(publication)*** (`/admin/structure/publications/{node}`). This screen reuses
  core Book's outline editor, so it requires both the **Administer book outlines**
  permission and view access to the node.
- The **access publication views** permission (administrative listings) is set at
  **People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Create a **Publication page** for the first chapter, then add further
   Publication pages, nesting them to form the publication's structure. The
   hierarchy drives the contents list and next/previous navigation.
3. For a single‑page publication, use `h2` headings — the module adds in‑page jump
   links to them automatically.
4. Optionally create a **Publication cover page** to act as a front door: link it to
   one or more publications and attach a downloadable PDF for readers who want one.
5. Reorder chapters when needed from **Structure → Publications**.

Because it is part of the LocalGov Drupal distribution, it expects the LocalGov
content configuration (for example the distribution's text formats) — install it as
part of a LocalGov site rather than on bare Drupal core.
