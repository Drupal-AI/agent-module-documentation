# highlight.js Input Filter — manual setup guide

**highlight.js Input Filter** (`highlightjs_input_filter`) adds client-side syntax
highlighting to code blocks in your rich-text content. Enable its text-format filter,
and whenever content contains `<pre><code class="language-…">` blocks (exactly what
CKEditor 5's code-block button produces), the module attaches the
[highlight.js](https://highlightjs.org/) library and highlights those blocks in the
visitor's browser — with an optional hover **copy-to-clipboard** button.

Importantly, the filter does **not** rewrite your code markup. It only reads the
declared language classes, attaches the right assets, and lets highlight.js do the
colouring in the browser. That keeps the code you authored intact and highlighting
purely client-side. It reads the `language-<id>` class on each block and even resolves
common aliases (so `language-js` loads JavaScript, `language-html` loads the XML
grammar, and so on).

A small settings form lets you choose the colour **theme** (200+ options such as
`atom-one-dark` or `github-dark`), toggle the copy button, and decide whether to load
the library from the default unpkg.com CDN or from a self-hosted copy in your
`libraries/` folder. It depends only on Drupal core and is designed for the
ES-module distribution of highlight.js (not the single-file custom builds from the
highlight.js download page).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

- **Enable the filter:** on a text format at **Configuration → Content authoring →
  Text formats and editors** (`/admin/config/content/formats`).
- **Settings (theme, copy button, CDN vs local):** **Configuration → Content authoring
  → highlight.js Input Filter** (`/admin/config/content/highlightjs_input_filter`).

## How to use it

### 1. Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **edit** the format you use for
   documentation or technical posts (for example *Full HTML*).
2. Under **Enabled filters**, tick **Highlight code using highlight.js**.
3. Make sure the format's allowed HTML permits `<pre>` and `<code>` with a `class`
   attribute, and order the filter so it runs *after* the HTML-restriction filter —
   the `<pre><code class>` markup must survive filtering for highlighting to attach.
4. Save.

Content authored in that format now highlights any `<pre><code class="language-…">`
blocks. In CKEditor 5, the standard code-block button already produces this markup,
so authors just pick a language for each code block as usual.

### 2. Choose your settings

Go to **Configuration → Content authoring → highlight.js Input Filter**
(`/admin/config/content/highlightjs_input_filter`). You need the **Administer
highlight.js Input Filter settings** permission. The options are:

- **Enable copy button** *(on by default)* — shows a hover copy-to-clipboard button on
  each highlighted code block (this loads the small highlightjs-copy plugin).
- **Theme** *(default `atom-one-dark`)* — the highlight.js colour theme, chosen from
  200+ options such as `github-dark`, `monokai`, and many light themes. Switching a
  documentation site from a light to a dark code theme is a one-setting change.
- **Use local libraries** *(off by default)* — when off, assets load from the
  unpkg.com CDN (highlight.js 11.11.1) with zero local setup. Turn it on to serve the
  library from your own site instead (see below).
- **Local path** *(default `/libraries/highlightjs`)* — where the self-hosted
  highlight.js ES-module build lives (it needs `es/` and `styles/` subfolders).
- **Local path (copy plugin)** *(default `/libraries/highlightjs-copy/dist`)* — where
  the self-hosted copy-plugin assets live.

Save. Changing the theme or paths refreshes the library cache automatically.

### CDN vs self-hosting

- **CDN (default):** highlight.js and the copy plugin load from unpkg.com — nothing to
  install. Best for a quick start.
- **Self-hosted:** for privacy, offline, or restricted-network sites, tick *Use local
  libraries* and place the ES-module distribution of highlight.js under
  `/libraries/highlightjs` (and the copy plugin under `/libraries/highlightjs-copy`).
  If the files are missing, the settings form refuses to save and the **status
  report** (Reports → Status report) raises an error, so you will know before it
  breaks the front end. The module README describes the Composer + Asset Packagist
  setup that installs `@highlightjs/cdn-assets` into `web/libraries/highlightjs`.

> Use the **ES-module** distribution of highlight.js. The single-file custom builds
> from highlightjs.org/download are not compatible with this module.
