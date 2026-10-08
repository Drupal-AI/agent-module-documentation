# Embedded Content: Single Directory Components — manual setup guide

**Embedded Content: Single Directory Components** (`embedded_content_sdc`) lets
editors drop **Single Directory Components (SDC)** straight into rich‑text and body
fields. Instead of a developer hard‑coding a component into a template, an editor
can insert a curated component — with its props — into the middle of their content
through the WYSIWYG editor, and it renders in place.

It is a bridge module rather than a standalone tool: it plugs SDC components into
the **Embedded Content** framework, and it depends on that module plus **CL
Editorial**. Embedding follows the Embedded Content framework's own editor gating,
and each component simply renders the markup it defines. The module itself adds no
access‑control layer.

As with any embed mechanism, the safe practice is to **curate which components are
made embeddable**, so editors only ever insert trusted components rather than
anything on the site. There is no dedicated settings form for this module — you
work through the Embedded Content framework and your text formats/editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the Embedded Content and CL Editorial dependencies) and enable the module.

There is **no configuration page** for this module itself. Which components can be
embedded, and where, is governed by the Embedded Content framework and your text
format / CKEditor setup.

## How to use it

Once the module and its dependencies are enabled, the SDC components on your site
become available to the **Embedded Content** framework. Editors insert a component
through the Embedded Content control in the CKEditor toolbar (configured on your
text format), choose the component, and set its props; the component then renders
inside the content. Curate the set of embeddable components so editors only pick
from trusted ones.
