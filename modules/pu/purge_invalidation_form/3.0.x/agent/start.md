# Purge Invalidation Form — agent index

Admin form to invalidate cache items directly through Purge's purgers, bypassing the Purge queue.
Depends on `purge:purge`; requires PHP 8.3. No config schema, no Drush, no custom plugin types (it ships
one Purge **processor** plugin instance). Single restricted permission.

- **The form, available types, the `InvalidationManager` service, and the processor plugin** →
  [configure/usage.md](configure/usage.md)

Key facts:
- Form route `purge_invalidation_form.invalidation_form` at
  `/admin/config/development/performance/purge-invalidation-form` (`InvalidationForm`), `_admin_route`.
- Permission `purge_invalidation_form purge invalidation` (restrict access: true) gates the form.
- `info.yml` has no `configure` key (`configure: null`); the form is reached via the Performance local task.
- Type options are filtered to types supported by **enabled** purgers; `everything` needs no items,
  other types take one expression per line.
- Ships processor plugin `invalidation_form` (`enable_by_default = true`); the `InvalidationManager`
  requires it and calls `purge.purgers->invalidate()` synchronously (no queue).
