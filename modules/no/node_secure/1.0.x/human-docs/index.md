# Node Secure — manual setup guide

**Node Secure** (`node_secure`) is an extra layer of protection against node
deletion, applied by **content type**. When you protect a content type, *none* of
its nodes can be deleted through Drupal's interface — not from the node's Delete
tab, not from the delete button on the edit form, not from the admin content
listing, not through bulk operations, and not by visiting the deletion URL
directly. It is meant for content that should simply never be removed by accident:
corporate pages, legal or compliance documents, product‑catalogue entries, event
archives, and the like.

The important thing to understand is that this is a **real access boundary**, not
just a hidden button. Node Secure enforces protection through Drupal's node access
system (`hook_node_access()` returning "forbidden" for the delete operation), so
the block is respected on every delete path — the UI, Views Bulk Operations,
programmatic deletes, and the API — rather than only cosmetically hiding controls.
The hidden Delete tabs and buttons are the friendly surface; the access check is
the actual enforcement underneath.

It protects **whole content types**, not individual nodes. If you need to protect
one specific node while leaving others of the same type deletable, that is a
different tool (the Node Keep module). Note also that Node Secure only prevents
*deletion* — it does not restrict editing, and it does not archive or back up
content. It has no dependencies beyond core's **Node** module and adds no external
libraries or services.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types to
   protect.

## Where it lives in the admin menu

The configuration form is at **Configuration → Content authoring → Node Secure**
(`/admin/config/content/node-secure`), where you tick the content types to
protect.
