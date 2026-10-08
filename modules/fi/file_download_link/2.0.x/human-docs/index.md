# File Download Link — manual setup guide

**File Download Link** (`file_download_link`) adds a field formatter that turns a
File or Image field into a tidy, configurable **download link**. Instead of Drupal's
default file link, you get a link you can label ("Download the brochure"), style as a
button, and — importantly — set to *force* a download rather than open the file in the
browser.

The whole module is one formatter, `file_download_link`, that applies to `file` and
`image` fields. You choose it on a field's **Manage display** tab, so there is no
admin settings page to hunt for. From there you control the link text, an optional
tooltip and ARIA label, whether it opens in a new tab, a `rel` attribute, the HTML5
`download` attribute (which forces the download, optionally under a friendly
filename), and any extra CSS classes. Every rendered link also picks up automatic
classes — `file-download`, one for the file's MIME group, and one for its extension —
so you can, for example, give PDFs a red icon in CSS.

If you have the **Token** module installed, the text, title, ARIA label, forced
filename, and classes all support token replacement, with both the file entity and
its host entity available — so you can show something like the file's description
followed by its size. A submodule, **File Download Link (Media)**, extends the same
idea to Media reference fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and note
   the Token suggestion and the Media submodule.

## Where it lives in the admin menu

There is no dedicated settings page. You apply the formatter on a field's **Manage
display** — for example **Structure → Content types → (your type) → Manage display**
(`/admin/structure/types/manage/<type>/display`).

## How to use it

1. On the **Manage display** page for a content type (or other entity) that has a
   File or Image field, find that field's **Format** column.
2. Choose **File Download Link** from the format dropdown.
3. Click the gear icon to open the formatter settings and configure:
   - **Link text** — defaults to "Download"; leave it empty to use the filename.
   - **Force download** *(on by default)* — adds the HTML5 `download` attribute so the
     browser downloads the file instead of opening it. Optionally set a specific
     **download filename**.
   - **Open in new tab** *(on by default)* — adds `target="_blank"`.
   - **Rel attribute** — e.g. `noopener noreferrer`.
   - **Title** and **ARIA label** — for tooltips and accessibility.
   - **Custom classes** — space‑separated CSS classes, handy for button styling.
4. Click **Update**, then **Save**.

You can set the formatter per view mode, so a field can show an inline preview in one
mode and a forced‑download button in another. The configuration is stored on the view
display, so it exports and deploys with the rest of your site config.
