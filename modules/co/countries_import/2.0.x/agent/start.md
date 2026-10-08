<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Countries (countries_import) — agent index

**Admin import tool that turns bundled country + region data (ISO-2, ISO-3, flag SVG) into taxonomy terms.**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11
- **Dependencies:** file, migrate, svg_image, content_translation, token
- **Configure route:** `countries_import.settings` → `/admin/config/content/countries-import` (perm `administer site configuration`); second tab `geographic_regions.settings` → `.../geographic-regions`.
- **Services:** `countries_import.helper` (`CountriesService::import()`), `regions_import.helper` (`RegionsService::import()`), `countries_import.files_utils` (`FileUtils`, flag files), `base.helper` (`BaseService`).

**Security:** Both routes gated by `administer site configuration`; forms only, no anonymous or mutating public endpoints. No security findings.

See [configure/import.md](configure/import.md).