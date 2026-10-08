# Node Delete Redirect — manual setup guide

**Node Delete Redirect** (`node_delete_redirect`) lets you choose **where a user is
sent after deleting a node**, configured **per content type**. Out of the box Drupal
returns the user to the front page after a delete, which is rarely where an editor
wants to be. With this module you can send them somewhere more useful — the content
list, a dashboard, or a relevant section page. A typical example: after deleting a
news article, return the editor to the main news page instead of the home page.

It's a small, focused module. It depends only on core's **Node** module, and the
redirect destination is set by an administrator on a settings form — it is **not**
taken from the request, so it does not introduce an open‑redirect risk. Access to the
settings is gated by the core **Administer content types** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the redirect per content type
   and set the destination path.

## Where it lives in the admin menu

After enabling, the settings form is at
**Configuration → Content authoring → Node Delete Settings**, with the direct path
`/admin/config/content/node-delete-settings`. You need the **Administer content
types** permission to reach it.
