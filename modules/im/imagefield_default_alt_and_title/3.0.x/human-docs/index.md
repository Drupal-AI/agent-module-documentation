# Imagefield Default Alt And Title — manual setup guide

**Imagefield Default Alt And Title** (`imagefield_default_alt_and_title`) fills
in the **alt** and **title** attributes of image fields automatically, using the
title of the content the image belongs to. Empty alt text is the single most
common accessibility failure on content-managed sites, and it usually happens
for a simple reason: an editor adding six images to an article is not going to
stop and write six descriptions. This module gives every image a default so that
none are left blank.

The default it produces is the host entity's title. That is an honest trade-off,
worth understanding before you rely on it: a title-derived alt tells a screen
reader *what the image belongs to* rather than *what it shows*. For an
illustrative photo accompanying an article that is often good enough; for an
informational diagram or chart it is not, and a purely decorative image should
really have an empty alt rather than a repeated title. Think of it as a baseline
that is better than nothing, not a replacement for a written description on
images that carry meaning.

The part that earns the module its place is the **batch form**. A site that has
accumulated thousands of images with empty alt attributes — after a migration,
or years of editing without an alt-text habit — can have them all backfilled in
one operation instead of image by image. A settings form lets you narrow which
content types the module acts on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form and the batch
   backfill page, field by field.

## Where it lives in the admin menu

Once enabled, the module's settings sit at **Configuration → Search and metadata
→ Imagefield Default Alt And Title**
(`/admin/config/search/imagefield-default-alt-and-title`), and the one-off batch
backfill runs from a page linked there (`.../batch-page`). Both require the
**Administer site configuration** permission.
