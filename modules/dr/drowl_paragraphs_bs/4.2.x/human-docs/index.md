# DROWL Paragraphs for Bootstrap — manual setup guide

**DROWL Paragraphs for Bootstrap** (`drowl_paragraphs_bs`) is the Bootstrap‑based
successor to [DROWL Paragraphs](../../drowl_paragraphs/4.2.x/human-docs/index.md).
It provides a set of ready‑made **Paragraphs bundles** plus display/style options
for building pages, using standard **Bootstrap 5** classes so the output should
work with any Bootstrap 5 theme. Its display options are implemented with the **UI
Styles** module, which means you can extend or adapt them for your project (for
example from a child theme) rather than being locked into a fixed set. Each
pre‑defined paragraph bundle ships as its own submodule, so you activate only the
bundles you actually need.

Be clear‑eyed about the dependency footprint: this module is designed to live at
the centre of DROWL's ecosystem, and it pulls in a lot. Beyond **Paragraphs**,
**Layout Paragraphs**, **Field Group**, **UI Styles Paragraphs**, and core
**Media**, the project also expects modules such as **UI Styles**, **DROWL
Layouts**, **DROWL Media**, **Twig Tweak**, **PhotoSwipe**, **Fences**, **Micon**,
**Entity Reference Display**, **Block Field**, **Link Attributes**, **Field
Formatter**, **Entity Access by Role**, **Views Reference**, and **Webform**. It is
built specifically for DROWL's own **DROWL Base / Radix** theme; using it with a
different Bootstrap theme means overriding templates yourself. The UI/UX is
explicitly a work in progress.

Because styling is handled through UI Styles and layout comes from
[DROWL Layouts for Bootstrap](../../drowl_layouts_bs/1.0.x/human-docs/index.md),
there is no dedicated settings form of its own — you configure it by enabling the
bundle submodules and building content, described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Bootstrap/DROWL dependencies.

There is **no dedicated configuration page** for this module — display options come
from the UI Styles module, and setup happens on your paragraph types and content,
as described below.

## Where it lives in the admin menu

DROWL Paragraphs for Bootstrap adds no settings page of its own. You work with it
under **Structure → Paragraphs types** (the bundles it provides) and when building
pages with Layout Paragraphs. Its style options are managed through the **UI
Styles** module (**Configuration → User interface → UI Styles**).

## How to use it

1. Install the module and its dependencies (see [Installation](installation/index.md)),
   ideally on a **DROWL Base / Radix** (Bootstrap 5) theme.
2. Enable the paragraph‑bundle submodules for the bundles you want.
3. Add the DROWL paragraph bundles to a Paragraphs (or Layout Paragraphs) field on
   your content, and pick style options for each — those options come from UI
   Styles and can be extended in your theme.
