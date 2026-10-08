<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tax Number (tax_number) — agent index

**Field type + webform element for tax/VAT numbers with pluggable per-country validation.**

- **Version:** 1.0.x
- **Core:** `^8 || ^9 || ^10 || ^11`
- **Depends:** none (Webform optional for the element)
- **Field:** `tax_number` field type (`TaxNumberItem`) + widget + default formatter.
- **Webform:** `WebformTaxNumber` element (`WebformTaxNumberElement`).
- **Plugin type:** `TaxNumberWidget` (Annotation), base `TaxNumberWidgetBase::validateTaxNumber()`, manager `TaxNumberWidgetManager`. Ships `default_widget`, `es_widget` (Spanish NIF/CIF), `pt_widget` (Portuguese NIF).
- **Config:** none of its own; configured via Field UI form-display and Webform element settings.

**Security:** no routes, permissions, or admin config; validation is pure local PHP (regex/checksum) with no network I/O; no anonymous or mutating endpoint. See [plugins/validator.md](plugins/validator.md). No security findings.
