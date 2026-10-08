<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field NIF (field_nif) — agent index

**A `nif` field type validating Spanish NIF/CIF/NIE numbers and storing them split into first-letter / number / last-letter / type columns.**

- **Version:** 2.0.x
- **Core:** ^11
- **Dependency:** `field`
- **Plugins:** FieldType `nif` (`NifItem`), FieldWidget `NifWidget`, FieldFormatter `nif_default` (`NifFormatter`, HTML-escapes output), FAPI Element `nif`, Webform element, Validation constraint `NifConstraint`/`NifValueValidator`, helper `NifUtils`.

**Security:** pure field-type/validation module; formatter escapes output via `Html::escape()`; no routes, no permissions, no raw SQL — no findings.

See [api/field_nif.md](api/field_nif.md).