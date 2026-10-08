<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Child Entity Generate adds one Migrate process plugin, `child_entity_generate`, that creates and saves a child entity (paragraph, field_collection item, referenced sub-entity) from each incoming value during a migration.

---

Install it like any module (`composer require drupal/migrate_child_entity_generate`, then enable it together with core's **Migrate** module, its only dependency); there is no configuration UI, no settings page, and no permissions — you use it entirely by referencing it in a migration definition. In a migration's `process:` section, point a destination field at `plugin: child_entity_generate` and give it `entity_type:` (required, e.g. `paragraph` or `field_collection`), an optional `bundle:`, and either a `values:` map (each `destination_field: source_key` pair pulls a sub-value from the incoming array/object or the row and sets it on the new child, with `/` letting you address field columns like `field_body/format`) or a `destination:` key to dump the whole value into one property; `default_values:` supplies literals and runs last, so it overrides `values:` on the same field. The plugin always calls `$storage->create()` then `$entity->save()` and returns the **saved entity object** (not an id), deliberately skipping any existence check — it is built for children that only live inside their parent, so re-running a migration creates duplicates unless you roll back first. It runs under Drush (`drush migrate:import`) as developer/CLI infrastructure, so it has no request-time surface; pair it with `sub_process` when the source yields a list so `transform()` runs once per child.

---

- Generate paragraph entities as part of a node migration.
- Create `field_collection` items during import.
- Build referenced child entities that only exist inside their parent.
- Map array sub-keys onto destination fields with a `values:` map.
- Address field columns like `field_body/format` using the `/` separator.
- Store a whole incoming scalar in one property via the `destination:` key.
- Supply literal defaults with `default_values:` (e.g. a text `format`).
- Override a mapped value using `default_values:` (it runs last).
- Set the child bundle with the `bundle:` key.
- Return the saved entity object to feed an entity-reference field.
- Generate FAQ items, testimonials, or slides as structured sub-entities.
- Import nested content from JSON/XML/CSV source rows.
- Combine with `sub_process` to run once per item in a list.
- Combine with `migration_lookup` to reference already-migrated entities.
- Replace Migrate Plus `entity_generate` when you must build from an array of values.
- Skip existence checks for children that never need deduplication.
- Author the whole behavior in migration YAML — no PHP required.
- Run imports with `drush migrate:import` and roll back with `drush migrate:rollback`.
- Keep it enabled only while migrations that use it are present.
- Depend on core Migrate only — no external libraries.
- Works on Drupal 8, 9, 10, and 11.
- Test the migration on a staging copy before running in production.
