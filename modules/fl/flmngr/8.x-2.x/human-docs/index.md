# Flmngr File Manager — manual setup guide

**Flmngr File Manager** (`flmngr`) adds a full file manager to your CKEditor
toolbar. Once enabled it attaches itself to your file-choose fields and places
Flmngr buttons on the CKEditor toolbar (CKEditor 4 and CKEditor 5), so editors can
upload files and images, browse and organise them, and use extras such as a
built-in image editor (crop, resize, transform) and a search across free stock
photos from Unsplash. It integrates deeply with Drupal and checks user
permissions, denying file modification to site visitors by default.

There is one architectural fact that is important to understand before you rely on
it: **Flmngr's file-manager backend is external.** The Drupal module ships no
file-manager endpoint of its own — the actual browsing and uploading are handled by
an external Flmngr backend (Flmngr's hosted service, or a separately installed
Flmngr server component) that the CKEditor plugin talks to. That means the
security-relevant settings for uploads — who may upload, which file extensions are
allowed, path handling, and where files are stored — live in that **external
backend's configuration**, not in Drupal. Configure that backend's restrictions
carefully, because that is where uploads are actually accepted, and protect the API
key/URL that connects Drupal to the Flmngr service as the credential it is.

Flmngr works with your own server storage for free and has an optional **paid**
feature for Amazon S3 or Azure Blob storage.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — add the Flmngr buttons to a text
   format's toolbar, connect the backend, and where the real upload restrictions
   live.

## Where it lives in the admin menu

Flmngr does not register a single "Flmngr settings" page. In practice you set it up
in two places: **Configuration → Content authoring → Text formats and editors**
(to add the Flmngr buttons per text format), and the **external Flmngr backend's**
own configuration (for upload restrictions and storage).
