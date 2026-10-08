# Extra Block Types (EBT): Image — manual setup guide

**Extra Block Types (EBT): Image** (`ebt_image`) adds an **Image** block type that
displays a single image from your Media library, with an optional caption, an
optional wrapping link, a choice of image style, and a **GLightbox** popup so the
thumbnail opens the full‑size picture. Enable the module and the block type — along
with all of its fields — is created for you automatically.

It is part of the **Extra Block Types (EBT)** family, built on the shared **EBT
Core** base (`ebt_core`). That base gives every EBT block the same design widget —
margins and padding, borders, background colour/image/video, and edge‑to‑edge or
fixed‑width container — so this image block is styled consistently with the rest of
the family. Alongside EBT Core it depends on core **Media**, core **Link**, and the
**GLightbox** module (which supplies the lightbox viewer). It is a display‑only
block: no routes, no permissions, nothing to lock down.

The clever part is how it renders. When you pick an image style in the block's
settings, the module swaps the image formatter to that style on the fly; and when
you turn on the lightbox, it works out the full‑size (or a separate lightbox image
style) URL from the referenced media so GLightbox can open it. GLightbox itself is a
modern, vanilla‑JavaScript library — no jQuery.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Image adds no configuration page of its own. You use it by placing an **EBT
Image** block: in **Layout Builder**, at **Structure → Block layout** for a region,
or as a reusable block under **Content → Blocks → Add content block → EBT Image**.

## How to use it

1. Add an EBT Image block through Layout Builder or Block layout.
2. Choose an image from the Media library, add an optional caption, and (optionally)
   a link to wrap the image in.
3. Pick the **image style** used to render it, and if you want a click‑to‑enlarge
   experience, enable the **GLightbox** popup — optionally with a separate image
   style for the enlarged view, or the original file.
4. Set spacing, background, borders, and container width using the shared **EBT
   Core** design options, then save and place the block.
