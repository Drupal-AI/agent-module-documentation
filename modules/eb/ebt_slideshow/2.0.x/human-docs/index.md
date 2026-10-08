# Extra Block Types (EBT): Slideshow — manual setup guide

**Extra Block Types (EBT): Slideshow** (`ebt_slideshow`) adds a ready‑made
**Slideshow** block type built on **FlexSlider**. It can also display a carousel (by
choosing the slide animation), and you pick your slides straight from the Media
library. Enable the module and the Slideshow block type is ready to place — no need
to build a content type or wire up the slider by hand.

It is part of the **Extra Block Types (EBT)** family, the block‑oriented sibling of
Extra Paragraph Types: the same one‑module‑per‑component design and a shared **EBT
Core** base (`ebt_core`) for common design options — spacing, background, borders,
and container width — but producing *block* types you can place in regions and in
Layout Builder rather than paragraphs embedded in a page. Alongside EBT Core it
depends on core **Media** and **Media Library**, and on **Paragraphs** (a paragraph
variant template ships too). The slider itself is the maintained
`levmyshkin/flexslider` library, installed via Composer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including the FlexSlider
   library), Composer install, and enabling the module.

## Where it lives in the admin menu

EBT Slideshow adds no configuration page of its own. You use it by placing a
**Slideshow** block: in **Layout Builder**, at **Structure → Block layout**, or as a
reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Slideshow block through Layout Builder or Block layout.
2. Pick your slide images from the Media library.
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block. To show a carousel instead of a
   fade slideshow, choose the slide animation in the block settings.
