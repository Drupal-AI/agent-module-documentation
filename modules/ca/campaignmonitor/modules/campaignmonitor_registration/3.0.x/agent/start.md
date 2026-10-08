# Campaign Monitor Registration — agent index

Submodule of the parent `campaignmonitor` module. Adds a newsletter **opt-in** checkbox (and, per
config, that list's subscribe fields) to the core **user registration** form, so a new account can be
subscribed to Campaign Monitor list(s) as it is created. All logic lives in
`campaignmonitor_registration.module`; the actual API work is delegated to the parent's subscription
manager. No plugins, no Drush, no config schema.

- **Admin settings form + config keys (opt-in label, list mode/id)** → [configure/settings.md](configure/settings.md)
- **The form alters it implements (register form + per-list settings form) and submit handlers** → [hooks/form-alters.md](hooks/form-alters.md)
- **Permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Parent module docs:
- Index → [../../../../3.0.x/agent/start.md](../../../../3.0.x/agent/start.md)
- Services (the subscribe form/handler reused here) → [../../../../3.0.x/agent/api/services.md](../../../../3.0.x/agent/api/services.md)

Key facts:
- Dependency: `campaignmonitor:campaignmonitor` (parent). `core_version_requirement: ^10.2 || ^11.0`.
- Admin route `campaignmonitor_registration.admin` → `admin/config/services/campaignmonitor/registration`
  (perm `administer campaignmonitor`), form `CampaignMonitorRegistrationAdminForm`, form id
  `campaignmonitor_registration_admin_settings`.
- Config object `campaignmonitor_registration.settings`; keys `checkbox_text`, `list`, `list_id`,
  `list_id_text` (default config ships only `list_id_text`). No config schema shipped.
- Register-form field added: `campaignmonitor_subscribe` (checkbox). Per-list toggle added:
  `display.registration`.
- Permission `access campaignmonitor registration` (`restrict access: TRUE`) — declared but not referenced
  by the module's code.
- Reuses parent services `campaignmonitor.manager` and `campaignmonitor.subscription_manager`.
