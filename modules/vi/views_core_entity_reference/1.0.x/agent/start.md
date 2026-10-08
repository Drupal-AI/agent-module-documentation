<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Core Entity Reference (views_core_entity_reference) — agent index

Zero-config glue module: opts Views into Drupal Core's built-in `entity_reference` filter plugin for
entity-reference fields, so a (regular or exposed) filter on such a field renders as a **Select or
Autocomplete of the referenced entities** instead of a raw numeric/string target-id comparison. It
defines **no filter plugin of its own** — via `hook_views_data_alter()` it simply re-points each
entity-reference field's Views `filter.id` at Core's existing `entity_reference` handler. Enable it and
the behaviour applies site-wide automatically; there is nothing to configure.

- Depends on: `drupal:views`. Core: `^10.2 || ^11` (needs a Core with the `entity_reference` Views
  filter — 10.2+/10.4.x/11.x). Package: `Views`. License GPL-2.0-or-later. Version 1.0.0-alpha3.
- No settings page / `configure` route, no permissions, no services, no config schema, no plugin
  types, no Drush, no libraries, no composer.json. Whole runtime surface is three hooks in two files.

- **The mechanism, the install migration, and how to operate it** →
  [views/entity-reference-filter.md](views/entity-reference-filter.md)

## Key facts (real machine names)

- `views_core_entity_reference_views_data_alter(&$data)` (`views_core_entity_reference.module:34`):
  loads every `field_config` entity of `field_type` `entity_reference`; for each, computes the Views
  table `<host_entity_type>__<field_name>` (`getTargetEntityTypeId()` = the entity type the field is
  attached to) and column `<field_name>_target_id`. If that column's `filter.id` is currently
  `numeric` or `string`, it is set to `entity_reference`. Columns already using another filter id are
  left untouched.
- `views_core_entity_reference_install($is_syncing)` →
  `_views_core_entity_reference_update_as_a_reference()`
  (`views_core_entity_reference.install:11` and `:18`): one-time migration for views saved against the
  old pre-Core patch, which suffixed things with `_reference`. For each `views.view.*` default-display
  filter whose `plugin_id === 'entity_reference'` and whose array key + `id` end in `_reference` /
  `_target_id_reference`, it strips `_reference` from the filter key, `id`, and `field`, and rewrites
  `expose.operator_id` / `expose.operator` from `..._target_id_reference_op` to `..._target_id_op`,
  then resaves the view. No-op on fresh sites.
- `views_core_entity_reference_help($route_name, $arg)` (`.module:13`): renders the About text on the
  Core help route `help.page.views_core_entity_reference`. The module defines no routes of its own.
- The resulting filter's UI (Select vs Autocomplete widget, `sub_handler`, `operator`) is entirely
  Drupal Core's `entity_reference` Views filter — this module only opts fields in, it does not
  implement that behaviour.

Operate: enable, run `drush cr` to rebuild Views data, then edit any View that filters on an
entity-reference field — its filter now offers a Select/Autocomplete of the referenced entities.
Prefer this module over hand-writing your own `hook_views_data_alter()` to flip individual fields
(the module's own project page documents that manual one-field alternative).
