# Markdown Docs — manual setup guide

**Markdown Docs** (`markdown_docs`) publishes a folder of Markdown (`.md`) files as
browsable documentation pages inside Drupal's administration interface. If your
team already keeps editor manuals, onboarding notes, or technical guides as
Markdown in your Git repository, this module surfaces that content at
**`/admin/documentation`** without a custom content model or extra editorial
workflow.

It builds the navigation automatically from your documentation folder structure,
uses the first `# H1` in each file as the page title, rewrites relative `.md` links
to internal Drupal routes, and serves relative images through a secure image route.
It adds AJAX‑powered search across your docs, generates a table of contents from
each page's headings, supports styled warning and tip callouts, and renders
[Mermaid](https://mermaid.js.org) diagrams from ```` ```mermaid ```` fenced code
blocks. If there is no `index.md`, it falls back to an auto‑generated overview page.

An optional **editorial mode** adds an admin interface for creating, editing, and
deleting documentation pages and sections (folders) and for uploading assets — so
non‑technical editors can maintain the docs without filesystem or repository
access. That editing capability is gated behind its own permission.

The module is built defensively: every route is permission‑gated, and image
serving is path‑traversal‑guarded (it rejects `..` and null bytes, verifies the
resolved path stays within the docs root, and allows only whitelisted image
extensions). It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the CommonMark library) and enable it.

There is no single settings form to walk through field by field; the small amount
of configuration and the permissions are described below.

## Where it lives in the admin menu

Once enabled, your documentation is browsable at **`/admin/documentation`**. When
editorial mode is enabled, its create/edit/delete interface is reached from that
same documentation area.

## Configuration and permissions

**The documentation directory.** By default the module reads Markdown files from a
`documentation/` directory. You can point it at a different folder through the
module's configuration (`docs_path`, default `documentation`).

**Expected structure.** `index.md` becomes the landing page, each subdirectory
becomes a navigation section, and each Markdown file becomes a page:

```
documentation/
  index.md
  editors/
    getting-started.md
    publishing.md
  admins/
    users.md
```

**Permissions** (set at **People → Permissions**, `/admin/people/permissions`):

- **`access markdown_docs`** — view the documentation pages. Grant to whoever needs
  to read the docs.
- **`administer markdown_docs`** — create, edit, and delete documentation pages and
  sections (editorial mode). Because holders can write files that the site renders,
  grant this only to trusted administrators.

> **Mermaid diagrams:** fenced ```` ```mermaid ```` blocks are rendered as diagrams
> using Mermaid.js, which can be installed locally via npm or loaded from a CDN as a
> fallback.
