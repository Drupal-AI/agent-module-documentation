# Entity types & services

## Entity types (all defined with apigee_edge's `EdgeEntityType`/core annotations)

| Entity type id | Kind | Purpose |
|---|---|---|
| `team` | Apigee SDK-backed | A team = Apigee **company** (Edge) or **appgroup** (Apigee X). Access: `TeamAccessHandler`. |
| `team_app` | Apigee SDK-backed | An app owned by a team (shared credentials/API keys). Access: `TeamAppAccessHandler`. |
| `team_role` | config entity | A named bundle of team permissions (e.g. `admin`, `member`). |
| `team_member_role` | content (SQL) | Assigns team roles to a user within a specific team. Access: `TeamRoleAccessHandler`. |
| `team_invitation` | content (SQL) | A pending invitation for a user to join a team. Access: `TeamInvitationAccessControlHandler`. |

The Edge vs. Apigee X backend is abstracted by controller proxies
(`CompanyMembersController` / `AppGroupMembersController` and the `TeamAppController*` families), so
the same Drupal entities work against both Apigee flavors.

## Key services

| Service id | Class | Use |
|---|---|---|
| `apigee_edge_teams.team_membership_manager` | `TeamMembershipManager` | `getMembers($team)`, `addMembers($team, $devs)`, `removeMembers(...)`, `getTeams($developer)`, `syncAppGroupMembers($team)`. The main API to read/change who is in a team. |
| `apigee_edge_teams.team_permissions` | `TeamPermissionHandler` | Resolves a user's **team permissions** within a given team (from their team roles + dynamic providers). Use `getPermissions($team, $account)`. |
| `apigee_edge_teams.context_manager` | `TeamContextManager` | Tracks/switches the "current team" context for a request. |
| `apigee_edge_teams.team_member_api_product_access_handler` | `TeamMemberApiProductAccessHandler` | Decides which API products a team member may view/assign to team apps (honors the `api_product_access_*` team permissions). |
| `apigee_edge_teams.team_invitation_notifier.email` | `TeamInvitationNotifierEmail` | Sends invitation emails. |

## Example
```php
/** @var \Drupal\apigee_edge_teams\TeamMembershipManagerInterface $m */
$m = \Drupal::service('apigee_edge_teams.team_membership_manager');
$m->addMembers('my_team', ['dev@example.com']);
$teams = $m->getTeams('dev@example.com'); // team ids the developer belongs to

/** @var \Drupal\apigee_edge_teams\TeamPermissionHandlerInterface $p */
$p = \Drupal::service('apigee_edge_teams.team_permissions');
$perms = $p->getPermissions($team, $account); // e.g. ['team_app_view', 'team_app_create', ...]
```

## Views / block integration
Views plugins: access plugin `TeamPermission` (`Plugin/views/access/`) and filter
`TeamInvitationStatusFilter`. Block: `TeamContextSwitcherBlock`. Access checks:
`ManageTeamMembersAccess`, `TeamAppListByTeamAccess`. Events: `TeamInvitationEvents`
(`Event/TeamInvitationEvents.php`) fire on invitation lifecycle.

## Hooks for integrators
`apigee_edge_teams.api.php` documents the hooks this module invokes (e.g. altering team permissions /
team membership behavior).
