# CKEditor Component Library — manual setup guide

**CKEditor Component Library** (`ckeditor_component_library`) lets content editors
embed your design system's components — Component Library (UI Patterns) pattern
variants — directly inside CKEditor 5 rich‑text content. Instead of a body field
being limited to plain prose, an editor can drop in a curated, pre‑built component
(a card, a callout, a media object) and fill in its properties from a simple form,
keeping editorial content visually consistent with the rest of the site.

It builds on two other modules: **Component Library** (`component_library`), where
your patterns and their variants are defined, and **Embedded Content**
(`embedded_content`), which provides the CKEditor 5 framework for embedding
arbitrary content into rich text. This module is the bridge between them.

Setup has two parts, so it does **not** work fully on enable. First a site builder
enables the *Embedded Content* button and filter on a CKEditor 5 text format;
then, on this module's own settings page, they choose which patterns are
embeddable and shape the little form editors see for each one — for example
turning a plain text field into a proper URL field, or locking a property so
editors cannot change it. Only patterns you expose become available in the editor.

One thing to keep in mind: editors pick pattern variants and fill their
properties, so the safety of the rendered output depends on the underlying pattern
templates and the text format's filter configuration. Curate which patterns are
embeddable and grant the configuration permission only to trusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Component
   Library and Embedded Content dependencies, then enable it.
2. [Configuration](configuration/index.md) — enable the Embedded Content button on
   a text format, then choose and shape the embeddable patterns.

## Where it lives in the admin menu

The module's settings form for choosing and shaping embeddable patterns lives at
**Administration → Structure → Component Library → CKEditor embeds**
(`/admin/structure/component-library/ckeditor-embeds`). Reaching it requires the
*Administer component library patterns* and *Use CKEditor 5 embedded content*
permissions.
