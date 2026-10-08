# Citation Select — manual setup guide

**Citation Select** (`citation_select`) adds a "cite this" block to your node
pages. A visitor picks a citation style from a drop-down — APA, MLA, Chicago,
AMA, or any other style you install — and the block shows a fully formatted
bibliographic citation for the current page, with a one-click **Copy Citation**
button. It is a lightweight way to give researchers and readers ready-to-paste
references without pulling in the full Bibcite suite.

Behind the scenes it maps a node's fields (title, author, publication date,
publisher, DOI, and so on) into CSL-JSON, then renders them with the
`citeproc-php` library against installed **Citation Style Language (CSL)** styles.
The styles are configuration entities you manage in the admin UI: the module ships
with APA, MLA (two editions), Chicago author-date, and American Medical
Association, and you can add more by pasting CSL XML or uploading a `.csl` file.

Because every site models its content differently, you tell Citation Select **how
your fields map to citation fields** on a mapping form — for example, "my *Author*
field is the CSL `author`, my *Published* date is the CSL `issued` date." It
understands person names (via a full-name parser), EDTF dates, entity-reference
labels, and Typed Relation roles, and it defines a `CitationFieldFormatter` plugin
type so developers can teach it about custom field types.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the CSL libraries and module
   with Composer, then enable it.
2. [Configuration](configuration/index.md) — place the block, map your fields,
   manage CSL styles, and set the default style.

## Where it lives in the admin menu

The settings live under **Configuration → Citation Select**
(`/admin/config/citation-select`), which holds the main **Settings** form, the
**CSL Mapping** form, and the **CSL Styles** collection. Every one of these screens
requires the **Administer site configuration** permission. The citation block
itself is placed from **Structure → Block layout**.
