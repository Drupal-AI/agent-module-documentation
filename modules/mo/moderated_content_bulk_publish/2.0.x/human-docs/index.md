# Moderated Content Bulk Publish — manual setup guide

**Moderated Content Bulk Publish** (`moderated_content_bulk_publish`) adds bulk
moderation actions to the **Content** listing at `/admin/content` for content that
runs Drupal's core Content Moderation editorial workflow. From a single screen you can
select many nodes and, in one operation, publish their latest revision, unpublish or
archive their current revision, or pin/unpin them — without opening each node one at a
time.

What sets this apart from Drupal's built‑in "Publish content" bulk action is that it
drives each item through its proper **workflow states** rather than just flipping the
published flag. Publishing actually promotes the latest pending revision to the
published default revision; archiving moves content into your archived state; and so
on. The transitions are also **translation‑aware** — on a multilingual site, a single
bulk action applies the moderation state to *every* translation of a node, which is
exactly what you usually want. The actions work on media entities as well as nodes.

The module builds on **Views Bulk Operations** and core's **Content Moderation** and
**Workflows** modules. Because Drupal core doesn't decide which of your custom
workflow states count as "published", "unpublished", or "archived", the module lets
you map those on a small settings form, along with a few quality‑of‑life options like
a confirmation dialog before bulk operations run. Five separate permissions let you
hand editors just the operations they should have.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it pulls
   in Views Bulk Operations and Pathauto) and enable it.
2. [Configuration](configuration/index.md) — adding the bulk actions to the content
   view, the settings form, and the permissions.

## Where it lives in the admin menu

Two places matter:

- The **bulk actions themselves** appear on the **Content** listing
  (`/admin/content`) once you add them to that view.
- The **settings form** is at **Configuration → Content authoring → Moderated content
  bulk publish** (`/admin/config/content/moderated-content-bulk-publish`).

## How to use it

In short: install and enable the module, add the bulk operations to the content view,
grant editors the permissions for the operations they should have, and (if your
workflow uses custom state names) map those states on the settings form. Then on
`/admin/content`, tick some rows and choose an action. The full walkthrough is in
[Configuration](configuration/index.md).
