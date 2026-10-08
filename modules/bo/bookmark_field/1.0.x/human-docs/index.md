# Bookmark Field — manual setup guide

**Bookmark Field** (`bookmark_field`) lets an entity be reached by a bookmark.
It provides a **field** (and a **block**) that gives content a shareable
bookmark identifier/URL, so users can bookmark a specific entity and return to it
later through that reference. It depends on core's **Field** and **Block**
modules.

You use it by adding the bookmark field to a content type (or placing the block),
and it renders a shareable bookmark link for the content. There is no dedicated
admin settings page — you work through the standard Field UI and Block layout.

**A note on security.** A bookmark URL is a *way to reach* an entity, but it does
**not** grant access. The entity's normal access control still applies when the
bookmark is followed — a bookmark to restricted content will not bypass
permissions. Just don't treat an unguessable bookmark as a secret capability for
truly sensitive content; it has no access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You add the field at **Structure → Content
types → (a type) → Manage fields** (`/admin/structure/types`), and you place the
block at **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Add the bookmark field to a content type via **Manage fields**, or place the
   bookmark block from **Block layout** — whichever fits your case.
2. Adjust the field's form and display settings under **Manage form display** and
   **Manage display** as needed.
3. On the rendered content, users get a shareable bookmark link they can save and
   follow back to that entity — with the entity's normal access still enforced.
