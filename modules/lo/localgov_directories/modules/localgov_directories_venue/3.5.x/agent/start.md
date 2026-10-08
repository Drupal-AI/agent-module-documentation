<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Venue (localgov_directories_venue) — agent index

Config-provider submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Installs the
**`localgov_directories_venue`** node bundle — a location-aware directory entry.

Key facts:
- Depends on `localgov_directories`, **`localgov_directories_location`** (so proximity search and
  the map come with it) and `field_group`.
- Fields: the shared directory set (`localgov_directory_name`, `_phone`, `_email`, `_website`,
  `_job_title`, `_files`, `_notes`, `_title_sort`, `body`, `localgov_directory_channels`,
  `localgov_directory_facets_select`) **plus** `localgov_directory_opening_times` and
  **`localgov_location`** (LocalGov Geo).
- View displays: `default`, `teaser`, `directory_index`, `search_index`, `search_result`.
- `hook_install($is_syncing)`: registers the bundle with `simple_sitemap` when that module exists
  (`index => TRUE`, `priority => 0.5`) — the `config/optional` route does not work for this.
- `hook_localgov_roles_default()`: editor + author node permissions for the bundle.
- `localgov_directories_venue_update_8001()`: on the LocalGov Geo upgrade the default view mode was
  copied to `embed` but lost the label field; this update makes `embed` behave as `default` did.
  Run `drush updatedb` after upgrading LocalGov Geo.

Related: `localgov_directories_venue_or` turns venues into Open Referral services and backfills an
organisation for each venue — see
[../localgov_directories_venue_or/3.5.x/agent/start.md](../../../localgov_directories_venue_or/3.5.x/agent/start.md).
