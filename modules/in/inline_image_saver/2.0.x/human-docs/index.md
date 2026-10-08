# Inline Image Saver — manual setup guide

**Inline Image Saver** (`inline_image_saver`) stops inline images in your
rich‑text fields from breaking. Editors constantly paste content into a WYSIWYG
editor with `<img>` tags pointing at external sites, temporary editor URLs, or
even base64 `data:` URIs — and those links go stale, get blocked, or simply
disappear, leaving broken images all over your content. This module watches every
entity save, checks the inline images in configured text formats, and can pull
external images down into local **file entities** so they are safely stored on
your own site and referenced properly.

It does its work in three layers, each of which you can turn on or off. First,
**validation** enforces rules on inline images — that they reference a real file
entity (via `data-entity-*` attributes), that the file exists on disk, that its
MIME type is valid, and that the image URL matches the file entity's URL. Second,
**downloading** fetches images that fail validation and saves them locally, and
can reuse an existing file when the content is identical (with optional
[File Hash](https://www.drupal.org/project/filehash) support for better duplicate
matching). Third, **replacement** swaps any still‑broken image for configurable
fallback markup, with token placeholders such as `@src`, `@alt`, and `@title`.

Along the way it can create a new revision when it changes images (with a custom
log message), restrict processing to specific text formats, and skip processing
during content/config synchronization so imports aren't disturbed. Typical uses
include localizing hotlinked images, fixing image links migrated from another
site, and enforcing strict image rules in editorial workflows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, section by
   section: which formats to process, and how validation, downloading, and
   replacement behave.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
Inline Image Saver** (`/admin/config/content/inline-image-saver/settings`). All of
the module's behavior is controlled from that one page.

> **Good to know.** When downloading is enabled, saving an entity makes your
> server perform an HTTP request to the URL in each external `<img src>` so it can
> fetch and store the image.
