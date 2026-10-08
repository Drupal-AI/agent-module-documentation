Migrate Domain provides the Drupal 7 → Drupal 10/11 migration source plugin that reads legacy Domain Access records and imports them as `domain` config entities.

---

Migrate Domain ships one migrate source plugin, `d7_domain` (`Drupal\domain_migrate\Plugin\migrate\source\d7\DomainRecord`, extending core's `SqlBase`), and one bundled migration definition, `d7_domain` (`migrations/d7_domain.yml`). The source plugin queries the Drupal 7 `domain` table for the fields `domain_id`, `subdomain`, `sitename`, `scheme`, `valid`, `weight`, `is_default`, and `machine_name`, keyed on `domain_id`. The migration maps these to a `domain` config entity via the `entity:domain` destination: `machine_name`→`id`, `sitename`→`name`, `subdomain`→`hostname` and `path`, `weight`→`weight`, `is_default`→`is_default`, `scheme`→`scheme`, and `valid`→`status`. It is tagged `Drupal 7` so it runs as part of a standard D7-source upgrade against a configured legacy database connection. The module only depends on core `migrate`; the destination requires the `domain` module to be present on the target site so the domain entity type exists. There are no routes, services, permissions, or config of its own — it is consumed through Migrate's Drush commands or the Migrate Upgrade/UI tooling.

---

- Migrate Drupal 7 Domain Access records into a Drupal 10/11 site.
- Import each D7 `domain` table row as a `domain` config entity.
- Read legacy domains with the `d7_domain` source plugin over a configured D7 database connection.
- Map D7 `machine_name` to the new domain entity id.
- Carry over each domain's sitename as the entity name.
- Preserve the D7 subdomain/hostname as both hostname and path.
- Keep the per-domain weight ordering from the source site.
- Retain which domain was marked the default.
- Preserve each domain's URL scheme (http/https).
- Map the D7 `valid` flag to the new domain's active/inactive status.
- Run the migration via Drush (`drush migrate:import d7_domain`).
- Include it automatically in a Migrate Upgrade run from a D7 source.
- Check migration status and roll it back with standard Migrate commands.
- Use `d7_domain` as the dependency target for other Domain-related D7 migrations (e.g. domain access).
- Inspect available source fields through the plugin's `fields()` definitions.
