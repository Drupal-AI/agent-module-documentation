<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — az_blob_fs

Admin UI: `/admin/config/media/azure-blob-file-system` (route `az_blob_fs.settings_form`, form
`\Drupal\az_blob_fs\Form\AzBlobFsSettingsForm`). Gated by permission **`administer azure blob storage`**
(`restrict access: true` — treat as a trusted-admin permission). A tab also appears under
*Configuration → Media → File system*.

## Config object `az_blob_fs.settings`

Schema: `config/schema/az_blob_fs.schema.yml`. Keys (install defaults in parentheses):

| Key | Type | Meaning |
|---|---|---|
| `az_blob_account_name` | string (`''`, required) | Azure storage account name. |
| `az_blob_account_key_name` | string (`''`, required) | **Key-module key id** holding the account key (type `authentication`). NOT the key value. |
| `az_blob_container_name` | string (`''`) | Target blob container. README advises access level *Container* for public assets. |
| `az_blob_protocol` | string (`https`, required) | `http` or `https` for the blob endpoint. |
| `az_blob_cdn_host_name` | string (`''`) | If set, blob URLs are rewritten to this host (Azure CDN). |
| `az_blob_gov_endpoint` | bool (`0`) | Use Azure US GovCloud endpoint suffix `core.usgovcloudapi.net`. |
| `az_blob_local_emulator` | int (`0`) | Enable local Storage emulator mode (Azurite). |
| `az_blob_local_ip` | string (`''`) | Emulator IP (form ajax pre-fills `127.0.0.1`). |
| `az_blob_local_port` | string (`''`) | Emulator port (form ajax pre-fills `10000`). |
| `az_blob_initial_image_styles` | sequence (`{}`) | Image styles generated immediately on file save. |
| `az_blob_queue_image_styles` | sequence (`{}`) | Image styles queued for background generation on file save. |

The account **key value never lives in this config** — only the key name. The value is resolved at
runtime by `AzBlobFsService::getAzBlobProxyClient()` via `@key.repository->getKey($name)->getKeyValue()`.
Because the key filter is `['type' => 'authentication']`, create the Key as key-type `authentication`
(any provider: env var, file, config, etc.).

## Set the key with Drush (example)

```bash
# key value via env provider (see project AGENTS.md for the env-var pattern)
drush key:save az_blob_key --label='Azure Blob Key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"AZ_BLOB_KEY","base64_encoded":false}' \
  --key-input=none -y
drush config:set az_blob_fs.settings az_blob_account_key_name az_blob_key -y
drush config:set az_blob_fs.settings az_blob_account_name mystorageacct -y
drush config:set az_blob_fs.settings az_blob_container_name mycontainer -y
```

## Point Drupal at Azure

Two independent ways to route files to the `azblob` scheme:

1. **Site default** — set the default download (public) scheme to Azure at
   `/admin/config/media/file-system` (`system.file_system_settings`). Affects new public files site-wide.
2. **Per field** — on a file/image/media field's *Field settings*, set **Upload destination** to
   *Azure Blob Storage*. The stream wrapper advertises itself as a normal writable target
   (`AzBlobFsStream::getName()` = "Azure Blob Storage"), so it appears alongside *Public files*.

## Image-style warming

`az_blob_fs.image_styles_warmer` (`AzBlobImageStylesWarmer`) runs on `hook_ENTITY_insert/update` for
`file` and `crop` entities (`az_blob_fs.module`). For a permanent file whose URI uses the `azblob`
scheme and validates as a supported image:
- styles in `az_blob_initial_image_styles` are generated inline (`createDerivative`);
- styles in `az_blob_queue_image_styles` are pushed to queue `az_blob_fs_images_pregenerator`.
  (Note: 3.0.x ships no QueueWorker plugin for that queue — queued items require your own worker or a
  future release to process.)

## Public image derivative delivery

Derivative URLs take the form `/azblob/files/styles/{image_style}/{scheme}?file=…`. The inbound path
processor `AzBlobFsPathProcessorImageStyles` (priority 310, schemes `public`/`azblob`) moves the file
path into the `file` query arg, and `AzBlobFsImageStyleDownloadController::deliver()` (extends core
`ImageStyleDownloadController`) validates the core `IMAGE_DERIVATIVE_TOKEN` (`hash_equals`), generates
the derivative under a lock, and streams it. `private` scheme is explicitly rejected here.

## Requirements / status report

`az_blob_fs_requirements()` reports errors/warnings on: missing `microsoft/azure-storage-blob` SDK
(install phase), `allow_url_fopen` disabled, missing account name/key config (runtime warning linking to
the settings form), and 32-bit PHP (2GB file-size warning). Check *Reports → Status report* after setup.
