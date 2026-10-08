# Essential Node Protection — manual setup guide

**Essential Node Protection** (`essential_node_protection`) stops the nodes your
site depends on from being deleted by accident. If a content editor (or even an
admin) deletes the node you've configured as the **front page**, the **403 access
denied** page, or the **404 not found** page, parts of your site quietly break.
This module removes that risk.

It works by swapping in a custom node access handler that forbids the **delete**
operation on any node currently configured as one of those three "essential" pages,
and it also removes the **Delete** button from those nodes in the UI. Only deletion
is affected — viewing and editing those nodes behave exactly as before, and every
other node falls through to normal core node access. The design is *fail‑closed*: the
handler can only ever add a "deny delete", never grant access it shouldn't, so it
cannot open anything up.

You choose which of the three slots to protect, and they can be toggled
independently. By default all three (front page, 403 and 404) are protected. What
it does **not** do is let you mark arbitrary individual nodes as protected — its
scope is specifically the front/403/404 pages defined in your site settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which of the front / 403 / 404
   pages to protect.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Essential Node Protection**
(`/admin/config/system/essential-node-protection`), reachable by users with the
**Administer essential node protection configuration** permission.

## How to use it

After enabling, the front page, 403 and 404 pages are protected from deletion out
of the box. Open the settings form if you want to turn protection off for any of
the three slots. If you later change *which* node is the front / 403 / 404 page (in
your site's path settings), clear caches so the protection tracks the new node.
