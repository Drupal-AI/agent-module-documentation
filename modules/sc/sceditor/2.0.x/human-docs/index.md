# SCEditor — manual setup guide

**SCEditor** (`sceditor`) adds SCEditor — a lightweight, open‑source WYSIWYG
editor for **BBCode** and **(X)HTML** — to Drupal as a text‑editor option you can
attach to a text format. It is a slim alternative to a full CKEditor toolbar,
well suited to forum‑style content, comments and short text fields where a heavy
editor is overkill. It pairs naturally with the xbbcode module when you want
BBCode content.

Under the hood the module is a single editor plugin that attaches the SCEditor
JavaScript library to the textareas of any text format you assign it to. It does
no server‑side content filtering of its own — and this is the important part to
understand — it explicitly declares itself **not XSS‑safe**. That is an honest
posture: Drupal therefore treats the editor's output as untrusted and applies the
text format's own filters when rendering. What it means for you is that you
**must keep a sanitising filter enabled** (such as *Limit allowed HTML tags*, or a
BBCode filter) on any format assigned to untrusted roles. The editor will not
protect you on its own.

The module works once you assign it to a text format — there is no separate
settings page of its own. It has no module dependencies and no submodules.

One more thing worth knowing: the SCEditor library assets are loaded from an
external CDN (jsDelivr), pinned to `@latest`, plus a small local initialiser
script. Because the frontend library is not version‑locked by the module, the
exact editor version your visitors receive can change over time; if that matters
to you, you can override the library definition to self‑host a specific version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

SCEditor has no configuration screen of its own. You assign it to a text format
under **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **`/admin/config/content/formats`** and add or edit a text format.
2. Set the **Text editor** to **SCEditor**.
3. Configure the format's **filters** — and crucially, keep a sanitising filter
   (such as *Limit allowed HTML tags* or a BBCode filter) enabled on any format
   that untrusted roles can use, because the editor is not XSS‑safe.
4. Save. The SCEditor interface now appears on any textarea‑based field that uses
   that format, and you control which roles may use the format from the same
   screen.
