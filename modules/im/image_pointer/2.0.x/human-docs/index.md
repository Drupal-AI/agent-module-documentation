# Image Pointer — manual setup guide

**Image Pointer** (`image_pointer`) is a simple module for building an **interactive
image map**: you upload a static image, place **clickable markers (pointers)** on
it, and the resulting map — image plus its list of markers — is displayed as a
block. A typical use is a distributor or location map, where each marker points to
or reveals related information.

Once you've configured the module, an image‑pointer field becomes available on the
content types you selected. When creating content, editors place the markers on the
image where they want them. All the markers are then rendered through the **Image
Pointer View Block**, which you position into a region of your theme to show the
marker list on the site.

This is a content‑display feature: the pointer content is authored by
admins/editors, and beyond its own permission the module has no access‑control role.
It provides its own permission for who may edit its settings, and it supports
Drupal 8 and up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the module, enable the field on
   your content types, and place the display block.

## Where it lives in the admin menu

After enabling, an **Image Pointer** item appears in the admin configuration menu at
**Administration → Configuration → Image Pointer**. The display block is placed at
**Structure → Block layout**, and access is controlled on **People → Permissions**.
