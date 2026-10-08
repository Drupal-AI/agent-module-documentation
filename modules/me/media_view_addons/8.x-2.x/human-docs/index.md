# Media View Add-ons — manual setup guide

**Media View Add-ons** (`media_view_addons`) answers a question every media library
eventually raises: *"which pages actually use this image?"* It adds a Views field
to the media administration listing that shows, for each media item, a set of edit
links to the **top‑level nodes** that reference it — following the trail through
paragraphs and other entity‑reference‑revision fields until it reaches the owning
node. So before you delete or replace an asset, you can see at a glance where it is
used and jump straight to editing those pages.

Under the hood it scans your site's image fields and entity‑reference‑revision
fields (the type commonly used to attach paragraphs to nodes), then walks those
references recursively — up to five levels of paragraph nesting — to find the node
at the top of each chain. When more than one node references the same media, the
links appear as an operations‑style dropdown. Other modules can adjust the link
text and URLs via a provided hook (for example to append domain information on a
Domain Access site).

The module adds **no settings page, no permissions, and no routes** of its own —
it is a Views field plugin. You switch it on by editing the media View and adding
its field. It works on Drupal 8, 9 and 10 and needs core **Media** and **Views**,
plus the **Entity Reference Revisions** module for the paragraph traversal.

> **Note.** This module is **not covered by Drupal's security advisory policy**.
> The dynamic queries it runs use field and table names drawn from your field
> configuration (not from request input), so they are not user‑controlled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Media, Views and Entity Reference Revisions.

There is **no configuration page** for this module — it has no settings form. You
enable the feature by adding its field to the media View, described in "How to use
it" below.

## Where it lives in the admin menu

Media View Add-ons adds no admin settings page. You configure it entirely from the
Views UI at **Structure → Views**, editing the **Media** view
(`/admin/structure/views/view/media`), and the resulting column appears on the
media admin listing at **Content → Media** (`/admin/content/media`).

## How to use it

1. Go to **Structure → Views** and edit the **Media** view (the one that powers
   `/admin/content/media`), for example at
   `/admin/structure/views/view/media/edit/media_page_list`.
2. Add a **Media: ID** field and set it to **Exclude from display** — the add‑on
   uses the media ID to build its links.
3. Add the **"Media view add-ons top level node"** field (listed under **Media
   View Add-ons**).
4. Save the view.

The media listing now has a new column with edit links to the top‑level node(s)
that use each media item — shown as an operations dropdown when several nodes
reference the same asset. Use it to audit reuse, find orphaned media that no node
references, and open the right page to swap an asset.
