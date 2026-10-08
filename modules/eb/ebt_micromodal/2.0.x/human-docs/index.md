# Extra Block Types (EBT): Micromodal — manual setup guide

**Extra Block Types (EBT): Micromodal** (`ebt_micromodal`) adds a "button with
popup" block type: it renders a button that, when clicked, opens content in an
accessible modal dialog powered by the small **Micromodal.js** library. It is handy
for a privacy policy, terms, a short form, or any extra information you want a
reader to reveal on demand rather than see up front.

It is part of the **Extra Block Types (EBT)** family and depends only on the shared
**EBT Core** base (`ebt_core`), which provides the common design options — spacing,
background, borders, and container width. Editors set the button label and the modal
content directly in the block's settings, so you get an accessible call‑to‑action
modal without writing any JavaScript. It is a display / site‑building block with no
access‑control role; because the modal content is authored, apply the usual
text‑format and escaping care to whatever you place inside.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Micromodal adds no configuration page of its own. You use it by placing a
**Micromodal** block: in **Layout Builder**, at **Structure → Block layout**, or as
a reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Micromodal block through Layout Builder or Block layout.
2. Set the **button label** and author the **modal content** the button reveals.
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
