# Radioactivity — agent index

Popularity/"hotness" tracking via **energy** fields that emit on view and **decay** over time
(linear / half-life / count). Depends on core `field`. No admin config page (`configure` null),
no permissions of its own (emit route uses `access content`). Provides a config schema, Drush,
Views integration, and a Rules event. All setup is per-field on *Manage fields / form display /
display*, plus one storage config object.

- **Field settings (profile, granularity, halflife, cutoff), the two field types, storage backends
  (`radioactivity.storage`), and decay/cron behavior** → [configure/storage.md](configure/storage.md)
- **The plugins: field types, widgets, formatters, the `radioactivity` entity, queue workers, Rules/event** →
  [plugins/fields.md](plugins/fields.md)
- **How energy is emitted & recorded: incidents, the signed hash, `/radioactivity/emit`, the REST
  file endpoint, client `triggers.js`, and calling the processor** → [api/emit.md](api/emit.md)
- **Drush `radioactivity:fix-references`** → [drush/commands.md](drush/commands.md)

Key facts:
- Field types: `radioactivity_reference` (recommended; entity-ref to a `radioactivity` entity holding
  energy/timestamp) and `radioactivity` (deprecated; inline energy/timestamp).
- Storage `radioactivity.storage` `type`: `default` (DB table + route `/radioactivity/emit`),
  `rest_local` / `rest_remote` (standalone `endpoints/file/rest.php`).
- Incidents are HMAC-style hash-signed with the site hash salt (`Settings::getHashSalt()`); the
  processor drops any incident whose hash doesn't verify — energy values cannot be forged without the salt.
- Cron: `RadioactivityProcessor` applies pending incidents (queue `radioactivity_incidents`) and runs
  decay (queue `radioactivity_decay`).
