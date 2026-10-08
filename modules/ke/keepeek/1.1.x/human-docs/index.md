# Keepeek — manual setup guide

**Keepeek** (`keepeek`) connects Drupal's media system to the
[Keepeek](https://www.keepeek.com/) **digital asset management (DAM)** platform.
Keepeek is where an organization centralizes all its images, videos, and other rich
media; this module lets editors browse that managed library from inside Drupal and
drop Keepeek‑hosted assets straight into content — no re‑uploading, and no second
copy to keep in sync.

The connection is live: because assets stay hosted in Keepeek, updating a picture
in the DAM updates it on your Drupal site too. Editors get a friendly browser with
Keepeek's search and advanced filters, can navigate collections, shared
collections, and folders, and can crop or resize images on the fly (using a point
of interest or the crop tool) as they insert them.

Keepeek plugs into Drupal as a **media source**: you create a Keepeek media type,
then reference it from your content types like any other media. It depends on core's
**Media**, **Media Library**, and **Responsive Image** modules, and it's configured
at the `keepeek.settings` page. The connection uses **Keepeek API credentials** —
store those as secrets and scope them appropriately (see
[Configuration](configuration/index.md)). The module governs how assets are sourced
and displayed; it plays no role in content access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   its Media dependencies.
2. [Configuration](configuration/index.md) — connect to Keepeek and set up the
   Keepeek media type, step by step.

## Where it lives in the admin menu

The connection settings are at **Configuration → Keepeek** (route
`keepeek.settings`). You then create the media type at **Structure → Media types**
(`/admin/structure/media`).

## How to use it

Before you begin, **contact the Keepeek team to enable your Drupal module account**
— the integration needs to be activated on the Keepeek side. Then configure the
connection and create a Keepeek media type; the full walkthrough is in
[Configuration](configuration/index.md). Once a Keepeek media type exists and is
referenced from a content type, editors insert assets through the Media Library.
