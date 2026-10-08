# ePub Generator — manual setup guide

**ePub Generator** (`epub_generator`) turns Drupal content into real **ePub 3
ebooks** — the format e-readers, tablets and phones understand — entirely in pure
PHP. There are no external binaries, no headless browser and no special hosting
requirements: because it builds on the zero-dependency `php-epub` library, it runs
anywhere Drupal runs, including managed hosting where installing wkhtmltopdf or a
headless Chrome is not an option. All it needs is the `zip` and `dom` PHP
extensions your host almost certainly already has.

One click on a node — or on a whole **Book** outline — produces a valid ePub with
proper publishing metadata, a navigable table of contents, and accessibility baked
in. Every generated ebook includes schema.org accessibility metadata (access
modes, features, structural navigation) per the EPUB Accessibility specification,
plus an ePub 2 NCX fallback for older reading systems — useful if you have Section
508, WCAG or European Accessibility Act obligations for the documents you publish.

The module is organised around a base module plus a few optional submodules:

- **Book Integration** — the flagship feature. If you already maintain long-form
  content in core Book outlines, the entire book tree becomes a multi-chapter ebook
  with a hierarchical table of contents that mirrors your outline. Publishing
  metadata (author, ISBN, publisher, cover image, edition, rights) is read from
  fields on the book's root node via a configurable field mapping — and if you
  don't have those fields yet, one click creates and maps them on a content type
  you choose. A **Download ePub** tab appears on every node in the book.
- **Viewer** — adds a **Read online** tab (and a field formatter for uploaded
  `.epub` files) built on `epub.js`, with a table of contents, page-turning or
  continuous scrolling, progress, fullscreen, keyboard navigation and automatic
  position resume.
- **Markdown** — lets you attach `.md` files to a file field and offer them as ePub
  downloads, with YAML front matter for metadata and automatic chapter splitting on
  headings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the optional
   submodules with Composer, and enable the ones you need.

This module has **no single settings screen**. Its behaviour is configured where it
naturally belongs: a dedicated **"ePub" view mode** on each content type controls
exactly which fields appear in ebook output (independent of the web display), the
Book Integration submodule holds the metadata field mapping described above, and
you can point the module at your own stylesheet instead of the bundled default.

## How to use it

- **Download an ebook from a node** — with the module enabled, a **Download ePub**
  tab appears on content (and on every node in a Book, once Book Integration is on).
  Click it to download the `.epub`.
- **Read in the browser** — enable the Viewer submodule to add a **Read online**
  tab next to the download tab; on a Book node it opens the whole assembled book.
- **Control what's exported** — edit the content type's **ePub** view mode
  (Structure → Content types → *Manage display* → the *ePub* view mode) to choose
  which fields land in the ebook. Rendered HTML is converted to valid XHTML with
  Drupal UI chrome (tabs, contextual links, admin links) stripped automatically;
  local images are embedded, and SVG/MathML are preserved for charts and equations.
- **Fixed-layout output** — for pixel-perfect, pre-paginated ebooks (dashboards,
  illustrated content), the module supports fixed layout book-wide or per chapter,
  with viewport, spread and orientation control.
- **Automate it** — Drush commands `epub:generate` and `epub:generate-book`
  generate ebooks from the command line for scripted or scheduled export.
