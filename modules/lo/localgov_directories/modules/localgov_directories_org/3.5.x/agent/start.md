<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories Organisation (localgov_directories_org) — agent index

Config-provider submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Installs the
**`localgov_directories_org`** node bundle plus the shared
`field.storage.node.localgov_directory_organisation` used to reference an organisation from other
bundles.

Key facts:
- Depends on `localgov_directories`, `localgov_directories_location`, `field_group`.
- Bundle fields include `localgov_directory_email`, `_website`, `_files`, `_notes`,
  `localgov_directory_facets_select` and the channel reference; displays shipped for `default`,
  `teaser` and `search_result` among others.
- Provides `field.storage.node.localgov_directory_organisation` — the storage other bundles attach
  to point at an organisation node (used by `localgov_directories_venue_or`).
- Because it depends on `localgov_directories_location`, organisation entries can carry
  `localgov_location` and take part in maps/proximity search.
- Purpose beyond directories: Open Referral models a *service* as belonging to an *organisation*;
  this bundle is where that organisation record lives on a LocalGov site. See
  [../localgov_directories_or/3.5.x/agent/start.md](../../../localgov_directories_or/3.5.x/agent/start.md).
