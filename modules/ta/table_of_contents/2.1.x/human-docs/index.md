# Table of Contents — manual setup guide

**Table of Contents** (`table_of_contents`) automatically builds an in‑page navigation block
from the headings inside a long‑text field. Point it at your body field, and it scans the
rendered content for headings (by default every `<h2>`) and produces a linked list of jump
links — perfect for long articles, documentation, knowledge‑base pages, or a lengthy terms‑of‑service
page. Because the list is generated at render time, it stays in sync with the content
automatically; there's nothing for editors to maintain.

It handles the anchor plumbing for you. Headings that already have an `id` are linked directly;
headings without one get a generated id, and a small piece of JavaScript assigns matching ids to
the real headings in the page so the links work. You can target a different heading level or any
CSS selector (say `h3`), build separate tables of contents for different fields or content types,
and place the block in whatever region you like — a sidebar is a common choice. The block respects
the host entity's and field's view access, and it hides itself when the field is empty.

There's no global settings page. You turn it on **per field** (a checkbox on the field's edit
form) and then place the resulting **block** via Block layout. It works on `text_long` and
`text_with_summary` fields, depends on core's **Text** and **Block** modules, and needs the PHP
DOM extension plus the `symfony/css-selector` library (Composer handles the latter). It has no
permissions and no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — enable the TOC on a field, choose the heading
   selector, and place the block.

## Where it lives in the admin menu

There's no dedicated settings page. You enable it on a field under **Structure → Content types →
[type] → Manage fields → [your field] → Edit**, and place the generated block under **Structure →
Block layout** (`/admin/structure/block`), where it appears in the *Table of Contents* category.

## How to use it

At a glance: edit a long‑text field, tick **Enable the TOC block** (optionally change the heading
selector), then place the resulting **TOC for: …** block in a region on the entity's page. The full
walkthrough is in [Configuration](configuration/index.md).
