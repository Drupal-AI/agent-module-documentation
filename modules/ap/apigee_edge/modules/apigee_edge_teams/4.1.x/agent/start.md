# Apigee Teams (apigee_edge_teams) — agent index

Adds **teams** (Apigee *companies* on Edge, *appgroups* on Apigee X) to the Apigee Edge module so
developers can be organized into groups that own **shared apps**. Introduces team entities, team apps,
team membership, an invitation flow, and a **per-team role** permission system layered on top of
Drupal's global permissions.

- Depends on `apigee_edge`, core `views`, core `datetime`.
- `configure` route: **`apigee_edge_teams.settings.team`** (`/admin/config/apigee-edge/team-settings`).
- Provides permissions (global + team-level), Drush (`apigee-edge:teams-sync`), config schema. No new
  plugin *types*, but adds Views access/filter plugins and a context-switcher block.

## Solution docs
- **Team settings, team-app settings, team roles, caching, invitations, member sync** →
  [configure/settings.md](configure/settings.md)
- **Global permissions and the per-team role permissions** →
  [permissions/permissions.md](permissions/permissions.md)
- **Drush (`apigee-edge:teams-sync`)** → [drush/commands.md](drush/commands.md)
- **Entity types + membership/permission services** → [api/services.md](api/services.md)

## Key facts
- Entity types: `team` (company/appgroup), `team_app`, `team_role` (config), `team_member_role`
  (per-user-per-team roles), `team_invitation` (content). Team access handler is
  `TeamAccessHandler`; team-app access is `TeamAppAccessHandler`.
- Team roles ship as config: `admin` (locked) and `member` (locked) — see their granted permissions
  in configure/settings.md.
- Key services: `apigee_edge_teams.team_membership_manager` (`TeamMembershipManager`),
  `apigee_edge_teams.team_permissions` (`TeamPermissionHandler`),
  `apigee_edge_teams.context_manager` (`TeamContextManager`),
  `apigee_edge_teams.team_member_api_product_access_handler`.
- Team-level permission registration: `apigee_edge_teams.team_permissions.yml` →
  `DefaultTeamPermissionsProvider`.
- Global admin permissions: `administer team`, `manage team members`, `manage team_app`,
  `administer team_invitation`, plus generated view/create/update/delete for `team`.
