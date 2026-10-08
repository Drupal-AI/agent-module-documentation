<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Harmonize (harmonize) — agent index
**Developer framework that preprocesses entities into a consistent `harmony` Twig variable, with Styles, processing rules, events and a Twig extension.**

- **Version:** 4.1.x (README: nearing EOL, succeeded by "Glint")
- **Core:** >=9.3 <11
- **Routes:** all under `/admin/config/harmonize/*` (settings, entity-rules add/edit/delete, cache, visualize) + `harmonize.autocomplete.entity_fields` — every one requires `_permission: 'administer site configuration'`.
- **Services:** `harmonize`, `harmonize.helpers`, `cache.harmonize` bin, Twig extension `harmonize.twig_extension`, route subscriber, access checker `_manage_preprocessing_access_check`.
- **Key classes:** `src/Service/Harmonize.php`, `src/Harmonizer/**`, `src/Entity/Style.php`, `src/Entity/EntitySettings.php`.
- **Submodules:** harmonize_refinery, harmonize_harmony_file_discovery, harmonize_sdc_display, harmonize_examples.
- **Security:** admin-only; every route is gated by `administer site configuration` (autocomplete included), plus a custom Manage-preprocessing access check. No anonymous or mutating public endpoints. No security findings.

See [api/service.md](api/service.md).