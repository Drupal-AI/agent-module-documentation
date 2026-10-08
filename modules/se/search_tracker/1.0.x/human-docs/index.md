# Search Tracker — manual setup guide

**Search Tracker** (`search_tracker`) captures and displays each visitor's recent
search terms using their browser's **localStorage**. Unlike traditional search
history modules that store data server-side, it keeps every user's search history
entirely in their own browser — so recent searches can be shown back to them as
clickable suggestions, without any server-side storage and without adding load to
your database.

It solves a common user-experience wish: letting people quickly revisit the
searches they ran a moment ago. Search Tracker automatically detects and stores the
search term from a URL parameter you configure, prevents duplicate consecutive
entries, and exposes a **display block** that lists recent searches as links so a
visitor can re-run any of them in one click. It even includes a "Clear History"
control so users stay in charge of their own data. It is lightweight,
mobile-friendly, and works entirely with Drupal core — **no other modules or
libraries are required** — on **Drupal 9, 10, or 11**.

This module needs a little configuration and block placement before it does
anything visible: you point it at the URL parameter your search uses, choose which
paths activate tracking, and place the display block. It provides an **Administer
Search Tracker settings** permission for controlling who can configure it. Because
all history is stored client-side, it needs JavaScript enabled and a modern browser
with localStorage support.

A privacy note that is also its main selling point: nothing is logged
server-side. Each visitor's history lives only in their own browser, which makes
this a good fit for sites with strict privacy requirements that want to avoid
server-side search logging entirely.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the search parameter, activation
   paths, and history limit, then place the display block.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Search Tracker**
(`/admin/config/search/search-tracker`). The display block is placed from
**Structure → Block layout** (`/admin/structure/block`), and its permission is
managed on **People → Permissions** (`/admin/people/permissions`).
