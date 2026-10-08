# GovNL Table of contents — manual setup guide

**GovNL Table of contents** (`govnl_cms_toc`) automatically builds a **table of
contents** for a page from the headings in its content. It scans the H2–H6
headings in a node's rendered output, generates a nested, anchor‑linked list that
mirrors the heading structure, and exposes it as a **block** you can place
wherever you like. On long articles, policy pages or guidance documents, this
gives readers a jump‑to navigation without any manual effort from your editors.

The module handles the fiddly details for you. It generates **URL‑friendly IDs**
on each heading (coping with special characters) so the anchor links are stable
and safe to deep‑link to, nests the list items by heading level, and adds **ARIA
labelling** so the table of contents is announced properly to screen‑reader users.

It is configurable in three useful ways: you choose **which heading levels** are
scanned, set a **minimum threshold** of headings below which no table of contents
is shown (so short pages are not cluttered with a one‑item list), and define
**CSS skip‑selectors** to exclude specific elements from scanning. Because the
output is a standard block, you also get all of Drupal's normal block placement
and visibility controls.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose heading levels, set the
   minimum threshold, and define skip‑selectors.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Content authoring → GovNL
Table of contents** (`/admin/config/content/govnl-toc`), protected by the
**Administer GovNL Table of contents** permission (`administer govnl_cms_toc`).
The table of contents itself is placed and positioned like any other block, under
**Structure → Block layout**.

## How to use it

1. Enable the module.
2. Open the [settings form](configuration/index.md) and set your default
   heading levels, minimum threshold and skip‑selectors.
3. Go to **Structure → Block layout**, place the **Table of contents** block in a
   region (a sidebar is a common choice), and apply block visibility rules so it
   only appears on the content that needs it — for example a specific content
   type or set of pages.
