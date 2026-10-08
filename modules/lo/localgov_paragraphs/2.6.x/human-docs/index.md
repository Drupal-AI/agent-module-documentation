# LocalGov Paragraphs — manual setup guide

**LocalGov Paragraphs** (`localgov_paragraphs`) supplies the shared library of
page‑building components that **LocalGov Drupal** sites assemble their content
from. Rather than every council site inventing its own set of blocks, this module
ships the canonical one, so editors and designers across LocalGov sites work with
the same predictable components.

The base module provides five paragraph types as configuration —
**Text** (`localgov_text`), **Image** (`localgov_image`), **Link**
(`localgov_link`), **Contact** (`localgov_contact`) and **Numbered text**
(`localgov_numbered_text`). Because these are ordinary Paragraph bundles, editors
compose pages with the standard Paragraphs interface, and site builders can add
extra fields to them through Field UI just like any other bundle.

Four submodules extend the set: **Layout Paragraphs** support for arranging
components into multi‑column sections, **Views** embedding so a view can appear as a
component, a **Homepage** component set for council homepages, and a richer
**Subsites** component set used by subsite pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the submodules you need.

This module has **no configuration page**. It contributes paragraph types you use
when building content; extend them, if needed, through the standard **Field UI**.

## Where it lives in the admin menu

LocalGov Paragraphs adds no settings screen. Its paragraph types appear wherever a
Paragraphs field is used, and you can inspect or extend the bundles at **Structure →
Paragraphs types** (`/admin/structure/paragraphs_type`). You add these components to
content through the Paragraphs fields on your content types (for example on a
LocalGov Page).

## How to use it

1. Enable the base module and the submodule(s) you need (see
   [Installation](installation/index.md)).
2. On a content type with a Paragraphs (or Layout Paragraphs) field, add
   components — text, image, link, contact or numbered‑text blocks — as you author.
3. If a component needs an extra field for your site, add it at **Structure →
   Paragraphs types → *(bundle)* → Manage fields**.

Because it is part of the LocalGov Drupal distribution, install it as part of a
LocalGov site: on bare Drupal its submodules pull in further LocalGov dependencies
(`localgov_core` and the wider Paragraphs stack), so enabling it alone on plain core
can fail. See [Installation](installation/index.md) for details.
