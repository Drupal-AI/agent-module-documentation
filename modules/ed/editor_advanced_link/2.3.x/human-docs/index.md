# Editor Advanced Link — manual setup guide

**Editor Advanced Link** (`editor_advanced_link`) extends CKEditor's link dialog
so content editors can set extra `<a>` attributes — a **title** tooltip, **CSS
classes**, an **id**, an **ARIA label**, a **link relationship** (`rel`, e.g.
`nofollow` or `noopener`), and an **Open in new window** checkbox
(`target="_blank"`) — right when they create or edit a link.

Out of the box, Drupal's CKEditor 5 link dialog only asks for a URL and (optionally)
link text. If an editor needs a link to open in a new tab, carry a tracking class,
or expose an accessible label, they'd normally have to drop into source‑editing
mode and hand‑write the HTML. This module puts those attributes into the dialog as
proper form fields, so authors never touch markup.

The module does **not** change any editor the moment you enable it — you switch the
attributes on per **text format**. Each format that uses CKEditor 5 gets an
**Advanced links** settings panel where you tick exactly which attributes editors
of that format may use. It depends only on core's **Editor** module and adds no
permissions of its own. Optional companions it suggests — **Editor File**,
**Linkit**, and **CKEditor Entity Link** — make link‑building richer; the advanced
attributes even appear inside Linkit's and Editor File's dialogs when those are
installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the advanced attributes on for a
   text format and choose which ones editors may use.

## Where it lives in the admin menu

Editor Advanced Link has **no admin page of its own**. Its settings live inside each
text format's CKEditor 5 configuration at **Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`). Open (or *Configure*)
a format that uses CKEditor 5 and you'll find an **Advanced links** panel among the
CKEditor 5 plugin settings. Once enabled there, the extra fields simply appear in the
editor's link dialog when an author inserts or edits a link — there is nothing new in
the toolbar to click. See [Configuration](configuration/index.md) for the walkthrough.
