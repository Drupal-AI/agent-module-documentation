# Paragraphs Accordion — manual setup guide

**Paragraphs Accordion** (`paragraphs_accordion`) gives you a ready‑made paragraph
type that renders as an **accordion** — a set of collapsible title/text sections —
on display. It is the quickest way to let editors add FAQ‑style, expand‑and‑collapse
content to a page without anyone having to build the paragraph type, its fields, and
its display by hand.

The type is pre‑configured around a compound **text‑with‑title** field, so an editor
simply enters multiple title/text pairs and, when the content is displayed, those
pairs become the collapsible items of an accordion. It is a content‑editing and
display convenience: the accordion content is authored and rendered normally, and the
module has no access‑control role.

It ships with no dependencies of its own beyond Drupal, works across Drupal 8
through 11, and is covered by Drupal's security advisory policy. (You will, of
course, want a paragraph field somewhere — for example on a content type — that can
reference this accordion paragraph type.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it simply provides a pre‑configured
paragraph type. See "How to use it" below.

## Where it lives in the admin menu

Paragraphs Accordion adds no settings page. It installs a new paragraph type you can
see at **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`), and you
use it by adding that type wherever you have a paragraph field.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure the entity you want the accordion on (for example a content type) has a
   **paragraph reference field** that allows the accordion paragraph type. If you use
   the [Paragraphs](https://www.drupal.org/project/paragraphs) module's standard
   setup, add or edit a paragraph field and include the accordion type in its allowed
   bundles.
3. Edit a piece of content, add an **accordion** paragraph, and enter your
   **title/text pairs** — each pair becomes one collapsible section.
4. View the content: the pairs render as an accordion of expandable title/text
   sections, ideal for FAQs and similar content.
