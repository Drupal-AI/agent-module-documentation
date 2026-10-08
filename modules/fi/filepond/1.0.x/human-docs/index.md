# FilePond — manual setup guide

**FilePond** (`filepond`) brings the popular
[FilePond](https://pqina.nl/filepond/) JavaScript upload library into Drupal — a
modern, drag‑and‑drop file uploader with image previews, reordering, clipboard
paste, chunked uploads, and optional cropping. If you've used DropzoneJS, you'll
recognise the same building blocks here (a form element, an Entity Browser widget,
and Media Library integration), plus extras like an image field widget and paste
support.

It's designed to work out of the box: by default the module loads the FilePond
library and its plugins from a public CDN, so there's nothing to install beyond the
module itself. If you'd rather host the JavaScript yourself, you can turn off the
CDN and provide the libraries locally.

FilePond is also handy on sites using cloud storage such as S3. Uploaders normally
have a bottleneck there — saving an image field means downloading the file back
from the remote store just to read its dimensions. FilePond captures those
dimensions while the file is still local during upload, and uses async and chunked
uploads, which makes saving dramatically faster.

A word on safety: FilePond is a **content‑editing convenience, not a security
boundary**. Uploaded files are ordinary managed files governed by normal Drupal file
access, and the real protection is Drupal's **server‑side upload validation** —
allowed extensions, size limits, and file access. The client‑side widget is there
for the experience, not to enforce rules, so keep your allowed extensions
restricted.

FilePond works on **Drupal 10.2 and 11**, depends on core **File**, and provides
its own permissions. It ships several optional submodules (crop, an Entity Browser
widget, Views integration, and a benchmarking helper).

> **Note:** This project is **not currently covered by Drupal's security advisory
> policy**, and this 1.0.x release is an alpha. Weigh that before using it on a
> production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose CDN or self‑hosted libraries; plus the submodules.
2. [Configuration](configuration/index.md) — the global FilePond settings and how
   to apply the widget to a field.

## Where it lives in the admin menu

Once enabled, the global settings sit at **Configuration → Media → FilePond**
(`/admin/config/media/filepond`). The uploader itself is applied per field on a
bundle's **Manage form display**, and (optionally) as a Media Library or Entity
Browser widget.

## How to use it

1. Enable the module (the CDN default means it works immediately).
2. On a bundle's **Manage form display**, set an image or file field's widget to the
   **FilePond** widget, or enable the Media Library integration to replace core's
   uploader.
3. Adjust the global defaults at **Configuration → Media → FilePond**, overriding
   per element where needed.
