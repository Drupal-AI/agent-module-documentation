# Imagecache External — manual setup guide

**Imagecache External** (`imagecache_external`) lets you apply Drupal **image styles** to
images that live on **remote** servers. Core image styles only work on files stored locally,
so a photo hosted on a partner site, a CDN, or an external API normally can't be resized,
cropped, or served as a responsive image. This module bridges that gap: given an external
image URL, it downloads the file into a local cache directory once, then serves image‑style
derivatives of that cached copy just like any local image.

When it fetches an image it validates the file's MIME type against an allowlist, optionally
sanitises SVGs (stripping scripts and unsafe tags), and stores the file under a configurable
directory — either as a plain unmanaged file or as a managed `File` entity. You then consume
it three ways: two **field formatters** (**Imagecache External** and **Imagecache External
Responsive**) render a link/text field that holds a URL as a styled `<img>`; two theme hooks
do the same in templates; and a Twig filter,
`{{ url|imagecache_external('thumbnail') }}`, returns the styled derivative URL directly.

A settings form controls the cache directory, subdirectory nesting, allowed MIME types, an
optional **host whitelist** (so images can only be fetched from hosts you approve), a
**fallback image** for when a fetch fails, SVG sanitiser rules, and cron‑based cache
flushing. A manual flush form and a queue worker purge the cache in batches. Three Drush
commands let you warm the cache, set the fallback image, and test the host whitelist, and
three alter hooks give developers fine control over refreshing, the storage destination, and
the flush file list. It depends on core's Image module and the `enshrined/svg-sanitize`
library.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the SVG‑sanitize library
   with Composer, and enable it.
2. [Configuration](configuration/index.md) — the settings form field by field, the host
   whitelist, the field formatters, the Twig filter, and cache flushing.

## Where it lives in the admin menu

- **Settings** — **Configuration → Media → Imagecache External**
  (`/admin/config/media/imagecache_external`), gated by the *Administer imagecache external*
  permission.
- **Flush form** — the same section, at `/admin/config/media/imagecache_external/flush`.
- **Field formatters** — set per field on each content type's **Manage display** page.
