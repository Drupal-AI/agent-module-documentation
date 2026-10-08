Migrate Domain Access provides Drupal 7 migrate source plugins that read a D7 site's Domain Access node and user assignments so they can be upgraded into the Drupal 10/11 core Domain suite.

---

The module ships two `@MigrateSource` plugins under `src/Plugin/migrate/source/d7/` that extend core's D7 node and user sources so migrations carry Domain Access data along with the entities. `NodeDomainAccess` (id `d7_node_domain_access`, extends `Drupal\node\Plugin\migrate\source\d7\Node`) adds a `domain_access_node` source property: in `prepareRow()` it queries the D7 `domain_access` table for rows with `realm = domain_id` for the node, maps each `gid` to a `machine_name` via the D7 `domain` table, and returns `[['target_id' => machine_name], ...]`; it also sets `domain_all_affiliates = 1` when a `realm = domain_site` row exists, and reads the D7 `domain_source` table to set a single `domain_source` machine name. `UserDomainAccess` (id `d7_user_domain_access`, extends `Drupal\user\Plugin\migrate\source\d7\User`) adds a `domain_access_user` property built from the D7 `domain_editor` table (`domain_id` per `uid`), again resolved to domain machine names as `target_id` arrays. Both plugins leave the parent `query()` untouched and only extend `fields()`/`prepareRow()`, so the extra properties are available to migration process/destination mappings for the core Domain Access fields. The module only depends on core `migrate`; it defines no routes, services, permissions, config, or hooks — it is purely source plugins consumed by migration definitions you write or generate.

---

- Read Drupal 7 Domain Access node assignments during a migration.
- Expose per-node domain memberships as a `domain_access_node` source property.
- Map D7 numeric domain `gid`s to Drupal 10/11 domain `machine_name` target ids.
- Flag nodes granted to all affiliates by setting `domain_all_affiliates` from `realm = domain_site` rows.
- Carry a node's canonical source domain across via the `domain_source` property (from the D7 `domain_source` table).
- Migrate Domain Editor (per-user domain) assignments with `domain_access_user`.
- Extend core's `d7_node` source without altering its base query, so it composes with standard node migrations.
- Extend core's `d7_user` source the same way for user migrations.
- Use `d7_node_domain_access` as the `source:` plugin in a node migration YAML.
- Use `d7_user_domain_access` as the `source:` plugin in a user migration YAML.
- Feed the emitted `target_id` arrays straight into entity-reference domain fields on the destination.
- Upgrade a D7 Domain Access site's content and users into the Drupal 10/11 Domain suite.
- Rely on the core Migrate framework's database source connection (no extra services required).
- Combine with the base Domain and Domain Access modules on the destination site.
