# Extra Block Types (EBT): Accordion — manual setup guide

**Extra Block Types (EBT): Accordion** (`ebt_accordion`) adds a ready-made
**Accordion / FAQ** block type to your site — collapsible sections that let a long
page read better when folded up. It's ideal for FAQ pages, policy documents,
product specifications, terms and conditions, or any dense content that benefits
from being grouped into expandable sections. Editors can choose accordion and FAQ
styles through the UI, with no developer needed.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** (rather than paragraph types), so you can drop them
into any region and into **Layout Builder** in a few clicks. Every EBT block
shares a common design widget supplied by the **EBT Core** (`ebt_core`) base
module — see the [Configuration note](#configuration) below. This module requires
`ebt_core` and the **Paragraphs** module, and runs on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Accessibility tip:** content hidden inside a collapsed accordion panel is not
> found by the browser's in-page search (Ctrl+F). On FAQ or policy pages where
> visitors expect to search the text, keep that in mind when deciding what to fold
> away.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core and Paragraphs dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Accordion is configured **per block instance** when you place it — you set its
content and pick its styles right there on the block form. The shared **Design**
options (CSS box margins/paddings/borders; background colour, image — including
parallax and cover — or YouTube video; edge-to-edge vs. container width) come from
the **EBT Core** widget every EBT block includes. For more on those shared
options, see the [EBT Core project page](https://www.drupal.org/project/ebt_core).

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Accordion** block type.
3. Add your collapsible sections (each section's title and body), pick the
   accordion/FAQ style, and adjust the shared Design options as needed.
4. Save. The accordion renders on the page, and the block can be reused elsewhere.
