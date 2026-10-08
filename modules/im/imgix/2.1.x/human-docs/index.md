# Imgix — manual setup guide

**Imgix** (`imgix`) renders your Drupal images through
[Imgix](https://www.imgix.com/), a real‑time image processing service and CDN.
Instead of Drupal generating image derivatives (resizing, cropping, format
conversion, optimization) on your own server and serving them from your own
filesystem, the module hands that work to Imgix: derivatives are generated
on‑demand by Imgix and delivered from its global CDN. That offloads image
processing and speeds up delivery, and it depends only on core's File module.

You point the module at an **Imgix source** (the domain Imgix serves your images
from, backed by your originals), and from then on Imgix builds the transformed URLs.
If you use Imgix's **secure URLs** feature, transformations are signed with a secret
token so nobody can request arbitrary transformations of your images.

Two things are worth keeping in mind. First, treat the Imgix secure‑URL/API token
as a **secret** — store it in an environment variable, not in committed config
(see [Configuration](configuration/index.md)). Second, because images travel
through Imgix's CDN, this is a data‑flow decision for **private or
access‑restricted images**: don't route images that should stay behind Drupal's
access controls through a public CDN source. Imgix is a media/performance feature
and plays no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Imgix source, store the
   secure‑URL token safely, and use the Imgix field formatter.

## Where it lives in the admin menu

Once enabled, configure the module from its settings form under
**Configuration → Media**, where you enter your Imgix source domain and secure‑URL
token. You then choose the Imgix formatter on your image field's **Manage display**
to actually render images through Imgix. See [Configuration](configuration/index.md)
for the details.
