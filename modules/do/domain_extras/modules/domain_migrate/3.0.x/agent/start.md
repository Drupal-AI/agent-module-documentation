# Migrate Domain (domain_migrate) 3.0.x

Drupal 7 → Drupal 10/11 migration source plugin that imports legacy Domain Access records as `domain` config entities.

## Facts

- **Dependencies:** `drupal:migrate` (core). Destination `entity:domain` requires the `domain` module on the target site.
- **Package:** Migration.
- **Routes / services / permissions / config:** none.
- **Plugins provided (implements core's migrate plugin type; does not define a new one):**
  - Source plugin `d7_domain` — `src/Plugin/migrate/source/d7/DomainRecord.php` (`Drupal\domain_migrate\Plugin\migrate\source\d7\DomainRecord`, extends `Drupal\migrate\Plugin\migrate\source\SqlBase`).
- **Migration definition:** `d7_domain` — `migrations/d7_domain.yml`, tagged `Drupal 7`.
- **Hooks:** none.

### `d7_domain` source plugin
- Reads the Drupal 7 **`domain`** table.
- Selects fields: `domain_id`, `subdomain`, `sitename`, `scheme`, `valid`, `weight`, `is_default`, `machine_name`.
- Source id: `domain_id` (integer).
- Produces one row per legacy domain record for the migration to process.

### `d7_domain` migration (process map)
- destination: `entity:domain` (`destination_module: domain`).
- `machine_name` → `id`
- `sitename` → `name`
- `subdomain` → `hostname` and `path`
- `weight` → `weight`
- `is_default` → `is_default`
- `scheme` → `scheme`
- `valid` → `status`

## How to use

The module has no UI. Run it through Migrate's tooling against a configured Drupal 7 database:

- `drush migrate:import d7_domain` (with a legacy DB connection configured), or
- let it run as part of a Migrate Upgrade run from a Drupal 7 source (it is tagged `Drupal 7`).

Standard Migrate commands apply: `migrate:status`, `migrate:rollback d7_domain`.
