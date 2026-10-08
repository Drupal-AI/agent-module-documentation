# Extra Paragraph Types (EPT): Basic Button — manual setup guide

**EPT Basic Button** (`ept_basic_button`) adds a ready‑made **Basic Button**
paragraph type: a call‑to‑action component for a Paragraphs‑based page builder. With
it, an editor drops a styled button in as its own page section — a "Book now", a
download link, a sign‑up prompt — instead of hand‑coding a link inside body text.

It is one member of the **Extra Paragraph Types (EPT)** family — a set of small
modules that each contribute a single paragraph type and all share a common base,
[`ept_core`](https://www.drupal.org/project/ept_core). That base gives every EPT
paragraph the same design options (CSS box spacing, margins and padding, borders;
background by colour, image — including parallax and cover — or YouTube video; and
edge‑to‑edge or fixed container width), so buttons look consistent with the other
components on the page. This module contributes the button itself: the paragraph
type, its link field, and the template and styles that render it.

Compared with rendering an existing link field as a button (the job of a display
formatter), this creates a standalone **button section** in a stacked page — the
right tool when the button is a component of the page rather than a property of the
content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in `ept_core` and Paragraphs, and enable it.

There is **no site‑wide configuration page** for this module. Like the rest of the
EPT family, it is configured **per paragraph instance** as an editor builds a page —
see "How to use it" below.

## Where it lives in the admin menu

EPT Basic Button adds no standalone admin settings page. The Basic Button paragraph
type it installs becomes available wherever a **Paragraphs** field allows it — you
add and configure a button while editing content. The shared design options come
from `ept_core`. To let a content type use it, add or edit a Paragraphs (entity
reference revisions) field at **Structure → Content types → *(type)* → Manage
fields** and allow the Basic Button type.

## How to use it

1. Make sure a content type (or another entity) has a **Paragraphs** field that
   permits the **Basic Button** paragraph type.
2. Edit a piece of content, add a **Basic Button** paragraph, and set its **link**
   (text and URL, internal or external).
3. Open the paragraph's design options (provided by `ept_core`) to adjust spacing,
   background, borders, and width so the button matches the surrounding section.
4. Save. The button renders as its own section in the page's flow. To restyle it
   beyond the built‑in options, override its Twig template in your theme.

Because the whole family shares `ept_core`, once you have adopted one EPT module the
others are cheap to add — sites commonly end up using several together.
