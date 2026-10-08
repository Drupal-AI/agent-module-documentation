<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Geo Update is a hidden bridging module that carries older LocalGov Geo installs across to the Geo Entity module, where the location entity now lives. It exists for the upgrade path, not for new sites.

---

Before version 2, LocalGov Geo defined its own location entity. That entity moved to the contrib **Geo Entity** module, and this submodule is the bridge: it is marked `hidden: true` in its info file so it never appears in the module list, and its job is to let a site that stored data under the old implementation move to the new one. New sites never need it — installing `localgov_geo` with `geo_entity` gives the current structure directly. Sites upgrading from 1.x enable it as part of the upgrade, run database updates, and can disable it afterwards. The parent module marks the boundary explicitly: `localgov_geo_update_last_removed()` returns `8810`, meaning all pre-Drupal-10 update hooks were removed because their work now belongs to geo_entity.

---

- Upgrade a LocalGov Geo 1.x site to the Geo Entity based 2.x.
- Migrate stored location data to the new entity implementation.
- Keep an upgrade path available without cluttering the module list.
- Run database updates that move geo data between implementations.
- Avoid data loss when adopting Geo Entity.
- Bridge configuration from the old entity to the new one.
- Support staged upgrades across environments.
- Remove the bridge once the upgrade is complete.
- Document the version boundary for site maintainers.
- Keep new installs free of legacy upgrade code.
- Check whether an old site's schema version is above the 8810 cut-off before upgrading.
- Step an unsupported old install through an intermediate release first.
- Verify geo data after `drush updatedb` before disabling the bridge.
- Keep the module out of the module list so editors never enable it by accident.
- Coordinate a geo upgrade with the Directories and Events modules that reference locations.
- Preserve references from content to location records through the move.
- Roll the upgrade out environment by environment.
- Uninstall the bridge once every environment is migrated.
