# PDB File Viewer — manual setup guide

**PDB File Viewer** (`pdb_file_viewer`) is a **file-field formatter** that renders
molecular-structure files directly in the browser as an interactive 3D viewer. It
integrates the **NGL Viewer** JavaScript library to draw structures from formats
common in structural biology and chemistry — Protein Data Bank (`.pdb`, `.ent`),
crystallography (`.cif` / `.mmcif`), and chemical formats such as `.mol2`, `.sdf`,
`.gro`, `.pqr`, and `.mmtf`. It is aimed at research repositories, science
publications, and any site where visitors need to preview uploaded structure files
in place.

You use it like any other field formatter: add a **file field** to your content
type, then on *Manage display* choose **PDB File Viewer** as the format. The
formatter emits a viewport and hands the file to NGL, which loads and renders it in
the visitor's browser. Per-display options let you also show the file name as a
download link, show the file size, cap rendering by a maximum file size, and (with
the Fallback Formatter module) fall back gracefully for unrecognized formats.

A small global settings form controls which extensions are treated as viewable and
whether the NGL library is loaded from a CDN or a local copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the global settings form and the
   per-display formatter options.

## Where it lives in the admin menu

- The **global settings** form is at
  **`/admin/config/user-interface/pdb_file_viewer`** (gated by **Administer site
  configuration**).
- The **formatter** is chosen per field on a content type's (or other entity's)
  **Manage display** screen.
