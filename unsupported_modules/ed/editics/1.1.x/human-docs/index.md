# editics — manual setup guide

**editics** (`editics`) is a document‑generation stack for Drupal: it turns mapped
Drupal field data into **Word (.docx) and PDF documents** using a template engine,
sending content to a remote **CRI "flux" conversion server** to produce the final
file. It exists because generating desktop documents from Drupal — juggling
libraries and finicky formatting — is normally hard work; editics aims to take a
JSON flow plus a `.docx` template and quickly output a formatted document.

Under the hood, the main module wires up REST convert/editic services and a
validator that talks to the remote CRI server, while a bundled **`cri_php_word`**
submodule (a required dependency) turns mapped field data into Word documents via a
PhpWord‑based `TemplateProcessor`. Two more bundled submodules —
**`cri_core_mapping`** (reads YAML mapping documents that describe how fields map to
template placeholders) and **`cri_demo`** (a preview of mapping output) — round out
the toolkit. It supports a rich set of field types: text, date, image, table,
numeric, percent, currency, checkbox lists, and more, and can embed base64 images
(like a site logo) into a document header.

This is a heavyweight integration meant for teams generating structured documents
from Drupal data, and it needs configuration before it does anything: you must tell
it the URL and credentials of your CRI conversion server. It ships a French UI
translation alongside English.

> **Security note.** editics sends your content, together with **HTTP Basic‑auth
> credentials**, to the configured remote CRI server. Make sure the site and the
> CRI endpoint are reached over properly verified **HTTPS**, keep the credentials
> out of version control, and review the module before production use — in
> particular, be careful never to feed untrusted content through the template
> engine's "Evaluate" field type, which executes template values as code. Treat the
> whole conversion pipeline as a trusted‑administrator surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its bundled submodules.
2. [Configuration](configuration/index.md) — point editics at your CRI conversion
   server and store its credentials.

## Where it lives in the admin menu

The settings form is at **`/admin/api/configuration`**
(`editics.configuration.api`), gated by the core **"Administer site
configuration"** permission. That's where the production and staging ("recette")
server URLs and their credentials are stored. See
[Configuration](configuration/index.md).
