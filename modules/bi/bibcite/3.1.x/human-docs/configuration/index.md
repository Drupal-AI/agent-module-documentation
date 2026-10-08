# Configuration

This page covers the **core** module's own configuration: the global citation
settings and the CSL style library. (The submodules — reference entities, import,
export, and the file formats — have their own screens under the same
**Configuration → Bibliography & Citation** section.)

## Core settings

1. Log in as a user with the **Administer bibcite** permission.
2. Go to **Configuration → Bibliography & Citation**
   (`/admin/config/bibcite`) and open the **Processing** tab.

The form has three settings, stored in the `bibcite.settings` object:

- **Processor** — which citation‑rendering engine (a "processor" plugin) is used.
  The only one shipped is **citeproc‑php** (the default), which wraps the
  `seboettg/citeproc-php` library. You'd only change this if you install a custom
  processor.
- **Default style** — the citation style used site‑wide when none is specified.
  Defaults to **APA**. Pick any installed CSL style here (see below).
- **Convert URLs** — when on, URLs found inside a rendered citation are turned into
  clickable links. Off by default.

Click **Save configuration** to apply.

## Managing CSL citation styles

Citation styles are stored as configuration entities, and the module ships five:
**APA**, **Chicago (author‑date)**, **MLA**, **MLA 8th edition**, and **AMA**.

To manage them, go to **Configuration → Bibliography & Citation → CSL styles**, or
navigate directly to `/admin/config/bibcite/settings/csl_style`. From this list you
can enable, edit, or delete styles, and add new ones two ways:

- **Add style** — paste raw CSL XML directly.
- **Install style from file** — upload a `.csl` file. This is the usual route:
  download the style you want from the official CSL repository (over 8,000 styles,
  covering most journals and institutions) and upload it here.

Once a style exists, set it as the site default by choosing it in the **Default
style** setting above, or reference it per‑page/per‑render where the suite lets you
choose a style.

## For developers

To render a citation in your own code, use the `bibcite.citation_styler` service:
call `render($cslData)` for the default style, or `setStyleById('chicago_author_date')`
first to pick a specific one. See the sibling [`agent/`](../agent/start.md) docs for
the full service API and the two plugin types (`bibcite_processor` and
`bibcite_format`) you can extend.
