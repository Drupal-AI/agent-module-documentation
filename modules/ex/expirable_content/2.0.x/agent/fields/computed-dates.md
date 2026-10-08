<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Computed fields — expiration_date & warning_date

Two read-only computed base fields are attached to every entity of an expirable bundle. Definitions come from
`EntityTypeInfo::entityBaseFieldInfo()` (called by `hook_entity_base_field_info()`); values are computed by
`Plugin/Field/ExpirableContentFieldItemList`.

## Field definitions (`EntityTypeInfo`)

- `expiration_date` — `timestamp`, computed, class `ExpirableContentFieldItemList`, not read-only (settable).
- `warning_date` — `timestamp`, computed, same class.

They are added only when `ExpirableContentInformation::isExpirableEntityType()` returns TRUE (i.e. an enabled
`expirable_content_type` targets that entity type). Both are single-value: `ExpirableContentFieldItemList::get()`
throws `\InvalidArgumentException` for any index other than 0.

## Value computation (`ExpirableContentFieldItemList::computeValue()`)

For a given entity, the field name selects the calculation:

**Expiration** (`getExpirationForEntity()`):
1. Look up the enabled `ExpirableContentType` for the entity's type+bundle
   (`getExpirableContentTypeForEntity()`, `loadByProperties(status/entity_type/entity_bundle)`).
2. If the entity has the configured base `field()` and it is non-empty, take its `value` timestamp.
3. Build a `DrupalDateTime` from that timestamp in the site timezone (`system.date` `timezone.default`, fallback
   `America/New_York`), zero the time to 00:00:00, then `add(new \DateInterval('P{days}D'))`.
4. Return the resulting timestamp; `0` if no type/field/value.

**Warning** (`getWarningForEntity()`):
1. Compute the expiration timestamp (as above).
2. `sub(new \DateInterval('P{warn}D'))` from it — i.e. warning = expiration − `warn` days.
3. Return the timestamp; `0` if expiration is `0`.

Exceptions during either calculation are caught and logged to the `expirable_content` logger channel (with the
entity id and message via placeholders); the field then resolves to `0`.

## Notes for agents

- These are **derived** values: they always reflect the current base-field value + config, not a stored user edit.
- Interval math uses whole days only (`P{n}D`); the base date's time-of-day is discarded (set to midnight).
- Nothing here publishes, unpublishes, deletes, or schedules anything — the fields are purely informational. To
  act on them, read the field or use the Views handlers (see `../views/integration.md`).
