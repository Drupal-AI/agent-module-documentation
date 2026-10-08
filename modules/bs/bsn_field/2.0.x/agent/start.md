<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BSN (bsn_field) — agent index

**A validated Dutch-BSN field type and Webform element using a modified elfproef (eleven-test) checksum.**

- **Version:** 2.0.x · **Core:** ^9 || ^10 || ^11 · **Depends:** core `field`
- **Provides:** field type `bsn` (`Plugin/Field/FieldType/BSNItem` + constraint via `getConstraints()`), widget `BSNDefaultWidget`, render element `Element/BSNElement` (validated textfield), Webform element `Plugin/WebformElement/BSNField`. Uses core `string` formatter (`hook_field_formatter_info_alter`).
- **Validation:** `_bsn_field_elfproef()` in `.module` — reversed-digit weighting, last digit × -1, sum divisible by 11, magnitude in BSN range.
- **Routes/permissions:** none.
- **Security:** no routes, no endpoints; validation-only. Stored BSNs are personal data — apply field-level access / encryption per site privacy needs (module does not encrypt).

See [extend/field.md](extend/field.md)
