# Paragraphs Title Manager — manual setup guide

**Paragraphs Title Manager** (`paragraphs_title_manager`) gives you one central
place to control the **text alignment of title fields** across all your Paragraph
types. On sites that lean heavily on Paragraphs for structured content, keeping
headings aligned consistently usually means theme overrides, per‑bundle CSS, or
template logic. This module replaces all of that with a configuration screen: pick
an alignment per field (or apply one alignment to many fields at once) and the
module handles the rest at render time.

It focuses deliberately on **title‑like fields** — any field whose machine name
contains the substring `title` (for example `title`, `sub_title`, `title_one`,
`section_title`). This strict rule keeps behavior predictable and avoids
false positives: fields like `subtitle`, `heading`, or `label` are intentionally
ignored. Detection is automatic — the module inspects every Paragraph bundle's
fields, and newly created title fields show up in the configuration UI without a
cache rebuild.

When content is rendered, the module adds a CSS class in the form
`ptm-title-align-{alignment}` to the paragraph's wrapper and exposes matching Twig
variables (a wrapper‑level `paragraphs_title_manager_classes` and per‑field
variables such as `field_title_alignment_class`), so your theme can apply the
alignment consistently without custom logic. A mobile‑specific override class may
be added for certain bundles. It depends on the Paragraphs module and defines its
own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant its permission.
2. [Configuration](configuration/index.md) — the global title‑alignment settings
   screen, field by field.

## Where it lives in the admin menu

The configuration screen sits at **Configuration → Content authoring →
Paragraph Title Settings** (`/admin/config/content/paragraph-title-settings`).
Only users with the **Manage Paragraphs Title Alignment** permission can open it.
