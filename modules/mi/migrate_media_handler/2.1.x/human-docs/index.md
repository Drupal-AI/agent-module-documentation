# Migrate Media Handler — manual setup guide

**Migrate Media Handler** (`migrate_media_handler`) helps you move a Drupal 7
site that never used the D7 Media module onto Drupal's modern media system. On
its own, that conversion is tedious: every file field and every inline image or
document link in your rich‑text has to become a file entity, then a media entity,
then a reference. This module centralises that work behind a `MediaMaker` service
and exposes it as a set of reusable **Migrate process plugins** you drop into your
migration definitions.

The plugins cover the common cases: `update_file_to_image`,
`update_file_to_document`, and `update_file_to_audio` convert D7 file fields into
media reference fields (chained after core's `migration_lookup`);
`update_link_to_video` turns a D7 YouTube URL into a `remote_video` media entity;
and two DOM plugins, `dom_inline_image_handler` and `dom_inline_doc_handler`,
rewrite inline `<img>` tags and PDF `<a href>` links inside body text into
`<drupal-media>` embeds. A `record_media_ref` plugin stores a SHA1 hash of each
file so later lookups can find media that has already been migrated and avoid
creating duplicates.

It depends on core **Migrate** (`migrate`), core **Media** (`media`), and the
contributed **Migrate Plus** (`migrate_plus`) module, and supports **Drupal 9,
10, and 11**. This is migration‑time developer tooling driven from the CLI/Drush —
there are no runtime routes, no permissions, and nothing your site visitors ever
touch. On install it adds a helper field (`field_original_ref`) to each media
bundle to hold the file hash; that field is removed again when you uninstall the
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate, Media, and Migrate Plus.

There is **no configuration form** in the admin UI. The module does have settings,
but you set them from the command line with `drush config-set`, as described
below — so there is no configuration page to walk through.

## How to use it

You reference the process plugins from your migration YAML — for example chaining
`update_file_to_image` after `migration_lookup` on an image field, or wrapping
`dom_inline_image_handler` and `dom_inline_doc_handler` between Migrate Plus's
`dom` import/export steps to convert inline references in body copy. See the
sibling [`agent/plugins/process-plugins.md`](../agent/plugins/process-plugins.md)
for concrete YAML snippets for each plugin.

### Settings (edit via Drush, not a form)

The `MediaMaker` service reads its behaviour from the
`migrate_media_handler.settings` configuration object. The module's README is
explicit that you should override these values with `drush config-set` rather than
editing the shipped `config/install` file directly. The keys include:

- **`site_uri`** — a regex matching your production domain, used to resolve
  full‑path links found in the source content.
- **`file_source`** / **`file_dest`** — the source and destination file paths for
  copying files during the migration.
- **`file_owner`** — the user who should own the migrated files.
- Per‑bundle field names such as `image_field_name`, `document_field_name`,
  `audio_field_name`, and `video_field_name`.
- **`img_replace`** / **`doc_replace`** — attribute maps that add
  project‑specific attributes to the generated `<drupal-media>` output.

For example:

```bash
drush config-set migrate_media_handler.settings file_source /path/to/d7/files -y
```

After setting the values you need, run your migrations with Drush. Because the
plugins copy real file contents from the source path you configure, run them only
against source data you control, and test on a copy of the site before importing
into production.
