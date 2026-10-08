# File Access via Webform — manual setup guide

**File Access via Webform** (`file_access_via_webform`) lets you gate a file download
behind a **webform**. A visitor clicks a download button, is asked to complete a
webform (so you can collect their details), and only then receives a secure link to
the file. It is a tidy way to distribute whitepapers, reports, lecture notes, or
other "gated content" while capturing who requested it.

It works through two pieces you configure in the admin UI: a **field formatter**
("Webform Download Button") for file fields, which turns a file into a button that
opens your chosen webform (optionally in a modal), and a **webform handler** ("File
Access Download Redirect") that, on submission, hands the user the download. It works
with direct file fields and with media document references. It depends on the
**Webform** module and core's **File** module.

The access model is sound and uses **defense in depth**. The download route requires
**both** a valid **token bound to that specific file** *and* the user's own core file
access — the two are combined with AND. That means the token is only ever an
*additional* gate; it can never grant access beyond what Drupal's core file access
already permits. The practical consequence: keep genuinely restricted files in the
**private** filesystem (`private://`) so core file access is meaningful — the webform
gate then adds the "you must fill in the form first" step on top of real file access
control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Webform dependency) and enable the module.

There is **no central settings page**. You configure the formatter on a file field's
**Manage display** and add the handler to a webform's **Settings → Handlers** — both
described in "How to use it" below.

## Where it lives in the admin menu

File Access via Webform adds no page of its own. You set it up in two existing
places: **Structure → Content types → *(type)* → Manage display** (for the download
button formatter) and **Structure → Webforms → *(your webform)* → Settings →
Handlers** (for the download-redirect handler).

## How to use it

### 1. Add the download button to a file field

1. Go to **Structure → Content types** (`/admin/structure/types`), pick your content
   type, and open **Manage display**.
2. For your file field, choose the **Webform Download Button** formatter and open its
   settings:
   - **Webform** — select the webform that controls access.
   - **Link text** — the button label (for example "Download Now").
   - **Modal width** — the dialog size if you use a modal (for example "800px").
   - **Show header/title** — toggle the modal header's visibility.

### 2. Add the handler to the webform

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and open (or create)
   the webform you selected above.
2. Under **Settings → Handlers**, add the **File Access Download Redirect** handler,
   and configure:
   - **File disposition** — "inline" to view the file in the browser, or
     "attachment" to force a download.
   - **Download message** — a custom message shown after submission (for example
     "Your file is downloading…").
   - **File URL security** — "enhanced" for token-based URLs, or "standard" for
     direct URLs.
   - **Debug mode** — enable only while troubleshooting; disable it in production.

### 3. Test it

Create a node with the file field and the configured formatter, visit it, click the
download button, submit the webform, and confirm the file downloads. Make sure the
webform is accessible to your intended audience (check **People → Permissions**), and
keep restricted files in `private://` so the underlying core file access is real.
