# Entity Word — manual setup guide

**Entity Word** (`entity_word`) adds a "download as Word document" option to your
content. Given a node, it builds a Microsoft Word **`.docx`** file from the node's
**title and body** and streams it to the browser as a download. It is meant for
sites that want an editorial or reader-facing "Download Word Document" button on
selected content — a printable, shareable copy of an article.

Downloads happen at the URL `/entity-word/{node_id}/word` (for example
`/entity-word/10/word`). The module also adds a **Download Word Document** local
task tab on the node, and you can drop a link to that URL into your node's Twig
template wherever you want the button to appear. Generating the document needs no
CSS or JS from you — an admin settings form controls the paper size, margins,
fonts, and a token-based filename.

Under the hood it uses the **`phpoffice/phpword`** library (installed via
Composer) and depends on the **Token** module. Only the node's title and body are
exported — not arbitrary fields.

Downloading is gated by the **`access download word document`** permission.
Output escaping is enabled for the generated document.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (required, for
   the PhpWord library), enable the module, and grant the download permission.
2. [Configuration](configuration/index.md) — the document settings form: filename
   token, paper size, margins, and fonts.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Entity Word**
(`/admin/config/system/entity_word`), and requires the **Administer site
configuration** permission.

## How to use it

1. Grant **`access download word document`** to the roles that may download.
2. Link to `/entity-word/{node_id}/word` from your node's Twig template, or use
   the **Download Word Document** local task tab that appears on the node.
3. Visiting that URL downloads the node's title and body as a `.docx` file, styled
   according to your settings.
