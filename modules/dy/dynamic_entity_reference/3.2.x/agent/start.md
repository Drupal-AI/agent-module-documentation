# dynamic_entity_reference — agent start

Field type `dynamic_entity_reference`: one reference field that can target **multiple** entity
types. Stores `target_id` + `target_type` per value. Extends core Entity Reference; depends on
core `field`. No config UI route — added like any field via Field UI (`/admin/structure`).

- Add & configure the field (storage/field settings, widgets, formatters) → [configure/field.md](configure/field.md)
- Set/read/query values in code → [api/programmatic.md](api/programmatic.md)
