# Team settings

All admin forms live under `/admin/config/apigee-edge` and mostly require `administer team`
(invitation form requires `administer team_invitation`).

## Team + team-app settings
| Route | Form | Config / purpose |
|---|---|---|
| `apigee_edge_teams.settings.team` (configure) | `TeamAliasForm` | Relabel the Team entity + base-field options. Config `apigee_edge_teams.team_settings`. |
| `apigee_edge.display_settings.team` | `EdgeEntityDisplaySettingsForm` | Team display type / view mode. |
| `apigee_edge_teams.settings.team.cache` | `TeamCacheForm` | Team cache expiration. |
| `apigee_edge_teams.settings.team.permissions` | `TeamPermissionsForm` | Define team **roles** and which team permissions each grants. |
| `apigee_edge_teams.settings.team.team_invitation` | `TeamInvitationForm` | Invitation email/behavior. |
| `apigee_edge_teams.settings.team_app` | `TeamAppAliasForm` | Relabel Team App + base fields. Config `apigee_edge_teams.team_app_settings`. |
| `apigee_edge.display_settings.team_app` | `EdgeEntityDisplaySettingsForm` | Team-app display. |
| `apigee_edge_teams.settings.team_app.credentials` | `TeamAppCredentialsForm` | Team-app credential/API-key settings. |
| `apigee_edge_teams.settings.team_app.cache` | `TeamAppCacheForm` | Team-app cache expiration. |
| `apigee_edge_teams.settings.team_member.sync` | `TeamMemberSyncForm` | Run team-member synchronization. |

## Team roles (config entity `team_role`)
Two locked roles are installed:
- **admin** (`id: admin`): `team_manage_members`, `team_app_delete`, `team_app_update`,
  `team_app_add_api_key`, `team_app_edit_api_products`, `team_app_revoke_api_key`.
- **member** (`id: member`): `api_product_access_private`, `api_product_access_public`,
  `team_app_view`, `team_app_create`, `team_app_analytics`.

Every member has `member`; assign extra roles per user per team. Manage/add roles via
`TeamPermissionsForm`. Permission meanings are in
[../permissions/permissions.md](../permissions/permissions.md).

## Membership & invitations at runtime
- A team member is a Drupal user linked to the Apigee company/appgroup via
  `TeamMembershipManager` (`addMembers`/`removeMembers`/`getMembers`/`getTeams`).
- Invitations are `team_invitation` entities; accepting/declining is handled by
  `TeamInvitation*Form` and `TeamInvitationSubscriber`, with email via
  `apigee_edge_teams.team_invitation_notifier.email`. A `views.view.team_invitations` view is
  installed (optional config) to list them.
- Members list & management routes: `/teams/{team}/members` (`TeamMembersList`,
  `AddTeamMembersForm`, `EditTeamMemberForm`, `RemoveTeamMemberForm`), gated by
  `ManageTeamMembersAccess` (needs the `team_manage_members` team permission or global
  `manage team members`).
- A **team context switcher** block (`TeamContextSwitcherBlock`) + `TeamContextManager` let a user
  act within a chosen team's context.

## Config schema
`config/schema/apigee_edge_teams.schema.yml` covers `team_settings`, `team_app_settings`,
`team_role.*`, `team_settings` invitation, etc. Install defaults are in `config/install/`.
