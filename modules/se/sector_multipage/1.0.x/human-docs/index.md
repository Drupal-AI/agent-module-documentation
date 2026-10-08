# Sector Multipage — manual setup guide

**Sector Multipage** (`sector_multipage`) adds in-page navigation for long HTML
documents that have been split into sections — letting a visitor move between the
pages/sections of a multi-page piece of content, and switch between reading it all
on one page or one section at a time. It is typically used with **Sector
distribution Resource nodes**, and it complements the **Sector Table of Contents**
module.

The problem it solves is reading and navigating long content: once a long document
has been chunked into sections (by the **Chunker** module), Sector Multipage gives
readers prev/next and section navigation and a toggle between the full and paged
views, so they are not scrolling through one enormous page. It is a content-display
/ navigation feature; the navigation reflects the structure of content the visitor
can already see, and it has no access-control role.

The module provides **two blocks** (see below) that you place through Block Layout —
there is no separate settings form. It has a hard dependency on the **Sector Table
of Contents** (`sector_toc`) module, and for full use it expects the Sector
distribution and the **Chunker** module (which does the actual splitting of the
document). It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

Sector Multipage gives you two blocks to place:

- **Sector Multipage Pagination block** — this one is **required** and must appear
  on the content type's default display; it attaches the `multipage.js` behavior
  that drives the section-by-section paging.
- **Sector Multipage Actions block** — meant for a sidebar; it offers buttons to
  switch between the full (single-page) display and the paged display.

Place the pagination block in the content region of your long-document content
type and the actions block in a sidebar, and readers can then page through the
sections and toggle between full and paged views.
