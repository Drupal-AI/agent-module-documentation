# Imageshop — manual setup guide

**Imageshop** (`imageshop`) connects Drupal to [Imageshop](https://www.imageshop.no/),
a cloud-based Digital Asset Management (DAM) service where an organisation stores
its images, videos, and documents. With this module installed, editors pick
images from an embedded Imageshop browser — searching, cropping, and selecting
inside an iframe — instead of (or alongside) uploading into Drupal's own media
library. The selected asset then flows back into the Drupal field or media
library form.

Under the hood the module authenticates to Imageshop with a **permanent token**
and a **private key** that an administrator enters on the module's settings form.
On demand (and on cron) it exchanges those long-lived credentials for a
short-lived temporary token by calling the Imageshop web service, and caches that
temporary token for 24 hours. A permission-gated route renders the iframe that
points at Imageshop's own image chooser. The module works with core image fields,
the Media Library, and — through the Media Library — CKEditor.

Two things are worth flagging before you deploy it. First, it talks to an external
service, so the site needs outbound network access to Imageshop and you are
handing image selection to a third party. Second — see
[Configuration](configuration/index.md) — the token and private key are live
credentials, so keep them out of version control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Imageshop credentials,
   grant access, choose media types, and tune the browser — including how to keep
   the secrets out of version control.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Imageshop**
(`/admin/config/media/imageshop`). The image chooser itself renders at
`/imageshop/iframe`, which is gated by the **access imageshop** permission that
editorial roles need.

> **Heads-up on a known permission mismatch.** In this release the settings route
> requires a permission (`administer imageshop`) that the module does not actually
> define — only `administer imageshop configuration` exists. As shipped, the
> settings page can therefore be unreachable until that mismatch is reconciled in
> code. If you cannot open `/admin/config/media/imageshop` even as an
> administrator, this is why; see the note in [Configuration](configuration/index.md).
