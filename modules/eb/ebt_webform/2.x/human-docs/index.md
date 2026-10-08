# EBT Webform — manual setup guide

**EBT Webform** (`ebt_webform`) adds a **Webform** block type, letting you place any
existing webform as a styled block — in a layout, a sidebar, or anywhere a block goes
— with the Extra Block Types family's design options wrapped around it. Enable the
module and the Webform block type is ready to place.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width — and it also depends on **Paragraphs** and the **Webform** module.
It is a content/layout convenience: the webform it embeds is the real form, with its
own access controls and handlers intact, so the security of the placed form is the
webform's own. When you place a form in a block context, confirm its access and any
handlers behave as you expect there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Webform adds no configuration page of its own. You use it by placing a
**Webform** block: in **Layout Builder**, at **Structure → Block layout**, or as a
reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Make sure the webform you want to embed already exists (build it under
   **Structure → Webforms**).
2. Add a Webform block through Layout Builder or Block layout, and select the webform
   to embed.
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
