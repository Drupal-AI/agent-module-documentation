# Flush Single Image Styles — manual setup guide

**Flush Single Image Styles** (`flush_single_image`) fixes a real gap in Drupal's image
handling: core lets you flush an *entire* image style or nothing at all, but gives you
no way to refresh the derivatives of **one** image. This module targets the file — you
give it a source image path and it clears (and can regenerate) just the styled versions
of that image.

The problem it solves is familiar on content‑heavy sites. Drupal generates a derivative
per image style the first time an image is requested and keeps it until the style is
flushed. When a single image is replaced in place — a daily import overwrites a file but
keeps the same filename, a crop is corrected, or one derivative was generated wrongly —
that image is stale, and core's only remedy is "flush this whole image style", which
throws away every derivative for every image using the style and forces the whole site
to regenerate them. That is an expensive way to fix one photo. This module refreshes the
one file instead.

It offers several ways in: a **form** where you paste a source image path (for example
`public://assets/foo/bar/image.jpg`), a **media bulk action** so editors can flush an
image they have just replaced, a **Drush command** for scripting and deployments, a
**service class** for custom code, and a **Migrate process plugin** for import
pipelines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its core `image` and `action` dependencies.
2. [Configuration](configuration/index.md) — the flush form, the settings page, and the
   permissions that control who can do what.

## Where it lives in the admin menu

- The **flush form** — paste an image path and flush it — is at
  **`/admin/config/media/image-styles/flush-single`**.
- The **settings form** (route `flush_single_image.settings.form`) is at
  **`/admin/config/flush-single-image/settings`**.

See [Configuration](configuration/index.md) for both, plus the Drush command and the
media bulk action.

## How to use it

The quickest path is the flush form: go to
`/admin/config/media/image-styles/flush-single`, enter a source path like
`public://assets/foo/bar/image.jpg`, and submit — the module clears the styled versions
of that file so they regenerate fresh. For scripted or deploy‑time use, the Drush
command does the same:

```bash
drush flush_single_image public://assets/foo/bar/image.jpg --check-styles
```

Editors can also flush an image they have just replaced via a **bulk operation on the
media listing**, without needing configuration rights (see the permissions in
[Configuration](configuration/index.md)).
