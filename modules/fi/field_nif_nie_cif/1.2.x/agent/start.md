<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Spain NIF, NIE and CIF Field — agent index

Validates **Spanish NIF / NIE / CIF** identification numbers (format + control digit) — provides a
`nif_nie_cif` field type, `nif_nie_cif_default` widget/formatter, a `NifNieCif` validation constraint,
and a `nif_nie_cif` Webform element (submodule `field_nif_nie_cif_webform`). Depends on core `field`
(Webform for the submodule). Version **1.2.0**. Core `^9.4 || ^10 || ^11`, PHP `>=8.1`.

Fields/validation (no access role). **Personal/tax data — handle/store with privacy care.**

- Widget settings (restrict allowed types, auto-detect) and config schema → [configure/widget-settings.md](configure/widget-settings.md)
- Field type/widget/formatter/constraint IDs, `IdentificationHelper` API, Webform element → [plugins/field-plugins.md](plugins/field-plugins.md)
