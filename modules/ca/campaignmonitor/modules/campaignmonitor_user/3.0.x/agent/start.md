# Campaign Monitor User — agent index

Submodule of the parent `campaignmonitor` module. Adds a per-user **subscription-management page**
(profile tab `/user/{user}/campaignmonitor`) where a logged-in user views and changes which Campaign
Monitor lists they belong to, plus an admin form to configure that page. All API work is delegated to the
parent module. No plugins, no Drush, no config schema.

- **Admin settings form, the profile page route/controller, config keys** → [configure/settings.md](configure/settings.md)
- **Permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Parent module docs:
- Index → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
- Services + the reused `CampaignMonitorSubscribeForm` → [../../../../3.0.x/agent/api/services.md](../../../../3.0.x/agent/api/services.md)

Key facts:
- Dependency: `campaignmonitor:campaignmonitor` (parent). `core_version_requirement: ^10.2 || ^11.0`.
- Profile route `campaignmonitor_user.page` → `/user/{user}/campaignmonitor` (perm `access campaign monitor user`),
  controller `CampaignMonitorUserController::subscriptionPage()`, shown as a profile tab (base route
  `entity.user.canonical`).
- Admin route `campaignmonitor_user.admin` → `admin/config/services/campaignmonitor/user`
  (perm `administer campaignmonitor`), form `CampaignMonitorUserAdminForm`, form id
  `campaignmonitor_user_admin_settings`.
- Config object `campaignmonitor_user.settings`; default keys `subscription_heading`, `subscription_text`,
  `list_heading`; the admin form also stores `list`, `list_id`, `list_id_text`. No config schema shipped.
- Service `campaignmonitor_user.manager` (`CampaignMonitorUserManager`) extends the parent
  `CampaignMonitorManager` (adds current-user + entity-type-manager DI; no extra public methods).
- The page builds the parent `CampaignMonitorSubscribeForm` for the current user; the `{user}` route
  parameter is not used to load another account's data.
