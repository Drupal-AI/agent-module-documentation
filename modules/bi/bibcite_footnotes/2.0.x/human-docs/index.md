# Bibcite Footnotes — manual setup guide

**Bibcite Footnotes** (`bibcite_footnotes`) lets authors insert academic-style
inline footnote citations into CKEditor 5 content, linked to entries in a
Bibliography & Citation (Bibcite) bibliography. While writing a body field, an
author can drop in a reference as an inline footnote that points to the matching
bibliography entry — the way scholarly articles cite sources in-text.

It depends on the Bibcite suite (Bibcite and Bibcite Entity) and on core's
CKEditor 5, and lives in the Bibliography & Citation package. The references it
links to are ordinary Bibcite content, and the module adds no access-control
role or permissions of its own.

There is no standalone settings page for the module. Like other CKEditor
plugins, you make it available by adding its button to a text format's CKEditor
5 toolbar.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

To make the footnote tool available in the editor, add it to a text format's
CKEditor 5 toolbar:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses CKEditor 5
   (for example *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the Bibcite Footnotes button
   into the active toolbar.
3. Save the format.

Authors editing content with that format can then insert a Bibcite reference as
an inline footnote, which links to the corresponding bibliography entry.
