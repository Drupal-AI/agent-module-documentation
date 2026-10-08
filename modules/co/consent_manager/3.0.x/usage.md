consentmanager core is the base module for integrating the commercial consentmanager.net Consent Management Provider (cookie banner / GDPR-CCPA consent) into Drupal. It defines a plugin type and a generic block; the actual integrations (cookie banner, analytics, DSR, privacy policy, whistleblowing) ship as submodules.

---

The core module provides a `consent_manager` plugin type: an attribute-based plugin manager (`ConsentManagerPluginManager`, plugins in `Plugin/ConsentManager`, `#[ConsentManager(...)]` attribute, interface `ConsentManagerPluginInterface`, base class `ConsentManagerPluginPluginBase`) whose plugins produce a snippet of HTML/`<script>` markup (via `getCode()`) that embeds a consentmanager.net product keyed by a per-plugin **Code-ID** and served from consentmanager.net hosts (default `delivery.consentmanager.net` / `cdn.consentmanager.net`). Each plugin's configuration comes from its own submodule config object `consent_manager_<id>.settings` (loaded by `ConsentManagerPluginManager::createInstance()`). A generic block plugin (`consent_manager`, derived per plugin via `ConsentManagerBlock` deriver) renders any plugin flagged `has_block` into a region. An abstract `SettingsBaseForm` gives each submodule a settings form with an "Install now" button that opens a consentmanager.net onboarding popup and, via `js/settings.js` `postMessage` (origin-checked to `https://app.consentmanager.net`), auto-fills the returned Code-ID/host into the form fields. Core defines one permission, `administer consent manager settings` (**`restrict access: true`**), which gates every submodule settings form, and an admin menu container at `/admin/config/consent-manager`. Core itself renders nothing on the front end and has no settings of its own (`configure` null); enable the submodule(s) you need. Security note: submodule plugins output their code as raw markup into every non-admin page (see the cmp submodule's `custom_code`) — this is by design and is only editable behind the restricted admin permission.

---

- Provide the shared plugin/block infrastructure for consentmanager.net integrations.
- Add a new custom consentmanager.net product as a `consent_manager` plugin.
- Render a consentmanager.net product into a region via the generic `consent_manager` block.
- Gate all consentmanager configuration behind a single restricted admin permission.
- Auto-populate a submodule's Code-ID/host by clicking "Install now" and completing onboarding.
- Centralize consentmanager admin pages under one menu at /admin/config/consent-manager.
- Enable only the specific consentmanager products a site needs (cookie banner, analytics, etc.).
- Load a plugin's configuration from its own `consent_manager_<id>.settings` config object.
- Build a block for a plugin marked `has_block` (e.g. DSR form, privacy policy, whistleblowing).
- Reuse `ConsentManagerPluginPluginBase::getCode()` to emit a code snippet with escaped Code-ID/host.
- Override the default consentmanager delivery/CDN hosts per product.
- Invalidate a product's cache tag (`consent_manager_<id>`) when its settings change.
- Serve as the dependency for the cmp/analytics/dsr/pcp/wb submodules.
- Implement `hook_consent_manager_info` alter to modify discovered plugin definitions.
- Provide a consistent settings-form UX (manual + automatic install) across products.
- Integrate a GDPR/CCPA consent layer without hand-coding the vendor snippet in a template.
- Restrict who can change consent configuration to trusted administrators.
- Add analytics/consent products that must load after the cookie banner (module weight is set).
- Support multi-product consentmanager accounts, each product a separate submodule/plugin.
- Map a consentmanager account's Code-IDs to specific Drupal blocks/pages.
