<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multi Value Field (multivaluefield) — agent index

**A Field API field type (plus widget, formatter, and Feeds target) that stores several related sub-values together in one field.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Depends:** none (core Field API; optional Feeds)
- **Submodule:** `multivaluefield_example` (demo entity + config).

**Surface:** FieldType `multivaluefield`, matching FieldWidget and FieldFormatter, `MultiValueFieldHelper`, and a Feeds `Target` plugin. No routes, permissions, or services.

**Security:** no web endpoints or custom access; governed entirely by the host entity's standard field/form/display access — same posture as any core field. Content-modelling building block only.
