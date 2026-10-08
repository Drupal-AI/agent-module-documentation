<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Views Field — agent index

Registers one Views field, **`entity_usage_views_field`** ("Entity usage count"), on the base
Views table of every trackable entity type. It counts, per row, how many other entities'
**default revisions** reference this entity (data from the `entity_usage` table). No config UI
(`configure: null`), no permissions, no Drush, no plugin types of its own.

- **Add the field to a view / where it appears / restrict to target types** →
  [configure/views-field.md](configure/views-field.md)
- **How the count is computed, revision-awareness, sortability, modal rendering** →
  [api/mechanism.md](api/mechanism.md)

Key facts: the field is added by `hook_views_data_alter()` for every entity type that has a
`views_data` handler (or, if `entity_usage.settings:track_enabled_target_entity_types` is set,
only those types). It is a `NumericField` handler computed in PHP, so it is **not sortable and
not filterable**. Rewriting it as a custom link with the `use-ajax` class turns the count into a
modal to the entity's Entity Usage report.
