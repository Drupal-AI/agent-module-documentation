<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Page (localgov_directories_page) — agent index

Config-provider submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Installs the
**`localgov_directories_page`** node bundle — the generic directory entry type. No routes, no
permissions of its own, no schema, no Drush.

Key facts:
- Depends on `localgov_directories`, core `link`, `address`, `field_group`.
- Node type `node.type.localgov_directories_page` plus field instances over the parent module's
  shared storages: `localgov_directory_name`, `localgov_directory_address`,
  `localgov_directory_phone`, `localgov_directory_email`, `localgov_directory_website`,
  `localgov_directory_job_title`, `localgov_directory_files`, `localgov_directory_title_sort`,
  `body`, and crucially `localgov_directory_channels` + `localgov_directory_facets_select`.
- Five view displays: `default`, `teaser`, `directory_index`, `search_index`, `search_result` —
  the parent's channel view and Search API index rely on these display ids existing.
- `pathauto.pattern.localgov_directories_page.yml` ships in `config/install`.
- `hook_install($is_syncing)`: when not syncing and `simple_sitemap` is enabled, calls
  `simple_sitemap.entity_manager->setBundleSettings('node', 'localgov_directories_page',
  ['index' => TRUE, 'priority' => '0.5'])`. This is a deliberate workaround — the same settings in
  `config/optional` do not apply (see drupal.org issue 3156080).
- `hook_localgov_roles_default()` grants `RolesHelper::EDITOR_ROLE` and `AUTHOR_ROLE` the standard
  create/edit/delete/revert/view-revision permissions for the bundle.

Making your own entry type: copy this bundle's shape — the only hard requirements are the
`localgov_directory_channels` field (entry → channel) and, for filtering,
`localgov_directory_facets_select`; then add the bundle to a channel's
`localgov_directory_channel_types`.
