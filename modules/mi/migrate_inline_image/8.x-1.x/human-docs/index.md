# Migrate Inline Image — manual setup guide

**Migrate Inline Image** (`migrate_inline_image`) solves a familiar headache when
you move content from another CMS into Drupal: the body copy is full of `<img>`
tags that still point at the old site. This module provides a Migrate process
plugin, **`save_inline_image`**, that reads the migrated rich‑text HTML, finds
every inline image, downloads each one into Drupal as a **managed file**, and
rewrites the markup so the image now points at the new Drupal file — adding the
`data-entity-type` and `data-entity-uuid` attributes CKEditor needs to recognise
it as a real embedded file.

Without it, you either end up with images that still load from (and depend on)
the old server, or you re‑upload them by hand. With it, a migration run pulls the
images across automatically: each run groups its saved files under a unique
`bat-<uuid>` folder beneath a destination you configure, and the rest of the body
markup is left untouched.

It depends on core **Migrate** (`migrate`) and the contributed **Migrate File**
(`migrate_file`) module, and it targets **Drupal 10 and 11**. This is
migration‑time developer tooling — the image download happens only when you run
the migration from the CLI or admin, never in response to a site‑visitor request.
There is no admin settings screen; you configure the plugin inline in your
migration YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate and Migrate File.

There is **no configuration page** for this module. It has no settings form; you
configure the `save_inline_image` plugin from migration YAML as described below.

## How to use it

You add `save_inline_image` as a process step for the rich‑text/body field whose
HTML contains inline images, usually after the steps that produce that HTML. The
plugin requires two configuration keys and will fail the migration (with a
`MigrateException`) if either is missing:

- **`image_file_source_path`** — a source‑row property that tells the plugin
  where to find each image referenced in the HTML, so it can resolve the image's
  path relative to that base.
- **`image_file_save_destination`** — the Drupal destination (a stream wrapper
  path such as a `public://…` scheme) where the managed files should be written.
  Each migration run creates its own `bat-<uuid>` subfolder there.

During the run, the plugin parses the field's HTML, iterates every `<img>`,
copies each referenced image into the destination as a managed file, and rewrites
the `src` to the new managed‑file URL while adding `data-entity-type=file` and
`data-entity-uuid`. It handles multiple images per field value and returns the
updated body HTML.

A couple of things worth knowing: the image URLs are taken from the (trusted)
source HTML you are migrating, so treat your migration source as trusted input.
Because the plugin fetches image bytes from the configured source path, run it
only against source data you control, and test on a copy of the site before
importing into production.
