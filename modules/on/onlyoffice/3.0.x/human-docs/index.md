# ONLYOFFICE Connector — manual setup guide

**ONLYOFFICE Connector** (`onlyoffice`) lets people edit office documents right
inside Drupal using [ONLYOFFICE Docs](https://www.onlyoffice.com/) (the
self‑hosted Document Server). Files stored as Drupal **Media** — Word documents,
spreadsheets, presentations — open in the ONLYOFFICE editor in the browser, and
changes are saved straight back to the same file through a callback. It supports
real‑time and paragraph‑locking co‑editing, previewing files on public pages, and
creating and filling out PDF forms.

Editable formats are DOCX, XLSX, PPTX, and PDF forms; a long list of additional
formats (ODT, RTF, CSV, ODS, ODP, and many more) can be viewed. The module ships
an optional **`onlyoffice_form`** submodule that adds the PDF‑form workflow —
creating, uploading, publishing, and collecting filled‑out forms.

**The security‑critical part is the connection to your Document Server, and this
module handles it correctly — provided you configure it.** The editor's save
**callback** (`/onlyoffice-callback/{key}`, a public URL) is protected two ways.
First, the `{key}` in the URL is an HMAC keyed with your site's `hash_salt` and
`private_key`, so the callback link cannot be forged. Second — and this is the
part you must not skip — **when you set the JWT secret**, the callback controller
verifies a JSON Web Token from the Document Server on every save and rejects any
request without a valid token.

The catch: the JWT secret field says "leave blank to disable", and **leaving it
blank turns off callback JWT verification entirely**. So the single most important
deployment step is to **set the JWT secret** (and configure the same secret on the
Document Server so it requires JWT too). Run the Document Server over **HTTPS**,
and keep that secret confidential. Editing access itself is governed by Drupal's
normal Media permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and optional form
   submodule) with Composer and enable it.
2. [Configuration](configuration/index.md) — point Drupal at your Document Server
   and set the JWT secret.

## Where it lives in the admin menu

The settings form is registered as `onlyoffice.settings_form` — reach it from the
**Extend** page (**Configure** next to *ONLYOFFICE Connector*) or the
**Configuration** section of the admin menu. See
[Configuration](configuration/index.md).

## How to use it

Once connected, open **Content → Media**, find an office file, and choose **Edit in
ONLYOFFICE** from its row's actions — the editor opens in the same tab and saves
back to the same file. To embed editors or previews in pages, add a File or Media
field to a content type and set its display format to the ONLYOFFICE preview; for
PDF forms, enable the `onlyoffice_form` submodule and use **Content → ONLYOFFICE
form** to create, publish, and collect forms.
