<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Azure Blob Storage File System registers an `azblob://` Drupal stream wrapper backed by a Microsoft Azure Blob Storage container, so Drupal-managed files (uploads, media, image derivatives) can live in Azure instead of on the local disk.

---

The module wires the `microsoft/azure-storage-blob` PHP SDK into Drupal as a stream wrapper (scheme `azblob`, service `stream_wrapper.az_blob_fs`) that maps normal file operations (`fopen`/`file_get_contents`/`file_put_contents`, `rename`, `unlink`, `opendir`) onto Azure Blob REST calls — blobs are written in blocks, virtual folders are derived from blob-name prefixes, and MIME content types are set from a built-in extension map. Connection details (account name, container, protocol, optional CDN hostname, optional US GovCloud endpoint, optional local-emulator IP/port) are stored in `az_blob_fs.settings`, while the **storage account key is held as a Key-module `authentication` key** (only the key name is stored in config) and read at runtime through `@key.repository`. An admin sets these at `/admin/config/media/azure-blob-file-system` (permission `administer azure blob storage`, `restrict access: true`), then points core's *File System* settings or a specific file/media field's *Upload destination* at Azure. For public image styles the module ships a custom download controller and inbound path processor: image derivative URLs under `/azblob/files/styles/…` are token-checked (the standard core `IMAGE_DERIVATIVE_TOKEN`) and the generated derivative is streamed back, while an optional **image-style warmer** pre-generates or queues selected image styles when a file entity (or crop) is saved. `getExternalUrl()` returns the public Azure blob URL, optionally rewritten to a configured CDN hostname. A `hook_requirements()` check enforces the presence of the Azure SDK, `allow_url_fopen`, account-name/key configuration, and warns on 32-bit PHP (2GB file limit). The current 3.0.x branch documents public containers only (private-container support is on the roadmap).

---

- Store Drupal file uploads in an Azure Blob Storage container instead of the local filesystem.
- Serve a whole site's public files from Azure by setting Azure as the default download (public) scheme.
- Keep local disk small on autoscaled/containerized Drupal by offloading user-uploaded files to Azure.
- Set a single media or file field's *Upload destination* to Azure while leaving other fields on public files.
- Back the core Media library with Azure-hosted originals (e.g. the Image media type's source field).
- Read and write blobs from custom code using ordinary PHP file functions against `azblob://` URIs.
- Generate a public URL for an Azure-stored file via the stream wrapper's `getExternalUrl()`.
- Serve Azure blobs through an Azure CDN by configuring a CDN hostname that rewrites blob URLs.
- Pre-generate selected image styles the moment a file is saved (initial image-style warming).
- Queue heavier image-style generation for a background worker instead of generating on request.
- Regenerate image styles for Azure-stored images when an image crop is added or changed.
- Deliver token-protected public image derivatives for Azure-stored images via `/azblob/files/styles/…`.
- Target Azure US Government Cloud by enabling the GovCloud endpoint (`core.usgovcloudapi.net`).
- Develop and test against a local Azure Storage emulator (Azurite/Azkite) using emulator IP/port settings.
- Migrate file storage off Amazon S3 to Azure while keeping Drupal's file API unchanged.
- Manage the Azure account key with the Key module (env var, file, or other key provider) rather than a raw form field.
- List, rename, and delete blobs and virtual folders through Drupal's file-system API.
- Copy-then-delete rename semantics for moving an Azure-stored file to a new path.
- Set correct `Content-Type` on stored blobs automatically from the file extension.
- Enforce HTTPS (or explicitly choose HTTP) for the Azure blob endpoint per site policy.
- Verify environment readiness (SDK present, `allow_url_fopen` on, credentials set) via the status report.
- Share public assets from an Azure container whose access level is set to *Container*/*Blob*.
