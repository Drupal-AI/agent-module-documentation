# Phylotree Viewer — manual setup guide

**Phylotree Viewer** (`phylotree_viewer`) lets you display **phylogenetic trees**
directly in Drupal. It provides a **field formatter** for file fields: upload a
phylogenetic tree file (such as Newick or PhyloXML) to a file field, choose the
Phylotree Viewer formatter for that field's display, and the tree is rendered as
an interactive visualization on the page instead of a plain download link. It is
aimed at biology, bioinformatics, and research sites that publish
phylogenetic data.

Under the hood it renders trees with the [Phylotree.js](https://github.com/veg/phylotree.js)
JavaScript library, which in turn relies on a few other front‑end libraries. Those
libraries are **not bundled** with the module — you have to download them and
place the files yourself before the viewer will work (see "Set up the external
libraries" below). The module includes a small settings/test page so you can
confirm the libraries are in the right place.

Note that this is a beta release (`1.1.0-beta1`) and is not covered by Drupal's
security advisory policy, so weigh that before using it on a high‑stakes
production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has a small configuration/test page rather than a full settings form,
so its setup is folded into this overview under "Set up the external libraries"
below.

## Where it lives in the admin menu

The visualization itself is configured per field, on a content type's (or other
entity's) **Manage display** tab. The module also adds a **Phylotree Viewer
Configurations** page in the admin interface, whose main purpose is a **Test
Libraries** button that verifies the required JavaScript/CSS files are installed.

## Set up the external libraries

Phylotree.js is pinned to specific companion library versions, so follow these
exactly:

1. Download the latest release of **Phylotree.js** from
   <https://github.com/veg/phylotree.js/releases>.
2. Download **D3.js version 3.5.17** (an older release on purpose — Phylotree is
   not compatible with newer D3) from
   <https://github.com/d3/d3/releases/tag/v3.5.17>.
3. Download the latest production **jQuery** from <https://jquery.com/download/>.
4. Download the latest production **Underscore.js** from <https://underscorejs.org/>.
5. Place the files in the module's `libraries` directory:
   - **CSS:** `phylotree.css` in `libraries/css/`.
   - **JS:** `d3.min.js`, `jquery.min.js`, `phylotree.js`, and `underscore.min.js`
     in `libraries/js/`.
6. Open the **Phylotree Viewer Configurations** page in the admin interface and
   click **Test Libraries** to confirm everything is detected.

## How to use it

Once the libraries are in place:

1. Add (or reuse) a **file field** on the content type that will hold tree files.
2. On that content type's **Manage display** tab, set the file field's format to
   the **Phylotree Viewer** formatter.
3. Create content, upload a Newick/PhyloXML tree file to the field, and view the
   node — the tree renders interactively in place of a download link.
