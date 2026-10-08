<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Points

Provides a `point` content entity plus a `point_type` config entity and a `point_movement` ledger entity. Points can be referenced from other entities via an entity-reference field to `point`; changes to a point's value are recorded as movement transactions, and a per-entity movements page shows the history via a bundled View.

---

# Installing & configuring

- Enable Points (pulls in Field and Inline Entity Form).
- Administer point entities at `admin/structure/points` (permission `administer point entities`, marked restrict access).
- Create point types, then create Point entities or reference them from other entity types.
- Granular permissions: create/view/edit/delete point entities.

---

- `point` is a full content entity with its own access control handler.
- `point_type` config entities define bundles of points.
- `point_movement` records each delta as a ledger transaction.
- Default install config adds a `default` point type and a `points` field.
- A dynamic route `\/{entity_type}/{entity}/{field}` shows an entity's point-movement View, gated by `view point entities`.
- Routes are generated for every entity-reference field that targets `point`.
- `Point::postSave()` writes a movement transaction when the value changes (`point_delta`).
- A validation constraint (`PointStateConstraint`) guards point state transitions.
- Inline Entity Form provides an embedded widget for editing points in host forms.
- Permissions: administer / create / view / edit / delete point entities.
- `administer point entities` is flagged `restrict access: true`.
- The movements controller loads the host entity from the path and embeds the `point_movement` View.
- A bundled View (`point_movement`) renders the ledger, filtered by target id.
- List builders exist for both points and point types.
- Internal count queries use `accessCheck(FALSE)` inside `postSave` (system context, not a route).
- Useful for loyalty/credit/gamification systems attaching numeric balances to users or content.
