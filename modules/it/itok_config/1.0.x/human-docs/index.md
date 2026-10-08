# Itok Config — manual setup guide

**Itok Config** (`itok_config`) lets you **disable the `itok` token per image
style**. The `itok` is the short query-string signature Drupal core appends to
image-style derivative URLs (for example `?itok=AbC123`). It exists as an
**anti-DoS protection**: it stops an attacker from requesting endless
not-yet-generated derivative variations to hammer your server. This module lets you
turn that signature **off for specific image styles**, which produces predictable,
CDN-friendly derivative URLs.

That predictability is the whole point — and also the trade-off. **Disabling `itok`
makes those derivative URLs guessable**, which removes the protection core added, so
only do it for image styles where that is genuinely acceptable (for instance behind
a CDN whose caching behaviour you control). It depends only on core's **Image**
module and works on Drupal 9, 10, and 11.

> **Heads-up:** this project has been **abandoned** by its maintainer, who now
> recommends [Image Derivative Token](https://www.drupal.org/project/image_derivative_token)
> instead. For a new site, prefer that module. This guide is kept for sites already
> using Itok Config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — how to disable `itok` on a chosen image
   style, and what you are trading away.

## Where it lives in the admin menu

Itok Config adds no separate settings page. It adds an option to each **image
style's own edit form** under **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`) — see [Configuration](configuration/index.md).
