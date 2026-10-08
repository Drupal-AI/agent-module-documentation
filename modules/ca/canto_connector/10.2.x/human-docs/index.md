# Canto Connector — manual setup guide

**Canto Connector** (machine name **`connector_canto`**, project **`canto_connector`**)
integrates the **Canto** digital‑asset‑management (DAM) platform — "Canto Flight" — with
Drupal, so editors can browse assets stored in Canto and insert them directly into
rich‑text (CKEditor) content. It ships a CKEditor 5 plugin: from the editor an author opens
a Canto picker dialog, chooses assets, and on submit the server fetches each selected asset
and creates a Drupal **File** and **Media** entity for it.

Use it when your organisation keeps its images and assets in Canto and wants them available
in the WYSIWYG without manual downloading and re‑uploading. It depends on core **Editor**.
Access to Canto is authenticated per user via **OAuth**: tokens obtained in the browser are
stored per user, and a valid Canto login is needed for the picker to populate.

This module needs configuration before it is useful — at minimum you select which Canto
region/domain your account lives in. It works once that is set and users have connected
their Canto accounts.

TLS verification is left at cURL's defaults (it is **not** disabled), and database access
uses parameterised query builders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — select your Canto region and connect editor
   accounts.

## Where it lives in the admin menu

The settings form is at **Configuration → Search and metadata → Canto Connector**
(`/admin/config/search/connector_canto`, route `connector_canto.admin_settings_form`),
gated by the **Administer site configuration** permission. The module also declares an
**Administer connector_canto** permission for module administration.

## How to use it

Once the region is configured and an editor has connected their Canto account, they edit a
rich‑text field, open the Canto picker from the CKEditor toolbar, and choose assets. On
submit the server retrieves each chosen asset into the public files directory and creates a
File plus a Media entity, which is then inserted into the content. The dialog notes a
client‑side size limit of 128 MB per asset.
