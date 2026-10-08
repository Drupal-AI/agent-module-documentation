# Migrate SourceId — manual setup guide

**Migrate SourceId** (`migrate_sourceid`) provides a block that, on the page of a
migrated entity, shows a link back to the original entity on the old site — for
example `{OLD_DRUPAL_URL}/node/{sourceid1}`. It works by reading the
`migrate_map_*` tables that core Migrate populates during an import, recovering
the old source id for whatever entity you are looking at. Think of it as a
reverse `migrate_lookup`.

The problem it solves is a common one after a migration: you want to verify or
reference where a piece of Drupal content came from, without having to add a
custom field just to store the old id. Migrate SourceId reads the map tables
directly and renders the source link for you. It currently supports the main core
entity types — node, taxonomy_term, user, media, file, and block_content.

There is no admin settings form yet. Configuration lives in a config file,
`migrate_sourceid.settings`, which ships with the module and which you edit and
re-import (or override from `settings.php`). You place the block on Block Layout
and restrict where it appears. It depends only on Drupal core's **Migrate**
module, and you'd typically enable it after your migrations are complete.

One thing to keep in mind: the block reveals source-system ids and URLs, so
restrict its visibility and roles to the editors or administrators who are
reviewing migrated content — you generally don't want it shown to the public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** in the admin UI. Configuration is done by
editing the `migrate_sourceid.settings` config, described in "How to use it"
below.

## Where it lives in the admin menu

Migrate SourceId adds no dedicated settings page. You work with it in two places:

- **Structure → Block Layout** (`/admin/structure/block`) — where you place the
  **Migrate Sourceid** block and set its visibility.
- The config file `migrate_sourceid.settings.yml` — where you tell the module the
  old site's base URL and which migrations to look up per entity type.

## How to use it

1. Finish your migrations first (core `migrate` is required), then enable this
   module.
2. Place a new **Migrate Sourceid** block on **Block Layout**
   (`/admin/structure/block`).
3. Restrict the block's visibility to entity view pages — for example `/node/*`,
   `/taxonomy/term/*` — and to appropriate roles, since it exposes source ids and
   URLs.
4. Configure the settings. Export config to get `migrate_sourceid.settings.yml`
   into your sync directory (or override it from `settings.php`), then edit it:

   ```yaml
   source_url: https://www.example.com
   migrations:
     node:
       - d7_node
       - node_article
     taxonomy_term:
       - d7_taxonomy_term
     user:
       - d6_user
     media:
       - my_media_file
     file:
       - d7_file
     block_content:
       - d7_block_content
   ```

   Here `source_url` is the base URL of the old site, and each entry under
   `migrations` lists, per entity type, the migration ids whose map tables should
   be searched.
5. Import the updated config and clear caches (`drush cim`, `drush cr`).

Now, when you view a migrated entity, the block shows a link to the original
source entity on the old site.
