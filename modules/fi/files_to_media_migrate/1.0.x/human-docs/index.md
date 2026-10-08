# Files to Media Migrate — manual setup guide

**Files to Media Migrate** (`files_to_media_migrate`) converts existing **file
fields** into **media fields** — turning plain file/image field values into core
**Media** entities and references — so a site built before core Media (or migrated
from an older Drupal) can adopt the media library. It runs from the command line
using Drush with batching, which keeps large migrations manageable.

It is a developer/migration tool, run by administrators. Like any migration it
**transforms existing content**, so take a backup first. It follows core media and
file access and adds no access model of its own.

The module gives you two Drush commands: one that creates the `_media` reference
fields for you across a content type, and one that migrates the file‑field values
into those media fields. After migrating you enable the new media fields on the
bundle's *Manage form display* and *Manage display*.

Files to Media Migrate depends on core **Media**, **Media Library**, **File**,
**Migrate**, and **Migrate Drupal**, and works on **Drupal 9, 10, and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and run the migration commands.

There is **no configuration page** for this module — it is driven entirely by the
two Drush commands described below.

## How to use it

After installing (see [Installation](installation/index.md)) and **taking a
backup**:

1. **Create the media fields.** Run:

   ```bash
   drush create-media-field <bundle> <type> <target_media_bundle> <entity_type>
   ```

   where `bundle` is the content type, `type` is `image` or `file`,
   `target_media_bundle` is the media type (for example `image`, `document`,
   `video`), and `entity_type` is the entity (for example `node`, `block_content`).
   This creates a media reference field for each file field, named after the source
   field with a `_media` suffix.

2. **Migrate the values.** Run:

   ```bash
   drush files-to-media <field_name> <type> <entity_type>
   ```

   where `field_name` is the file field to migrate, `type` is `image` or `file`,
   and `entity_type` is the entity type. For example, this moves
   `field_featured_image` values into `field_featured_image_media`.

3. **Enable the new media fields** on the bundle's **Manage form display** and
   **Manage display** so editors and visitors see them.
