<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure Blob Storage File System — agent index

Registers an `azblob://` stream wrapper (service `stream_wrapper.az_blob_fs`, scheme `azblob`) backed
by an Azure Blob container via the `microsoft/azure-storage-blob` SDK. Depends on core `image` and the
`key` module (the account key is a Key entity, not a config value). Settings live in
`az_blob_fs.settings`; UI at `/admin/config/media/azure-blob-file-system`
(route `az_blob_fs.settings_form`, permission `administer azure blob storage` — `restrict access: true`).
No Drush, no plugin types, no invited hooks (`*.api.php`).

- **All settings keys, the settings form, the Key requirement, choosing Azure as a scheme / field
  upload destination, image-style warming, requirements checks** → [configure/settings.md](configure/settings.md)
- **Services and public methods for code: the `azblob://` wrapper, `az_blob_fs` service, the blob
  proxy client, the image-style warmer, external/CDN URLs** → [api/services.md](api/services.md)

Key facts:
- Scheme `azblob` → e.g. `azblob://path/to/file.jpg`; works with standard PHP file functions.
- Config object `az_blob_fs.settings` (schema `config/schema/az_blob_fs.schema.yml`); default install
  values are all empty/`https`.
- Account key stored via Key module (`az_blob_account_key_name` = key id; value read through
  `@key.repository`), NOT in `az_blob_fs.settings` itself.
- Public image derivatives served by `AzBlobFsImageStyleDownloadController` at
  `/azblob/files/styles/{image_style}/{scheme}` — core `IMAGE_DERIVATIVE_TOKEN` required (standard
  image-style token check).
- 3.0.x supports **public containers only**; private containers are on the roadmap.
