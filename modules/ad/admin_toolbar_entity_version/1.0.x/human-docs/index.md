# Admin Toolbar Entity Version — manual setup guide

**Admin Toolbar Entity Version** (`admin_toolbar_entity_version`) shows
**version/revision information about the entity you're currently viewing** right in
the site Toolbar. When you're looking at a node (or another entity), it displays which
revision/version you're on, so editors and developers can tell at a glance which
version of the content is in front of them — without digging into the revisions tab.

It's a small administration/UI helper that depends on core's Toolbar module. The
information it shows simply reflects the entity being viewed in your admin/editor
context; it has no access‑control role and doesn't change anything about the entity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings form. Once enabled, the version information appears in the
Toolbar automatically while you view an entity.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. View any entity that has revisions — for example a node.
3. Look at the Toolbar: it shows the version/revision information for the entity
   you're viewing, so you can confirm at a glance which version you're on.
