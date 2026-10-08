# Migrate Files (extended) — manual setup guide

**Migrate Files (extended)** (`migrate_file`) is a developer tool for Drupal
migrations. It adds four migrate **process plugins** that let a migration create a
managed file (or image) entity from a local path or a remote URL *inline* — in the
same migration row as the node, media, or other entity that references it —
instead of requiring a separate, dedicated files migration first.

Core Migrate ships `file_copy` and `download`, but neither creates a file
*entity*, so the classic pattern is to run a standalone files migration and then
reference the already-migrated files by id. This module collapses that into one
step. It is especially handy when importing content straight from a CSV, JSON,
XML, or non-Drupal API whose fields contain file paths or URLs. The four plugins
are:

- **`file_import`** — copies, downloads, moves, or renames a file, then creates a
  file entity and returns an entity-reference value ready to drop into a file or
  image field. It gives you fine control over overwrite behaviour, attribution,
  copy-vs-move, and error resilience.
- **`image_import`** — extends `file_import` and additionally fills an image
  field's `alt`, `title`, `width`, and `height` (with a `!file` shortcut to use
  the filename as alt/title text).
- **`file_remote_url`** — creates a file entity whose URI is the remote URL
  itself, *without downloading* it.
- **`file_remote_image`** — the same "don't download" approach for images, letting
  you supply width/height so Drupal doesn't fetch the image just to measure it.

This is a plugins-only module: there is **no admin UI, no configuration, no
permissions, no services, and no Drush commands**. You consume the plugins from
migration YAML or a `migrate_plus.migration` config entity. Note that the release
documented here is **3.0.0-alpha1** (alpha stability), and the "don't download"
plugins require the **Remote Stream Wrapper** module to actually serve the remote
URIs.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including every plugin config key
and worked YAML patterns — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, note the useful
   companion modules, and enable the module.

## Where it lives in the admin menu

Nowhere — there is no settings page. The module only adds process plugins that you
reference from migration definitions.

## How to use it

In a migration's `process` section, use one of the plugins on a file or image
field. For example, importing a file referenced by a local path or URL in a source
column:

```yaml
process:
  field_attachment:
    plugin: file_import
    source: file_path
    destination: 'public://imported/'
    uid: 1
    file_exists: rename
```

For an image with alt text drawn from other source columns:

```yaml
process:
  field_image:
    plugin: image_import
    source: image_url
    alt: image_alt
    title: image_title
    destination: 'public://images/'
```

To register a remote file without downloading it, use `file_remote_url` (or
`file_remote_image`) and make sure the Remote Stream Wrapper module is installed so
the stored remote URI can be served.
