# HTTP Client Manager Issuu Oembed — manual setup guide

**HTTP Client Manager Issuu Oembed** (`http_client_manager_issuu_oembed`) is an
integration module that adds an **Issuu oEmbed API client** on top of the
[HTTP Client Manager](https://www.drupal.org/project/http_client_manager) module.
Its job is to fetch oEmbed metadata for Issuu publications — the documents and
flipbooks published at `https://issuu.com/*/docs/*` — from Issuu's oEmbed endpoint
(`https://issuu.com/oembed`), using HTTP Client Manager's managed, consistently
configured HTTP client.

Beyond the raw API client, it ships an **ECA activity template** for the
[ECA](https://www.drupal.org/project/eca) (Event–Condition–Action) module. That
lets you build a no-code model that fetches an Issuu document's thumbnail URL and
description and sets them on a Drupal Media entity — for example populating a custom
Issuu media bundle's thumbnail and description automatically.

This is developer/site-builder plumbing: it has no content or access role of its
own, and it is most useful in combination with ECA. You enable it because you want
Issuu oEmbed data available to your site's integrations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its HTTP Client Manager dependency.

There is **no dedicated settings form** for this module. You use it through ECA
models (or programmatically via HTTP Client Manager), as described below.

## How to use it

After installation:

1. Install and enable the **ECA** module (and the ECA sub-module for your chosen
   modeller).
2. In an ECA model, use the **Issuu Oembed Services API** activity to fetch oEmbed
   data — for example the thumbnail URL and description for a custom Drupal Media
   bundle representing Issuu documents.

> **Known requirement for ECA integration:** to let ECA read the fetched result
> from the module's private temporary key-value store (collection
> `http_client_manager`, store key `last result`), the ECA module currently needs
> the patch from
> [issue #3330979 — "New actions to access key value stores"](https://www.drupal.org/project/eca/issues/3330979).
> This patch will no longer be needed once that issue is merged into a stable ECA
> release.
