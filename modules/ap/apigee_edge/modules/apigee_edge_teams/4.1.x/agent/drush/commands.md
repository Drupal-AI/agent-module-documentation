# Drush commands

Defined in `src/Commands/ApigeeEdgeCommands.php` (registered via `drush.services.yml`), delegating to
the teams `CliService` (`apigee_edge_teams.cli`).

| Command | Aliases | Action |
|---|---|---|
| `apigee-edge:teams-sync` | — | Synchronizes **team members** between Drupal and the connected Apigee org — i.e. reconciles Drupal team memberships with the members of the corresponding Apigee company (Edge) / appgroup (Apigee X). Same job as the `TeamMemberSyncForm`. |

```
drush apigee-edge:teams-sync
```

Runs as chunked background jobs (`src/Job/TeamMemberSync`, `TeamMemberCreateUpdate`,
`TeamMemberUpdate`) via the parent module's `JobExecutor`. Use it after first install or whenever team
membership was changed directly in Apigee, so Drupal reflects the current members.
