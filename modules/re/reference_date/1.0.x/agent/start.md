<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reference Date (reference_date) — agent index
**A field type combining an entity reference with a start and optional end date.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10
- **Depends on:** core Datetime
- **Field type:** `reference_date_combo` (extends `EntityReferenceItem`); columns `value`/`end_value` (ISO-8601) + computed DateTime properties
- **Widget:** `reference_date_combo` (autocomplete)
- **Formatter:** `reference_date_combo_default` ("Label", extends entity-reference label formatter) → `reference_date` Twig template with `<time>` output
- **Storage settings:** datetime_type (date / datetime), end_date on/off

**Security:** field plugin only — no routes, permissions or global config. Date output rendered via `#theme => 'time'` with `#html => FALSE`; no user-input SQL or endpoints.

See [configure/field.md](configure/field.md)
