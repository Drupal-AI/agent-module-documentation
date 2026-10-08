# Extra Paragraph Types (EPT): Bootstrap Button — manual setup guide

**EPT Bootstrap Button** (`ept_bootstrap_button`) adds one paragraph type: a
**Bootstrap‑styled button**. An editor building a landing page from paragraphs gets
a call‑to‑action they can configure — text, link, Bootstrap variant, size, and
alignment — without a developer having to create a paragraph type and template for
it.

It is part of the **Extra Paragraph Types (EPT)** family — small modules that each
contribute one paragraph type and all share the base module,
[`ept_core`](https://www.drupal.org/project/ept_core), which supplies the design
options every EPT paragraph has in common (CSS box spacing, margins, padding and
borders; background by colour, image — including parallax and cover — or YouTube
video; and edge‑to‑edge or fixed container width).

The value here is in *not* doing the work: rather than building a bespoke button
paragraph and maintaining it, you enable this and accept someone else's release
schedule and styling decisions in exchange. One thing to check first — **it assumes
Bootstrap.** The classes it emits are Bootstrap's, so on a theme that is not
Bootstrap‑based the button renders unstyled until those classes are given meaning.
That is by design (the name says Bootstrap), but it is the thing to confirm before
adding it.

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

EPT Bootstrap Button adds no standalone admin settings page. The Bootstrap Button
paragraph type becomes available wherever a **Paragraphs** field allows it, and its
shared design options come from `ept_core`. To let a content type use it, add or
edit a Paragraphs field at **Structure → Content types → *(type)* → Manage fields**
and allow the Bootstrap Button type.

## How to use it

1. Confirm your theme is **Bootstrap‑based** (or that Bootstrap's button classes are
   otherwise defined), so the emitted classes actually style the button.
2. Make sure a content type has a **Paragraphs** field permitting the **Bootstrap
   Button** type.
3. Edit content, add a **Bootstrap Button** paragraph, and set its text and link,
   then choose the **Bootstrap variant** (primary, secondary, etc.), **size**, and
   **alignment**.
4. Adjust the shared `ept_core` design options (spacing, background, width) to fit
   the surrounding section, and save.

Because the whole family shares `ept_core`, adopting one EPT module makes adopting
the others cheap — sites often end up using several together.
