# EPT Countdown — manual setup guide

**EPT Countdown** (`ept_countdown`) adds a **countdown‑timer** paragraph type with
an animated countdown. A countdown to an event, a sale, or a launch is a common
landing‑page element, and this lets an editor add one as its own page section and
choose its styles through the UI.

It is part of the **Extra Paragraph Types (EPT)** family — small modules that each
contribute a single paragraph type and all share the base module,
[`ept_core`](https://www.drupal.org/project/ept_core), which provides the design
options every EPT paragraph has in common (CSS box spacing, margins, padding and
borders; background by colour, image — including parallax and cover — or YouTube
video; and edge‑to‑edge or fixed container width).

It is a display paragraph with no security surface. The one thing to get right is
the **target date and timezone**: a countdown's correctness lives entirely in its
date handling, so confirm the target date/time and timezone behave as you intend
before publishing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in the EPT base and Paragraphs, and enable it.

There is **no site‑wide configuration page** for this module. Like the rest of the
EPT family, it is configured **per paragraph instance** as an editor builds a page —
see "How to use it" below.

## Where it lives in the admin menu

EPT Countdown adds no standalone admin settings page. The Countdown paragraph type
becomes available wherever a **Paragraphs** field allows it, and its shared design
options come from `ept_core`. To let a content type use it, add or edit a Paragraphs
field at **Structure → Content types → *(type)* → Manage fields** and allow the
Countdown type.

## How to use it

1. Make sure a content type has a **Paragraphs** field permitting the **Countdown**
   type.
2. Edit content, add a **Countdown** paragraph, and set its **target date/time** —
   then double‑check the **timezone** behaviour matches your intent, since that is
   what determines whether the timer is correct.
3. Choose the countdown's styles through the UI and adjust the shared `ept_core`
   design options (spacing, background, width) to fit the section, and save.

Because the whole family shares `ept_core`, adopting one EPT module makes adopting
the others cheap — sites often end up using several together.
