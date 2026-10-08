# Inpage navigation — manual setup guide

**Inpage navigation** (`inpagenav`) provides a block that builds an in-page
table of contents — a list of jump links — from the headings already on a page.
Instead of hand-writing anchor links for a long article, you place the block in a
region, tell it which heading levels to collect (for example `h2` and `h3`) and
which container to look inside, and it renders a menu that lets readers skip
straight to any section.

The clever part is that the table of contents is built **client-side, from the
live page**: the block passes your settings to a small JavaScript library, which
scans the rendered DOM for matching headings and generates the links. Because it
reads the page as the visitor sees it, the navigation stays in sync with your
content automatically — add or remove a heading and the list updates on the next
page load, with no manual maintenance.

It is a purely presentational block. It adds no permissions of its own beyond
core block placement, makes no external calls, and its only admin page (the
settings form) is gated behind *Administer site configuration*. It works on
Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (which headings to
   collect and which wrappers to include or exclude), field by field.

## Where it lives in the admin menu

The settings form sits at **Structure → Inpage navigation → Settings**
(`/admin/structure/inpagenav/settings/config_settings`), and requires the
**Administer site configuration** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and tell it which heading levels to collect and which
   wrapper class contains them — see [Configuration](configuration/index.md).
3. Go to **Structure → Block layout** and place the **Inpage Navigation Block**
   in the region where you want the table of contents to appear — a sidebar is
   the usual choice.
4. Visit a content-heavy page. The block renders a list of jump links built from
   that page's headings, and clicking one scrolls the reader to that section.

The markup is themed by the module's `inpagenav` Twig template, so you can
override it in your theme if you want to change how the navigation looks.
