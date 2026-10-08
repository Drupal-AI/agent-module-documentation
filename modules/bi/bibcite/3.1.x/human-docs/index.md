# Bibliography & Citation — manual setup guide

**Bibliography & Citation** (`bibcite`) is the core of the *Bibcite* suite — a set
of modules for managing scholarly references and rendering them as properly
formatted citations. If you run an academic, research, or library site and need to
store publications and show them in APA, MLA, Chicago, or AMA style, this is the
toolkit for it. The core module is the engine: it turns bibliographic data into
formatted citations using **Citation Style Language (CSL)** styles, and it defines
the plugin systems that the rest of the suite builds on.

On its own, the core `bibcite` module doesn't store any references — that's the job
of its submodules. What core gives you is: the **CSL style** system (with APA,
Chicago author‑date, MLA, MLA 8th edition, and AMA shipped in, plus the ability to
upload any of the 8,000+ styles from the official CSL repository), a small global
settings form to pick the default style and citation processor, and the
`bibcite.citation_styler` service that developers can call to render a citation in
code. It relies on several third‑party PHP libraries (most importantly
`seboettg/citeproc-php` for the actual CSL rendering), which Composer installs for
you.

The real functionality comes from turning on the submodules you need:

- **`bibcite_entity`** — the reference content itself: Reference and Contributor
  (author) entities, keyword vocabularies, and the pages that list and display them.
  This is what you enable to actually store publications.
- **`bibcite_import`** and **`bibcite_export`** — bulk import and export of
  references.
- **`bibcite_bibtex`**, **`bibcite_endnote`**, **`bibcite_marc`**,
  **`bibcite_ris`** — the file formats those import/export tools understand (BibTeX,
  EndNote, MARC, RIS).

There are also optional companion projects for DOI lookup (`bibcite_crossref`),
PubMed import (`bibcite_pubmed`), Altmetric badges, and migrating from the old
Biblio module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer, enable
   the core module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the core settings (default style,
   processor, URL linking) and managing CSL citation styles.

## Where it lives in the admin menu

The suite's administration lives under **Configuration → Bibliography & Citation**
(`/admin/config/bibcite`), gated by the **Administer bibcite** permission. The core
module's settings are on the *Processing* tab there, and the CSL styles collection
is at `/admin/config/bibcite/settings/csl_style`.

## How to use it

1. Install the suite and enable `bibcite` plus `bibcite_entity` (to store
   references) and any import/export format submodules you want.
2. In the core settings, choose your site‑wide default citation style (APA by
   default) and, if you like, upload additional CSL styles.
3. Add reference records (via `bibcite_entity`, or by importing a BibTeX/RIS/EndNote
   file), and they'll be rendered in your chosen style on their bibliography pages.
