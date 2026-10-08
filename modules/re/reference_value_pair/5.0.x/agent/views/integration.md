# Views integration

`reference_value_pair.views.inc` implements `hook_field_views_data()`
(`reference_value_pair_field_views_data()`) for the `reference_value_pair` field type. It starts
from `views_field_default_views_data($field_storage)` — so the `value` and `target_id` columns get
the standard field handlers (filter/sort/argument/field) automatically — then adds two
relationships mirroring core entity reference:

- **Forward relationship** on the host field table: `<field_name>` →
  joins to the target entity type using `id: standard`, `relationship field: <field_name>_target_id`.
  Lets a view of the host entity add the referenced entity as a relationship.
- **Reverse relationship** on the target entity's base/data table:
  pseudo-field `reverse__<entity_type>__<field_name>` using `id: entity_reverse`, with
  `field table` = the field's dedicated data table and `field field: <field_name>_target_id`
  (joined with `deleted = 0`). Lets a view of the referenced entity find hosts that point to it.

Because both columns are exposed, a view can filter/sort on the scalar `value` **and** the reference
in the same row (deltas stay aligned, unlike two parallel multi-value fields). No configuration is
required beyond adding the field/relationship in the Views UI.
