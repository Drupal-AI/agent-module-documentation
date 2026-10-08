# jQuery Downgrade — agent index

Swaps Drupal 11's jQuery 4 for jQuery 3 (CDN 3.6.4) on selected nodes, Views pages, or themes.
One settings form, one config object, one OOP hook, one library. No permissions of its own
(reuses "administer site configuration"), no Drush, no plugin types.

- **The settings form, config keys, config object, and the runtime hook + library** →
  [configure/settings.md](configure/settings.md)

Key facts: config object `jquery_downgrade.settings` (keys `node_ids`, `view_routes`,
`enable_theme_downgrade`, `downgrade_themes`); configure route `jquery_downgrade.settings` at
`/admin/config/development/jquery-downgrade`; runtime via
`JQueryDowngradeHooks::alterAttachments()` (`hook_page_attachments_alter`), which unsets
`core/jquery` and attaches library `jquery_downgrade/jquery_legacy`.
