# N1ED — manual setup guide

**N1ED** (`n1ed`) is a cloud-backed add-on that supercharges CKEditor (both
CKEditor 4 and CKEditor 5) with three tools from the N1ED ecosystem: the **N1ED**
visual / Bootstrap editor (a WYSIWYG page builder that inserts responsive images
and Bootstrap grids and components), the **Flmngr** file manager (browse, upload,
rename, move, copy, delete, and resize files right inside the editor), and the
**ImgPen** in-browser image editor (crop, rotate, effects).

The editor front-end is **loaded from the N1ED cloud/CDN and keyed by an API key**.
The module ships with a public **demo** key so you can try it immediately; to unlock
the full online services you link your own free or paid N1ED account and set its API
key. Because of this, N1ED is not fully self-hosted — it contacts `cloud.n1ed.com`
to resolve your integration type and loads editor assets from the CDN.

On install the module attaches itself to "Full HTML"-style text formats (those not
restricted by the *Limit allowed HTML tags* filter) and creates the file
directories Flmngr uses. You then fine-tune it per text format. It also provides a
PHP file-manager backend so editors can manage uploaded files.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the PHP
   extension requirements, and enable the module.
2. [Configuration](configuration/index.md) — enabling N1ED per text format, the API
   key, the advanced settings form, the Flmngr toggles, and permissions.

## Where it lives in the admin menu

N1ED is mainly configured **per text format** at *Configuration → Content authoring
→ Text formats and editors* (`/admin/config/content/formats`), inside each format's
CKEditor toolbar/plugin settings. A small **advanced** settings form lives at
*Configuration → Content authoring → N1ED* (`/admin/config/content/n1ed`).

## How to use it

Because the module auto-enables itself on Full-HTML-style formats during install,
editors using those formats will see the N1ED tools right away (running on the demo
API key). To make it production-ready you link a real N1ED account and set its API
key, decide which text formats should carry the editor, and grant the file-manager
permission to the right roles. The step-by-step is in
[Configuration](configuration/index.md).
