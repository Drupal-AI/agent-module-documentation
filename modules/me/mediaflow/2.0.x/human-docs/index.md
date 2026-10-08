# Mediaflow — manual setup guide

**Mediaflow** (`mediaflow`) connects Drupal to the
[Mediaflow](https://www.mediaflow.com/) digital asset management (DAM) platform, so
editors can browse and search your organisation's Mediaflow image and video library
directly inside Drupal and insert assets without downloading them first. When an
asset is chosen, its file is transferred into Drupal as a managed file, so your
site's performance and ongoing functionality do not depend on Mediaflow at display
time. Mediaflow's licensing, consent and quality controls are respected, and the
module reports back to Mediaflow when, where and by whom each asset is used.

It plugs into Drupal in several ways: a **`mediaflow` media source**, a custom
field type/widget/formatter for Mediaflow items, a **CKEditor 5 plugin** for
embedding assets inline in rich text, and a picker element that opens the Mediaflow
library from an editor form. Selected images are downloaded into `public://mediaflow/`,
and (if you use the Content‑Security‑Policy module) Mediaflow's hosts are
whitelisted automatically.

Mediaflow requires configuration before it works: you must enter three Mediaflow
API credentials — a **client id**, **client secret** and **refresh token** — on its
settings form, which the module uses to authenticate to the Mediaflow API (an
OAuth2 refresh‑token grant) and to auto‑renew access tokens behind the scenes. It
depends on core **Media** and **CKEditor 5**, and works on Drupal 10.2 and 11.
Access is gated by two permissions: **`administer mediaflow`** (configure the
integration — restrict this) and **`use mediaflow`** (use assets).

> **Upgrading from 1.x?** Earlier versions had two of the three API keys hardcoded.
> From version 2.x you must enter all three keys yourself, so contact
> support@mediaflow.com to obtain a new set of API keys — the old ones are being
> retired.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Media and CKEditor 5.
2. [Configuration](configuration/index.md) — enter your Mediaflow API credentials
   and set the asset options.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Mediaflow**
(`/admin/config/media/mediaflow`), behind the **`administer mediaflow`**
permission.

## How to use it

Once the credentials are in place:

1. Create a **media type** whose source is **Mediaflow**, and/or add a **Mediaflow
   field** (using the Mediaflow widget) to a content type — the picker element opens
   the Mediaflow library.
2. Enable the **Mediaflow button** in a text format's CKEditor 5 toolbar to let
   editors embed assets inline in rich text.
3. Editors browse and search the Mediaflow library from the editor UI, select an
   asset, and it is imported into Drupal (images land in `public://mediaflow/`).
   Usage is reported back to Mediaflow automatically, and removed when the content
   is deleted.
