# Extra Block Types (EBT): Video — manual setup guide

**Extra Block Types (EBT): Video** (`ebt_video`) adds a **Video** block type that
embeds a single video — either a remote video (YouTube or Vimeo) or a locally
uploaded Media video — with an optional caption and a **GLightbox** popup so a poster
thumbnail opens the video full‑size. Enable the module and the block type, its
fields, and a dedicated video view mode are created for you automatically.

It is part of the **Extra Block Types (EBT)** family, built on the shared **EBT
Core** base (`ebt_core`) that gives every EBT block the same design widget — spacing,
borders, background, and container width. Beyond EBT Core it depends on core
**Media**, the **GLightbox** and **GLightbox Media Video** modules (for the video
popup), and **Paragraphs**. It ships a play‑button overlay, component CSS, and
templates that render the video inline or in the lightbox. It is a display‑only
block: no routes, no permissions, nothing to lock down.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Video adds no configuration page of its own. You use it by placing a **Video**
block: in **Layout Builder**, at **Structure → Block layout**, or as a reusable block
under **Content → Blocks → Add content block**.

## How to use it

1. Add a Video block through Layout Builder or Block layout.
2. Reference a remote or local video from the Media library, and add an optional
   caption or body.
3. Choose whether the video plays inline or opens in a **GLightbox** popup with a
   play‑button poster.
4. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
