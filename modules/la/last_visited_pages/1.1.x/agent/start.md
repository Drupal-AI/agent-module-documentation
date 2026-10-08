<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Last Visited Pages (last_visited_pages) — agent index

Records a per-user "recently visited pages" history and renders it in a **block**. A kernel
`REQUEST` event subscriber (`LastVisitedPagesSubscriber::checkForPlaces`) fires on every page load,
resolves the current route's title via the title resolver, and — whenever the route has a title —
`INSERT`s a row (`title`, `path`, `uid`, `timestamp`) into a dedicated `last_visited_pages` table,
then prunes that user's rows back to the most recent 20. The block plugin `last_visited_pages_block`
(`LastVisitedPagesBlock::build`) reads back the rows for `currentUser()->id()`, ordered newest-first,
and outputs an `<ul>` of `title | formatted-time` links. The block's cache max-age is 0 so it always
reflects the latest visits.

Configuration is in two places: a site settings form (`last_visited_pages.settings`, one key
`max_places`, the ceiling offered to blocks) and the block's own placement/config form (how many
links to show, which date format). Storage is a custom DB table created by `hook_schema()`; nothing
is stored as config entities. Everything is self-contained — one subscriber, one block, one settings
form, one table.

- Depends on: core `block` (`drupal:block`). Core: `^8 || ^9 || ^10 || ^11`. Package: `Last Visited Pages`.
- Settings page: yes — `last_visited_pages.settings` at `/admin/config/last-visited-pages-settings`
  (`_permission: administer site configuration`).
- Permissions: none defined (uses core `administer site configuration` for the settings route).
  Drush: none. Config schema: none shipped. Plugin types defined: none (provides a core Block plugin).
- Data model: one custom table `last_visited_pages` (`id`, `title`, `path`, `uid`, `timestamp`),
  dropped on uninstall.

## What you'd do → where

- **Set the max links a block may show / reach the settings form / understand the block's own config
  (count, date format, label)** → [configure/block-and-settings.md](configure/block-and-settings.md)
- **Understand what gets recorded and when, the event subscriber, the storage table, and how the
  block queries it (to theme it, query it, or change behavior)** →
  [api/subscriber-and-storage.md](api/subscriber-and-storage.md)

## Key facts (real machine names)

- Route: `last_visited_pages.settings` (`/admin/config/last-visited-pages-settings`, form
  `Drupal\last_visited_pages\Form\LastVisitedPagesSettingsForm`, form id `last_visited_pages_settings`).
- Menu links: `last_visited_pages.settings` (parent `system.admin_config`),
  `last_visited_pages.settings_block` (parent `system.admin_config_ui`).
- Service: `last_visited_pages.recentplacessubscriber`
  (`Drupal\last_visited_pages\LastVisitedPagesSubscriber`, tagged `event_subscriber`,
  subscribes to `KernelEvents::REQUEST` → `checkForPlaces`).
- Block plugin: `last_visited_pages_block` (`Plugin\Block\LastVisitedPagesBlock`,
  admin_label "Last Visited Pages", `getCacheMaxAge()` → 0).
- Block config keys: `num_places` (default 5), `date_format` (default `medium`, or `custom`),
  `custom_date_format` (PHP date pattern when `date_format` == `custom`), `label_display`.
- Settings config object: `last_visited_pages.settings`, key `max_places` (default 10).
- DB table: `last_visited_pages` (fields `id` serial PK, `title` varchar(255), `path` varchar(255),
  `uid` int unsigned, `timestamp` int unsigned). Retention: latest 20 rows per `uid`.
- Hooks: `hook_help` (module + settings route), `hook_schema`, `hook_uninstall` (drops the table).
