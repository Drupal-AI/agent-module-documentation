# Automatic Image Moderation — manual setup guide

**Automatic Image Moderation** (`image_moderate`) automatically screens uploaded
images for **adult** and **racist/offensive** content, using Microsoft Azure
Cognitive Services' Computer Vision image‑moderation API. It's aimed at sites that
let users upload images — community sites, profile pictures, user posts — where an
automated first‑level scan saves moderators a lot of manual review.

When someone uploads an image, the module sends it to the moderation API. If
potentially offensive content is detected, a **warning** is shown. The user can
still save the content, but the module blocks publishing and sets the status to
**unpublished**. A moderator or administrator then reviews the flagged content and
decides whether to allow the image. When they change the review status to *Reviewed,
can be published*, the content becomes publishable again (assuming no other image is
still blocking it) — the publish status must then be set manually. Moderation
results are stored as their own entities so this review workflow has something to
act on.

Two things matter for setup. First, screening **sends uploaded images to an external
API**, so images leave your site — weigh the privacy and cost implications, and store
the API credential securely (see below). Second, this project is **not covered by
Drupal's security advisory policy** and this is a development release (`1.x-dev`), so
evaluate it accordingly. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — connect the Azure moderation API and
   set up the reviewer permissions and workflow.

## Where it lives in the admin menu

The module's settings live at
**Administration → Configuration → Media → Image Moderate**
(`/admin/config/media/image_moderate`). Reviewer access is granted on
**People → Permissions**.
