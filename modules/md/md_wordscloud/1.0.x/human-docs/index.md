# MD Wordscloud — manual setup guide

**MD Wordscloud** (`md_wordscloud`) provides a block that renders a **word cloud** of your
taxonomy terms, built with the D3.js visualization library. Terms attached to more content
appear larger, so the cloud visually represents which topics or tags are most used across
your site. Unlike some similar modules, MD Wordscloud lets a single block draw on **several
vocabularies at once**, shows terms in multiple colours, and gives you control over word
**orientation** and the **angle** of rotation (from ‑90 to 90 degrees).

It is a display/visualization feature and has no content or access role of its own — it
simply reads existing taxonomy terms and their usage. To produce the cloud it relies on two
JavaScript libraries, **D3** and **D3 Cloud**, which you download and place in your site's
`libraries` directory (see Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   place the required D3 libraries.

MD Wordscloud has no global settings form — you configure each cloud on the block itself
when you place it, as described under "How to use it" below.

## Where it lives in the admin menu

MD Wordscloud adds no dedicated settings page. You create and configure a cloud from
**Structure → Block layout** (`/admin/structure/block`) by placing an **MD WordsCloud**
block, and the terms it visualizes come from your **taxonomy**.

## How to use it

1. Make sure you have taxonomy in use: create some **terms**, add a **term‑reference
   field** to a content type, and attach terms to your content. The cloud sizes each term
   by how many pieces of content reference it, so it needs that data to be meaningful.
2. Go to **Structure → Block layout** and use any **Place block** button to add an **MD
   WordsCloud** block to a region.
3. In the block's configuration, choose:
   - the **vocabulary or vocabularies** to include (you can pick more than one),
   - the **number of words** to display,
   - the **word scale** (how strongly usage affects size),
   - how many **orientations** the words may take, and
   - the **angle** of rotation (‑90 to 90 degrees).
4. Save the block. The word cloud renders in the region you placed it, with more‑used terms
   shown larger and in varied colours and orientations.
