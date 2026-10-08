# CKEditor Glossary — manual setup guide

**CKEditor Glossary** (`ckeditor_glossary`) adds a button to the CKEditor 4 toolbar
that turns a selected word into a link to your glossary page. Select a term, click
the button, and the module wraps it in an anchor pointing at a glossary URL built
from the term itself — for example selecting "Apple" produces a link to
`/glossary/a#apple`. The link uses the first letter of the word as a path segment
and a slugified version of the word (accents stripped, spaces to dashes,
lower‑cased) as the URL fragment, which lines up with letter‑based glossary pages
and lets the browser scroll straight to the right entry.

This is handy for wikis, documentation, and term‑heavy content where you want body
text to cross‑reference a central glossary. The module doesn't build the glossary
page for you — you provide that yourself (Drupal's default Glossary view lives at
`/glossary`, which is also the module's default target). It targets the legacy
**CKEditor 4** editor (`ckeditor`), requires nothing outside Drupal core beyond
that, and adds no permissions or routes.

The glossary base path is configurable **per text format**, right in the editor's
plugin settings, so different formats can point at different glossary pages. There
is no separate site‑wide settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide configuration page** — the one setting (the glossary path)
lives in each text format's CKEditor settings, described under "How to use it"
below.

## How to use it

Enable and configure the button per text format:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses **CKEditor** (CKEditor 4).
3. In the CKEditor toolbar configuration, add the **Link to Glossary** button
   (it lives in the *insert* toolbar group).
4. In the same format's CKEditor settings, set **Path to glossary page** — for
   example `/my-glossary`. Leave it blank to use the default `/glossary`.
5. Make sure the format's allowed HTML permits `<a href class>`, so the produced
   link (which carries a `glossary-entry` class) survives filtering.
6. Click **Save configuration**.

When editing content in that format, select a word and click the button to link it
to the matching glossary anchor.
