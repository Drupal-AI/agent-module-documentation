<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Points — agent orientation

Defines a `point` content entity + `point_type` config entity + `point_movement` ledger; award/track numeric points.

- Version 2.0.x, core `^9||^10`, deps field + inline_entity_form. Admin at `admin/structure/points` (`administer point entities`, restricted).
- Dynamic routes per point entity-reference field render a `point_movement` View, gated `view point entities`. Movement transactions written in `Point::postSave()`.
- Permission-gated CRUD. `accessCheck(FALSE)` only in internal postSave count query. Nothing exploitable found.