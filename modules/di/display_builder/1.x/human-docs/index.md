# Display Builder — manual setup guide

**Display Builder** (`display_builder`) is an advanced, visual display‑building tool
for ambitious site builders. Rather than arranging fields and regions through
Drupal's standard configuration forms, you compose how content is displayed
visually — with live previews — and, crucially, using your own **design system**:
components, style utilities, icons, themes/modes, and CSS variables, brought
directly into Drupal.

The problem it solves is unifying several separate Drupal display tools under one
modern builder. Depending on which submodule you enable, Display Builder can stand
in for **Layout Builder** (for entity view displays), **Block Layout** (for page
displays), and the **Views** display‑building feature. It is part of the wider **UI
Suite** initiative for implementing design systems in Drupal, and it builds on the
**UI Patterns** modules.

This is a **site‑building / theming tool**, so a few things are worth keeping in
mind. The base module does nothing visible on its own — you must enable at least one
of its submodules to build entity views, pages, or Views. It requires Drupal 11.4
and the UI Patterns field and library modules. And because it is a builder that
composes displays of access‑controlled content, restrict who may use it to trusted
site builders: building a display does not grant access to the data shown in it (the
underlying field and entity access still applies), but the builder itself is a
powerful capability.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the submodules you need.

There is **no single settings page** for Display Builder. You use it in context —
inside the display, page, or Views building experience provided by whichever
submodule you enable — so the "how to use it" is described below rather than on a
configuration page.

## How to use it

1. **Install the base module and its dependencies** (see Installation). On its own
   the base module provides the framework but no building UI.
2. **Enable the submodule(s) for what you want to build:**
   - `display_builder_entity_view` — build **entity view displays** (a replacement
     for Layout Builder on view modes).
   - `display_builder_page_layout` — build **page displays** (a replacement for
     Block Layout).
   - `display_builder_views` — build **Views** output with the builder.
   - `display_builder_ui` — the builder user interface itself.
3. **Bring in a design system.** Display Builder is "design‑system native", so it
   shines when paired with an SDC‑component theme — for example one of the UI Suite
   themes (UI Suite Bootstrap, DaisyUI/Tailwind, DSFR, USWDS) or your own theme with
   SDC components.
4. **Build visually** in the relevant display/page/Views context, using your design
   system's components, utilities, and icons, with dynamic previews as you go.
5. **Restrict access** to trusted site builders, and confirm the displays you
   produce still respect field access on your content.
