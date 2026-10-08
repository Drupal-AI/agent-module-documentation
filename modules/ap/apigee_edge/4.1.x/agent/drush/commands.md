# Drush commands

Defined in `src/Commands/ApigeeEdgeCommands.php` (registered via `drush.services.yml`, needs Drush
`^13`). They delegate to `CliService` (`apigee_edge.cli`) and `ApigeeEdgeManagementCliService`.

| Command | Aliases | Action |
|---|---|---|
| `apigee-edge:sync` | — | Runs **developer synchronization** between Drupal and the connected Apigee org: creates/updates Drupal users from Apigee developers and vice versa (same job as the `DeveloperSyncForm`). |
| `apigee-edge:create-edge-role` | `create-edge-role` | Creates a **custom Apigee role** (default `drupalportal`) in an org with exactly the API permissions the Drupal connection needs, using an orgadmin credential. Args: `<org> <email>`. |

`create-edge-role` options: `--password` (prompted if omitted), `--base-url`
(default `https://api.enterprise.apigee.com/v1`), `--role-name` (default `drupalportal`), `--force`
(update permissions on an existing role instead of erroring; only adds, never removes).

Examples:
```
drush apigee-edge:sync
drush create-edge-role myorg admin@example.com
drush create-edge-role myorg admin@example.com --role-name=portal --force
drush create-edge-role myorg admin@example.com --base-url=https://api.edge.example.com
```

There is also a Drupal Console integration (`console.services.yml`): `DeveloperSyncCommand` and
`CreateEdgeRoleCommand` mirror these for sites still using drupal/console.

The **Teams** submodule adds `apigee-edge:teams-sync`
(see [teams drush](../../modules/apigee_edge_teams/4.1.x/agent/drush/commands.md)).
