# Configuration

Setting up Azure Blob Storage File System is a three‑step job: store your Azure
account key with the Key module, enter your connection details on the settings
form, then tell Drupal which files should go to Azure.

## Step 1 — Store the Azure account key

The Azure storage **account key is a secret and must never be committed or typed
into a config field**. Following the project convention, store it in an
environment variable and expose it to Drupal through a Key entity.

1. Save the value into DDEV's dotenv file (from your host):

   ```bash
   ddev dotenv set .ddev/.env --az-blob-key=<your-azure-account-key>
   ddev restart
   ```

   The flag `--az-blob-key` becomes the environment variable `AZ_BLOB_KEY`.
   Never commit `.ddev/.env`.

2. Create a Key entity of type **authentication** that reads that variable:

   ```bash
   ddev drush key:save az_blob_key --label='Azure Blob Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"AZ_BLOB_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

The module stores only the **name** of this key (`az_blob_key`) in its config and
resolves the actual value at runtime — the secret itself stays out of Drupal's
configuration entirely. The key must be of type *authentication* for it to appear
in the settings form's key selector.

## Step 2 — Enter the connection settings

1. Log in as a user with the **Administer Azure Blob Storage** permission.
2. Go to **Configuration → Media → Azure Blob Storage File System**
   (`/admin/config/media/azure-blob-file-system`).

Fill in the form:

- **Account name** *(required)* — your Azure storage account name.
- **Account key** *(required)* — pick the Key entity you created in Step 1 (its
  name, not the value). Only *authentication*‑type keys are listed.
- **Container name** — the blob container to store files in. For public assets,
  set the container's access level to *Container* (or *Blob*) in Azure.
- **Protocol** — `https` (default and recommended) or `http` for the blob
  endpoint.
- **CDN host name** — optional. If set, generated file URLs are rewritten to
  point at this Azure CDN host instead of the raw blob endpoint.
- **US GovCloud endpoint** — enable this only if your account is on Azure US
  Government Cloud (uses the `core.usgovcloudapi.net` endpoint suffix).
- **Local emulator** settings — for local development against the Azurite storage
  emulator. Enabling emulator mode reveals **IP** (pre‑filled `127.0.0.1`) and
  **port** (pre‑filled `10000`) fields. Leave these off for production.
- **Initial image styles** — image styles to generate immediately whenever a file
  is saved (see "Image‑style warming" below).
- **Queue image styles** — image styles to queue for background generation when a
  file is saved.

Click **Save configuration**.

## Step 3 — Point Drupal at Azure

There are two independent ways to route files to the `azblob` scheme:

- **Site‑wide default** — at **Configuration → Media → File system**
  (`/admin/config/media/file-system`), set the default download (public) scheme
  to *Azure Blob Storage*. All new public files across the site will then be
  stored in Azure.
- **Per field** — on any file, image, or media field's **Field settings**, set
  **Upload destination** to *Azure Blob Storage*. This lets you send just that
  one field's files to Azure while other fields stay on local public files. The
  Azure scheme appears alongside *Public files* in the destination list.

## Image‑style warming (optional)

When configured, the module can pre‑build image derivatives so they're ready
before a visitor requests them, which avoids the first‑hit generation delay:

- Styles you list under **Initial image styles** are generated *immediately*
  when a file (or crop) is saved.
- Styles you list under **Queue image styles** are pushed to a background queue
  (`az_blob_fs_images_pregenerator`) to be generated later. **Note:** the 3.0.x
  branch ships no queue worker for this queue, so queued items need your own
  worker (or a future release) to actually process them. If you want reliable
  warming today, prefer the *Initial image styles* option.

Public image derivatives for Azure‑stored images are served through a
token‑protected route under `/azblob/files/styles/…`, using core's standard
image‑derivative token — so the URLs are safe to expose publicly.

## Using it from code (optional)

Once configured, treat `azblob://` like any Drupal scheme with ordinary PHP file
functions — `file_put_contents('azblob://docs/report.pdf', $bytes)`,
`file_get_contents(...)`, `rename(...)`, `unlink(...)`. See the sibling
[`agent/`](../../agent/api/services.md) docs for the service and method reference.
