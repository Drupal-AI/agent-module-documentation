# Streamshield — manual setup guide

**Streamshield** (`streamshield`) adds automated, AI-driven content moderation to
your Drupal site by connecting it to the
[Streamshield](https://www.streamshield.ai) moderation service. When users create
nodes or comments of the content types you choose, the module sends their content
to Streamshield, whose machine-learning models scan text (and, per the service,
images, video, and audio) and can decide to flag it. If Streamshield flags a piece
of content, it calls back to your site and the module **unpublishes** it
automatically — keeping offensive material out of public view without a human in
the loop.

Setting it up is a short sequence: register your site with Streamshield to obtain a
domain access key and secret, choose which content types should be moderated, and
optionally run a scan to re-process existing content. From then on, moderation
happens automatically as content is created or updated. The module has no
dependencies beyond Drupal core and supports Drupal 10 and 11.

Streamshield exposes two front-facing endpoints so the external service can talk
back to your site: a **callback** endpoint (`POST /streamshield/callback`) that
unpublishes the node or comment named in a decision, and a **file** endpoint
(`GET /streamshield/file`) that returns file bytes for a requested path. Both are
declared as publicly reachable (`_access: TRUE`) and authenticate requests with the
module's own HMAC-style signature/access-key check. Keep the access and secret keys
stored as secrets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register the site, choose content
   types, and scan existing content.

## Where it lives in the admin menu

The module's admin pages sit under **Configuration → Streamshield**
(`/admin/config/streamshield`), with sub-pages for **Registration**, **Content
Types**, and **Scan**. All of the admin pages are gated by the **Administer site
configuration** permission.
