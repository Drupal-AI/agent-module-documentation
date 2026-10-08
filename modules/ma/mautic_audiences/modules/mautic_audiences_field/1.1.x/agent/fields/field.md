<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mautic_audience` field type & widget

## Field type `mautic_audience` (`src/Plugin/Field/FieldType/MauticAudienceItem.php`)
`MauticAudienceItem` (const `PLUGIN_ID = 'mautic_audience'`), category `general`, default widget `mautic_audience_checkboxes`, **cardinality unlimited** (one item per alias). Single `value` string column (varchar 191, indexed). A `ComplexData` constraint enforces max length and a regex rejecting spaces and slashes; it deliberately does **not** implement `OptionsProviderInterface` (so a renamed/absent alias never fails whole-entity validation — the inventory is the widget's concern).

### Storage setting `kind` (`config/schema/mautic_audiences_field.schema.yml`)
`defaultStorageSettings()` → `kind = 'segments'`. Radios in `storageSettingsForm()`: `segments` (matched against the visitor's segments) or `tags` (matched against tags). **Locked once the field holds data** (`#disabled = $has_data`) because stored values would otherwise be matched against the wrong list. Helper `getKind()` returns the `KIND_SEGMENTS`/`KIND_TAGS` constant.

### Field setting `enforce_view_access`
`defaultFieldSettings()` → `enforce_view_access = FALSE`. Checkbox in `fieldSettingsForm()`. Off = editorial hint only. On = per-field view-access gate (see [../api/access-gate.md](../api/access-gate.md)). Static helper `MauticAudienceItem::enforcesViewAccess($definition)` is the single predicate the hooks, processor, and requirements all consult.

## Widget `mautic_audience_checkboxes` (`src/Plugin/Field/FieldWidget/MauticAudienceCheckboxesWidget.php`)
`multiple_values: TRUE`, applicable only to `mautic_audience` fields. Fed from `@mautic_audiences.segment_list` (the base module's cached Mautic inventory): segment aliases→labels, or tag values.
- Renders **checkboxes** at ≤ 25 options (`SELECT_THRESHOLD`), a multiple **select** above that.
- A stored alias no longer in the inventory stays selected, labelled `(no longer in Mautic)`.
- When the inventory could not be loaded (`SegmentList::isAvailable()` false), the widget shows only stored values with an outage notice, so an outage never looks like deletions.
- A **Refresh the list from Mautic** submit button (`refreshInventory()`) calls `SegmentList::refresh()` to drop the hourly cache.
- `massageFormValues()` converts the selected options into `['value' => $alias]` items, skipping the refresh button and empties.

## Placing it
Add the field under *Manage fields* on any bundle, pick the *kind* and (optionally) enforcement on the settings screen, and grant `administer mautic audiences` to whoever must read stored values (see access-gate doc). No formatter ships — templates ask a yes/no question via `is_in_segment(node.field_audience)` (the base module's Twig extension accepts the field directly).

Config schema also defines `field.value.mautic_audience` (default value), `field.widget.settings.mautic_audience_checkboxes`, and the two Views filters used elsewhere.
