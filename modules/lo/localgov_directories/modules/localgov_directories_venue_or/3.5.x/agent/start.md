<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Directories: Venue - Open Referral (localgov_directories_venue_or) — agent index

**EXPERIMENTAL** submodule of [localgov_directories](../../../../3.5.x/agent/start.md). Makes venue
entries Open Referral *services* and gives each venue an organisation.

> **Enabling this creates content.** `localgov_directories_venue_or_prepopulate_org()` queries all
> `localgov_directories_venue` nodes with `accessCheck(FALSE)` and, for every venue whose
> `localgov_directory_organisation` field is empty, **creates a new `localgov_directories_org`
> node** (copying the venue's title, published status and owner) and links it. On a site with
> hundreds of venues that is hundreds of new nodes, unattended. Take a database backup and check
> the venue count before installing:
> `drush sqlq "SELECT COUNT(*) FROM node WHERE type='localgov_directories_venue'"`.

Key facts:
- Depends on `localgov_directories_venue`, `localgov_directories_org`, `localgov_directories_or`
  and `localgov_openreferral`.
- Config installed: `localgov_openreferral.property_mapping.node.localgov_directories_venue` (the
  venue → Open Referral service mapping) and
  `field.field.node.localgov_directories_venue.localgov_directory_organisation` (the reference to
  the organisation node).
- The organisation storage itself comes from `localgov_directories_org`.
- No UI, permissions, schema or Drush commands; the only logic is the install-time backfill.
- To undo: the created organisation nodes are ordinary content — delete them with an entity query
  on `localgov_directories_org` if you need to roll back, and clear the venue references first.
