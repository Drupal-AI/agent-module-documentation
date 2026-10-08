# Azure Blob Storage File System — manual setup guide

**Azure Blob Storage File System** (`az_blob_fs`) lets Drupal store its managed
files — uploads, media, image derivatives — in a Microsoft Azure Blob Storage
container instead of on the local disk. It does this by registering a new
`azblob://` stream wrapper, so from Drupal's point of view Azure behaves like any
other file scheme (such as public or private files).

This is especially useful when you run Drupal in autoscaled or containerized
environments where the local filesystem is ephemeral or shared awkwardly across
instances. Offloading user‑uploaded files to Azure keeps local disk small and
gives you a durable, central place for assets — optionally served through an
Azure CDN. You can switch the whole site's public files over to Azure, or target
just a single file/image/media field's upload destination while everything else
stays local.

Under the hood the module uses the official `microsoft/azure-storage-blob` PHP
SDK and maps normal PHP file operations onto Azure Blob REST calls. It also ships
support for public image styles (image derivatives are served through a
token‑checked delivery route) and an optional **image‑style warmer** that can
pre‑generate or queue selected image styles the moment a file is saved.

One important detail: the Azure storage **account key is never stored in Drupal
configuration**. Instead it lives in a [Key module](https://www.drupal.org/project/key)
entity, and Drupal only stores the *name* of that key. This guide follows the
project's convention of supplying the key value through an environment variable.
Note that the current 3.0.x branch supports **public containers only** — private
container support is on the roadmap.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Azure SDK and Key module), enable it, and check the status report.
2. [Configuration](configuration/index.md) — create the account key, fill in the
   connection settings, and point Drupal at Azure.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Azure Blob Storage File
System** (`/admin/config/media/azure-blob-file-system`), and also appears as a
tab under **Configuration → Media → File system**. Reaching it requires the
**Administer Azure Blob Storage** permission
(`administer azure blob storage`) — treat this as a trusted‑admin permission.

## How to use it

At a high level: install the module and its dependencies, store your Azure
account key with the Key module, enter your account name and container on the
settings form, then either set Azure as the site's default download scheme or set
a specific field's **Upload destination** to Azure. From then on, files written
to those destinations land in your Azure container automatically.
