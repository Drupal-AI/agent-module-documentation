# CMS Guide — manual setup guide

**CMS Guide** (`cms_guide`) is a "docs-as-code" in-admin help system for content
editors. Editor guide content is written as **Markdown files that live inside a
module**, version-controlled alongside the rest of your site's code, and then
**imported** into the admin UI where editors can read it as clean, deep-linkable
guide pages. If your team already treats documentation like code — pull requests,
diffs, review, CI — this module matches that workflow.

The important thing to understand up front is that **the contrib module ships
empty**. It is a framework, not a book: it gives you the import machinery, the
guide entity type, the admin integration, and the Markdown-to-HTML conversion,
but you supply the actual content. Content can live in the module's own
`content/` directory, or — more powerfully — be contributed by companion modules
through a plugin, so one install can compose a guide from several sources (a
shared "Drupal basics" pack, a site-specific pack, per-client overrides).

Guide pages are a custom entity type available through the admin toolbar, with
Pathauto-generated URLs and structured sub-sections that render inline with
anchor-based sidebar navigation. Markdown is converted to HTML at
import time (using the CommonMark library), and an `{{image_path}}` placeholder
lets each content pack reference its own screenshots. Re-running the importer
reconciles stored entries with the current files on disk — updating existing
pages (matched by slug) and creating new ones — so the admin guide stays in
lockstep with the codebase.

It depends on core **Filter** and **Text**, plus the contrib **Pathauto**
module. It supports Drupal 10 and 11, and provides its own permissions for
reaching the guide and the importer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Pathauto dependency.

There is **no settings form** for this module. The one action you take in the
admin UI is running the importer, described in "How to use it" below.

## How to use it

Because the module ships empty, the workflow is: provide content, import it, read
it.

1. **Provide content.** Either populate the module's own `content/` directory, or
   create a small companion module that contributes a content pack (a dozen lines
   of YAML, PHP, and Markdown — see the project's README for the exact skeleton).
2. **Import it.** Go to `/admin/structure/cms-guide/import`, select which content
   packs to import, and submit.
3. **Read it.** Visit `/admin/cms-guide`, or click **CMS Guide** in the admin
   toolbar, to read the imported guide.
4. **Keep it in sync.** When you change a Markdown file, re-run the importer — it
   updates existing entries (matched by slug) and creates new ones, so the guide
   tracks your code.
