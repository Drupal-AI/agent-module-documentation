# Content Connected — manual setup guide

**Content Connected** (`content_connected`) is a lightweight authoring aid that
**shows how a piece of content is connected to other content** before you edit or
delete it. Its main purpose is to warn an administrator, at delete time, that a node
is still referenced elsewhere — so you can decide whether it's really safe to remove.
It depends only on core's Field module and provides its own permissions.

The connections are surfaced as a **sub‑tab on node pages**, where the related
content is listed in a table showing *how* each item is connected — through an
**entity reference field**, a **link field**, or a **textarea / long‑text field**
that mentions it. That makes it a simple impact‑analysis tool: before you change or
delete something, you can see what depends on it. The report lists only published
nodes and follows the current user's access, and which roles can see each surface is
controlled by the module's permissions.

The connections also appear on the **node delete form** (so you see what still
references a node before confirming deletion) and via a **Content connected block**
you can place on node pages — each gated by its own permission.

There **is** a small settings page (see below) where you can exclude specific fields
from the scan, but otherwise nothing needs switching on beyond enabling the module
and granting the permissions. This project is covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Settings page

At **admin/config/content/content-connected-settings** (Configuration → Content
authoring → Content connected settings, permission *Administer content connected
settings*) you can tick fields to **exclude** from the scan — separate lists for
entity reference fields, link fields, and long‑text fields. This is optional; by
default every eligible field is scanned.

## How to use it

1. **Grant the permissions.** Under **People → Permissions**, give the roles that
   need it *View content connected page* (for the node sub‑tab) and/or *Access
   content connected* (for the delete‑form table and the block).
2. **Open a node**, then switch to the **Content connected** sub‑tab on that node.
3. **Review the table** of connected content. Each row shows a related item and how
   it's connected — via an entity reference field, a link field, or a
   long‑text/textarea field — so you can gauge the impact before editing or,
   especially, **deleting** the node.
