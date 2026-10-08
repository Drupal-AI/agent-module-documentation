# Paragraphs iFrame Preview — manual setup guide

**Paragraphs iFrame Preview** (`paragraphs_iframe_preview`) improves the preview
you see while editing Paragraphs. When a paragraph is collapsed on the node edit
form, Paragraphs can show either a text *summary* or a rendered *preview*. The
trouble with the built-in preview is that it renders using the **admin theme**,
so it rarely looks like the real page. This module renders that collapsed preview
inside an **iframe using your front-end theme**, so what editors see matches how
the paragraph will actually appear on the site. Nested paragraphs are supported
too.

There is nothing to configure in a settings screen — the behavior is switched on
by how you set up the Paragraphs field's *form display*. You tell the field to
show a **Preview** (not a Summary) in closed/collapsed mode, and this module
takes over the rendering of that preview.

One practical caveat from the module's own documentation: only the paragraph's
own markup is rendered inside the iframe, so any CSS or JavaScript that depends on
surrounding page markup or is attached elsewhere on the page won't apply. To make
the preview match the final result closely, you may need to adjust where you
attach your libraries and some of your CSS/JS. It depends on the **Paragraphs**
module and supports Drupal 9 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You enable the behavior on
the Paragraphs field's form display, as described below.

## How to use it

1. Make sure the **Paragraphs** module is enabled and you have a Paragraphs field
   on a content type.
2. Enable Paragraphs iFrame Preview (see [Installation](installation/index.md)).
3. Go to the host bundle's **Manage form display**, open the settings for your
   Paragraphs field, and set **Closed / collapsed mode** to **Preview** (not
   **Summary**). The iframe preview only applies when Preview is selected.
4. For the best experience, also set **Default edit mode** to **Closed /
   collapsed**, so the preview shows as soon as the edit form loads.
5. If the preview doesn't look quite like the front end, revisit where your theme
   attaches its CSS and JavaScript — remember only the paragraph markup is
   rendered inside the iframe.
