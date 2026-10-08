# Drush — fix config entities with NULL UUIDs

Registered via `drush.services.yml` (service `acquia_contenthub_site_health.commands`,
class `AcquiaContentHubConfigNullUuidsFix`).

| Command | Aliases | Purpose |
|---|---|---|
| `acquia:contenthub-fix-config-entities-with-null-uuids` | `ach-fix-null-uuids` | Assign randomly generated UUIDs to configuration entities whose `uuid` is `NULL`. |

## Behavior (`fixConfigEntitiesWithNullUuids()`)

1. **Publisher guard** — throws `\Exception("This command should only be run on a publisher
   site.")` unless `acquia_contenthub_publisher` is enabled.
2. Iterates every entity type definition; skips anything that is not a `ConfigEntityType`.
3. For each config entity of that type, if `$entity->uuid()` is empty it:
   - resolves the config name via `getConfigDependencyName()`,
   - loads the editable config, sets `uuid` to `\Drupal::service('uuid')->generate()`, saves it,
   - reloads and prints `Entity type / Entity id / Entity uuid`.
4. Prints "All Drupal configuration entities have proper UUIDs." when none were missing.

Why: Content Hub keys syndicated configuration on UUID; a config entity created with a `NULL`
UUID cannot be tracked/exported reliably, so this backfills a stable UUID **on the publisher**
before syndication. Injected services: `entity_type.manager`, `config.factory`, `module_handler`,
`uuid`.

> Experimental module ("Use with caution"). Run on the publisher only, and export/verify your
> config after running, since it rewrites `uuid` values in configuration.
