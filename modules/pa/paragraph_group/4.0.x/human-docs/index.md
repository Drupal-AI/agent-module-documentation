# Paragraph Group — manual setup guide

**Paragraph Group** (`paragraph_group`) tackles a problem every Paragraphs‑heavy
site eventually hits: as field counts grow and paragraphs nest inside paragraphs,
the content‑editing form becomes a long, hard‑to‑navigate wall of fields. Paragraph
Group tidies those forms **without changing your content**, by reorganising how the
edit screen is laid out.

It works along two axes. **Vertically**, it adds a **Paragraph Details Widget** — an
improved widget for paragraph fields built on the native HTML `<details>` element
(the modern successor to the old jQuery UI accordion). Nested paragraphs become
expandable/collapsible accordion sections with navigation buttons, so drilling into
deeply nested content is far easier. **Horizontally**, it can automatically sort a
content type's fields into **tabbed Field Groups**, so a sprawling form becomes a
tidy set of tabs. Together these give complex, nested content real structure while
editing.

To help editors keep their bearings, Paragraph Group can add a lightweight
**Administrative Title** field to paragraphs, which is shown as the summary line of
each collapsed accordion section — so an editor can tell which paragraph they are
looking at without repurposing a real content field. And because the same widget
could apply to hundreds of components across a site, it provides a **settings page**
where site builders apply Paragraph Group's features to all the relevant components
just by ticking checkboxes.

Version 4.x is built on the Paragraphs **Stable** widget rather than the older
Legacy widget, so it inherits that widget's built‑in drag‑and‑drop and broader
compatibility while keeping the clean `<details>` interface. It is compatible with
Drupal CMS 2.0 and its Field Group configuration, depends on the **Paragraphs**
module, and is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings page where you switch on
   the accordion widget, the administrative title and automatic field grouping for
   your components.

## Where it lives in the admin menu

Paragraph Group adds a settings page (route `paragraph_group.form`). You reach it
from **Configuration** — look for the Paragraph Group settings — and its effects
show up on your content **edit forms**, where paragraph fields render as accordion
sections and fields are organised into tabbed groups.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the [Configuration](configuration/index.md) page and tick the components you
   want Paragraph Group to manage — enabling the Paragraph Details (accordion)
   widget, the administrative title field, and automatic field grouping.
3. Edit a piece of content that uses those paragraphs: nested paragraphs now appear
   as collapsible accordion sections, and the form's fields are organised into
   tabs. Nothing about the stored content changes — this is purely an editing‑UX
   improvement.
