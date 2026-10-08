# Extra Block Types (EBT): Hero — manual setup guide

**Extra Block Types (EBT): Hero** (`ebt_hero`) adds a ready‑made **hero section**
block type — the full‑width introduction at the top of a landing page, with
background media, a heading, supporting text, and up to two buttons. Instead of
building this from scratch on every project, you enable the module and a "Hero"
block type appears, ready to place in Layout Builder or in a region.

It belongs to the **Extra Block Types (EBT)** family, a set of one‑module‑per‑component
block types that share a common base, **EBT Core** (`ebt_core`). That shared base
gives every EBT block the same design widget — margins and padding, borders,
background colour/image/video, edge‑to‑edge or fixed‑width container — so a hero
placed here is styled the same way as every other EBT block. Hero also depends on
core **Link** and **Media**, the **EBT Basic Button** module for its call‑to‑action
buttons, and **Paragraphs**. It ships two layout styles: **2 Columns** and **One
Column**.

One thing to know before you enable it: the hero's field configuration references
an **image media type**, which the module does not create. On a clean site where no
`image` media type exists yet, enabling can fail with an *"unmet dependencies …
media.type.image"* error. Create the image media type first (most standard installs
and distributions already ship one), and the enable will succeed.

Because the hero image is almost always the page's largest image, it is the single
biggest performance lever on a landing page — configure a responsive image style
and consider preloading it. And because editors will place all kinds of photographs
behind the heading, plan the text/image contrast structurally (an overlay or scrim,
or a constrained text area) rather than trusting any one image to stay legible.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module (including the image‑media‑type prerequisite).

## Where it lives in the admin menu

EBT Hero adds no configuration page of its own. Once enabled, you use it by placing
a **Hero** block: in **Layout Builder** on a content type or page, or at
**Structure → Block layout** for a region. You can also create a reusable one at
**Content → Blocks → Add content block → Hero**.

## How to use it

1. Add a Hero block through Layout Builder or Block layout.
2. Choose a layout style (**2 Columns** or **One Column**), set the background media
   or image, and type the title, subtitle, and up to two buttons.
3. Open the block's design options — provided by the shared **EBT Core** widget — to
   set spacing, background, borders, and container width.
4. Save and place the block where the hero should appear.
