# Image Style List Enhanced — manual setup guide

**Image Style List Enhanced** (`imagestylelistenhanced`) improves the admin
pages that list your image styles and responsive image styles. Drupal's stock
listing shows styles by name and describes their effects in words, which is fine
until a site has accumulated a dozen or more styles and you are trying to work
out which one is which. This module makes that overview clearer — adding previews
and a tidier presentation — so managing image styles is a matter of looking
rather than reading.

It is a pure administration convenience. It changes only the admin listing UI, it
adds no content, and it has no bearing on access control or on what visitors see
on the front end. There is nothing to switch on beyond enabling the module, and
no settings to fill in — the improved listing simply appears on the existing
image-styles pages once the module is on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. The
enhanced listing appears automatically once the module is enabled.

## Where it lives in the admin menu

The module adds no page of its own. Its improvements show up on the existing core
screens: **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`) and the responsive image styles list.
