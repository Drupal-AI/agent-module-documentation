# Layout Paragraphs — manual setup guide

**Layout Paragraphs** (`layout_paragraphs`) turns an ordinary Paragraphs reference
field into a visual, drag‑and‑drop page builder. Editors arrange paragraph components
inside layouts (columns and sections) directly on the content form, with a "Choose a
component" dialog, live previews, and reordering — no separate layout tool and no
access to core Layout Builder required.

It works by adding three things. A **field widget** (`layout_paragraphs`) provides the
inline builder experience on the edit form. Two **field formatters** render the result
on the front end: `layout_paragraphs` displays paragraphs wrapped in their chosen
layouts, and `layout_paragraphs_builder` is an experimental in‑place (front‑end)
editing formatter. And a Paragraphs **Behavior** plugin turns any paragraph type into
a layout "section" — its editor picks one of the layouts you've allowed (from core's
Layout Discovery) and fills the regions with other paragraphs. Sections can nest, and
you can require that all top‑level components live inside a section.

As of the 2.x branch the module favors native Drupal hooks and events over custom
hooks: `LayoutParagraphsAllowedTypesEvent` restricts which components are allowed in a
given region, `LayoutParagraphsComponentDefaultsEvent` changes the defaults of a new
component, and `LayoutParagraphsUpdateLayoutEvent` controls when the builder refreshes.
Two submodules extend it: **Layout Paragraphs Library** integrates the Paragraphs
Library (promote a component to a reusable library item and unlink it again), and
**Layout Paragraphs Permissions** adds granular reorder/duplicate/plugin‑config
permissions. It depends on the **Paragraphs** module and core's **Layout Discovery**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Paragraphs), enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — enable a paragraph type as a layout
   section, add the widget and formatter to your field, and the module‑wide settings.

## Where it lives in the admin menu

Most setup happens on your existing content type's **Manage form display** and
**Manage display** screens, and on your paragraph types' behavior settings. The
module also has its own settings forms under **Configuration → Content authoring →
Layout Paragraphs** — the label settings live at
`/admin/config/content/layout_paragraphs/labels` — which require the **Administer site
configuration** permission.
