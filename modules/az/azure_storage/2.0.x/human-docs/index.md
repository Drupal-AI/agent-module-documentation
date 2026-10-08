# Azure Storage Integration — manual setup guide

**Azure Storage Integration** (`azure_storage`) lets Drupal keep its files in **Azure
Blob Storage** instead of on the local disk. It provides a stream wrapper, so managed
files and images can be stored in and served from Azure — handy when you want scalable,
offloaded storage or you run several instances of the site that all need to share the
same files.

Once configured, files that use the Azure scheme are written to and read from your
Azure Storage container rather than the server's filesystem. It works across a wide
range of Drupal versions (8.8.3 through 11) and sits in the Media area.

To reach Azure the module authenticates with a **storage account key** (or connection
string). That is a secret — keep it out of plaintext config and out of the webroot, and
supply it from the environment. You also choose whether the container's blobs are
public or private, which must match the privacy of the files you put there (private
files must not be publicly readable). Requests to Azure use TLS. See
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — connect to your storage account and set
   container access.

## Where it lives in the admin menu

The connection and container settings are configured at the module's settings form
(route `azure_storage.settings_form`). The module defines its own permission for
administering those settings.
