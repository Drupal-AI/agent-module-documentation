# consentmanager core — agent index

Base module for consentmanager.net (cookie banner / GDPR-CCPA CMP). Defines the `consent_manager`
plugin type + a generic block; real integrations are submodules. Renders nothing itself
(`configure` null). One permission `administer consent manager settings` (**restrict access: true**).
Admin menu container at `/admin/config/consent-manager`.

- **The `consent_manager` plugin type (attribute, manager, base class, `getCode()`), the generic
  block, and the shared `SettingsBaseForm` / install-popup flow** → [plugins/plugin.md](plugins/plugin.md)

Submodules (own docs):
- Cookie banner `consent_manager_cmp` → [../../modules/consent_manager_cmp/3.0.x/agent/start.md](../../modules/consent_manager_cmp/3.0.x/agent/start.md)
- Analytics `consent_manager_analytics` → [../../modules/consent_manager_analytics/3.0.x/agent/start.md](../../modules/consent_manager_analytics/3.0.x/agent/start.md)
- Data Subject Rights `consent_manager_dsr` → [../../modules/consent_manager_dsr/3.0.x/agent/start.md](../../modules/consent_manager_dsr/3.0.x/agent/start.md)
- Privacy Policy `consent_manager_pcp` → [../../modules/consent_manager_pcp/3.0.x/agent/start.md](../../modules/consent_manager_pcp/3.0.x/agent/start.md)
- Whistleblowing `consent_manager_wb` → [../../modules/consent_manager_wb/3.0.x/agent/start.md](../../modules/consent_manager_wb/3.0.x/agent/start.md)

Key facts:
- Plugin dir `Plugin/ConsentManager`, attribute `#[ConsentManager(id, label, description, deriver,
  has_block=TRUE)]`, interface `ConsentManagerPluginInterface`, base
  `ConsentManagerPluginPluginBase`, manager service `plugin.manager.consent_manager`.
- Each plugin's config is auto-loaded from config object `consent_manager_<id>.settings`.
- `getCode()` builds the vendor snippet via `FormattableMarkup` with escaped `@codeid`/`@host`/`@cdn`
  placeholders; defaults `delivery.consentmanager.net`, `cdn.consentmanager.net`.
- Generic block id `consent_manager` (deriver renders each `has_block` plugin as a derivative).
- Front-end code is emitted as **raw markup** on every non-admin page by submodules — by design,
  behind the restricted admin perm (see plugins/plugin.md "Rendering & hardening").
