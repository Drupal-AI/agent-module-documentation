# Flipbook HTML5 — manual setup guide

**Flipbook HTML5** (`flipbook_html5`) turns a PDF uploaded into a file field into
an interactive, page-flipping **flipbook** — a magazine or brochure-style reader
with 3D page turns, embedded right on the node page. It renders entirely in the
browser using **PDF.js** and the **PageFlip** library, so there is no server-side
conversion: the PDF is drawn client-side, keeping server CPU and memory free.

Like other display modules, Flipbook HTML5 is a **field formatter** — you switch a
file field's display to the flipbook reader on **Manage display**, and that is all
the setup it needs. There is no admin settings form and no admin menu item.

One thing to keep in mind: the flipbook follows the file's **normal access
rules**. It has no access-control role of its own, so if a PDF should be
restricted, it must live behind Drupal's **private file** handling — the flipbook
does not add any protection beyond what the file field already enforces.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   PDF module it depends on) and enable it.

There is **no configuration page** for this module — setup happens on your file
field's display, described in "How to use it" below.

## Where it lives in the admin menu

Flipbook HTML5 adds no admin page. You use it entirely from **Structure → Content
types → *(your type)* → Manage display**, where you set a PDF/file field's format
to **Flipbook HTML5 Reader**.

## How to use it

1. On the content type you want, add a **File** field that accepts PDF uploads
   (**Structure → Content types → *(type)* → Manage fields**), or reuse an existing
   one.
2. Go to that bundle's **Manage display** tab.
3. In the **Format** column for the file field, choose **Flipbook HTML5 Reader**.
4. Save. Now any node of that type with a PDF in the field displays it as an
   interactive flipbook with animated page turns.

> **Private PDFs:** if the document should not be public, store it on a private
> file system and rely on Drupal's private-file access — the flipbook renders
> whatever the visitor is already allowed to download.
