# Mautic Paragraph — manual setup guide

**Mautic Paragraph** (`mautic_paragraph`) lets you embed **Mautic** marketing forms
and content directly in Drupal pages. It creates a **Mautic paragraph type** and a
**Mautic block type**, so editors can drop a Mautic form onto a page the same way
they add any other paragraph or block — no manual embed code required.

Mautic is an open‑source marketing‑automation platform. This module connects to a
chosen Mautic instance, retrieves the list of **forms** defined there, and lets an
editor pick one to display. It supports multiple **authentication methods** for
fetching that form list, including OAuth2.

Because embedding Mautic content means loading a **third‑party marketing script** on
your page, there are tracking implications: gate the embed behind consent where your
jurisdiction requires it, and keep the Mautic connection details (API credentials,
OAuth secrets) stored securely. For a site already running Mautic, this module makes
embedding its forms feel native.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls the
   Mautic API library) and enable the module.
2. [Configuration](configuration/index.md) — connect to Mautic, choose an
   authentication method, and pick how forms are selected.

## Where it lives in the admin menu

You connect to Mautic at **Configuration → Web services → Mautic**
(`/admin/config/services/mautic`), and you tune how forms are chosen on the Mautic
paragraph type's form display at
`/admin/structure/paragraphs_type/mautic/form-display`. After that, editors add a
**Mautic** paragraph or block wherever they want a form to appear.
