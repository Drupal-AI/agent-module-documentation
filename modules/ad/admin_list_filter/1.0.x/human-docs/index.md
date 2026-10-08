# Admin List Filter — manual setup guide

**Admin List Filter** (`admin_list_filter`) adds a quick, client‑side filter box to
Drupal's admin listing pages. When you have long admin tables — the content list, the
people/users list, configuration listings — finding one item usually means scrolling or
using a heavier exposed filter that reloads the page. This module drops a small search
box above those tables that narrows the visible rows instantly as you type, entirely in
the browser, with no page reload.

Because the filtering happens client‑side, it only ever hides or shows rows that are
already on the page; it does not change what data loads, and it has no content or
access‑control role of its own. It is purely an admin‑UX convenience that makes long
lists faster to work through.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings form to configure. Once enabled, the filter box appears
automatically on the admin listing pages it supports.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open a long admin listing — for example the content, users, or a configuration
   list.
3. Start typing in the filter box that appears above the table. The rows narrow to
   matches instantly, with no page reload. Clear the box to show every row again.

Note that the module provides its own permission, so you can control which roles see
the filter box on the **People → Permissions** page
(`/admin/people/permissions`).
