# Paragraphs View Modes — manual setup guide

**Paragraphs View Modes** (`paragraphs_viewmode`) lets an editor choose, for one
individual paragraph, which view mode that paragraph is rendered with — without you
having to create a separate paragraph type for each display variation.

Normally a paragraph type is always shown in whichever view mode the display is
configured to use. If you wanted a "Card" paragraph to sometimes appear wide and
sometimes compact, you would traditionally build two near-identical paragraph types.
This module removes that duplication: it adds a **behavior plugin** to Paragraphs, and
once you enable that behavior on a paragraph type, editors get a "Select which view
mode to use for this paragraph" dropdown when they edit a paragraph. The stored
content is untouched — only the rendered display changes.

You control which view modes editors may pick from, and which one is the default, so
you can offer a curated, approved set of presentations rather than free rein. Because
the choice is saved as a per-paragraph behavior setting, the same paragraph type can
be shown with different layouts or field sets on a case-by-case basis, page by page.

This guide is written for a **human**. For a terse, token-cheap reference aimed at an
AI coding agent — including the exact config keys and the render-time mechanism — read
the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the Paragraphs module.

There is no separate configuration page for this module: everything is set up on the
paragraph type itself, as described below.

## How to use it

The module has no settings form and no configure route of its own. You turn it on and
tune it per paragraph type:

1. Go to **Structure → Paragraph types** (`/admin/structure/paragraphs_type`) and
   edit the paragraph type you want to make switchable.
2. Open its **Behaviors** section and enable **Paragraphs View Modes**.
3. In the behavior's settings choose three things:
   - **Override mode** — the view mode that triggers the switch. When the paragraph
     is being rendered in this mode, the module swaps in the editor's chosen mode.
   - **Available view modes** — the set of paragraph view modes an editor is allowed
     to switch to.
   - **Default view mode** — the mode a new paragraph of this type starts with. It
     must be one of the available modes.
4. Save the paragraph type.

Now, whenever someone edits a paragraph of that type in the paragraphs widget, a
dropdown appears — limited to your allowed modes — letting them pick that paragraph's
display. At render time the module quietly replaces the active view mode with the
editor's pick.

The behavior's settings are stored on the paragraph type's configuration
(`paragraphs.paragraphs_type.<type>`), so they can be exported and deployed with the
rest of your configuration.

## Where it lives in the admin menu

There is no dedicated admin page. The module's only controls live inside each
paragraph type's edit form, under **Structure → Paragraph types → (edit) →
Behaviors**.
