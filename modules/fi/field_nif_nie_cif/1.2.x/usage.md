<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Spain NIF, NIE and CIF Field provides a field type (and a `field_nif_nie_cif_webform` element) that validates Spanish NIF, NIE and CIF identification numbers, with optional automatic type detection and input normalization.

---

Spain NIF, NIE and CIF Field validates Spanish identification numbers — NIF (individual tax ID), NIE
(foreigner ID) and CIF (company ID) — by checking format and control digit. It ships a `nif_nie_cif`
field type storing a `type` (NIF/NIE/CIF) plus `number`, a `nif_nie_cif_default` widget, a
`nif_nie_cif_default` formatter, and a `NifNieCif` validation constraint that runs through Drupal's
validation API (so forms, JSON:API and other entity validation get the same errors). The widget offers
two settings: `allowed_types` (restrict which of NIF/NIE/CIF editors may enter, at least one required)
and `auto_detect` (a single smart input that infers the type instead of a select). Input is normalized —
uppercased, with spaces, dots and hyphens stripped — so `12.345.678-Z` or `B 99286320` are accepted and
stored canonically. The optional `field_nif_nie_cif_webform` submodule adds a `nif_nie_cif` Webform
element that always auto-detects and normalizes. It depends only on core Field (Webform for the
submodule).

Use it on Spanish sites collecting NIF/NIE/CIF on profiles, registrations, orders or webforms, to
ensure valid identifiers are entered. It is a fields/validation feature; validation applies to the
identifier, and it has no access-control role. Note these identifiers are personal/tax data — handle and
store them with appropriate privacy care. Configure the widget where the identifier is collected.

---

- Validate Spanish NIF (individual tax ID) numbers.
- Validate NIE (foreigner ID) numbers.
- Validate CIF (company) numbers.
- Check format and control digit / checksum.
- Provide a `nif_nie_cif` field type storing type + number.
- Provide a `nif_nie_cif_default` widget and formatter.
- Auto-detect the identification type from a single smart input.
- Restrict a field to selected identification types (NIF/NIE/CIF).
- Normalize input (uppercase, strip spaces, dots, hyphens).
- Accept common formats like `12.345.678-Z` or `X-1234567-L`.
- Validate through Drupal's validation API (`NifNieCif` constraint).
- Provide a `nif_nie_cif` Webform element via the submodule.
- Force editors to replace legacy values of a now-disallowed type.
- Use on registrations, orders and profiles.
- Collect valid Spanish IDs on webforms.
- Treat identifiers as personal/tax data.
- Store IDs with privacy care.
- Validate identifiers via JSON:API entity validation.
- Add live accessible detection feedback in the browser.
- Serve Spanish sites needing tax-ID validation.
- Have no access-control role.
