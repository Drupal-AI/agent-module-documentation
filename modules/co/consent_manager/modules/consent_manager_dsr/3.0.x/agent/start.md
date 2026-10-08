# consentmanager Data Subject Rights (consent_manager_dsr) — agent index

consent_manager submodule that embeds a consentmanager.net Data Subject Rights (DSAR) request form
via the generic `consent_manager` block, letting visitors exercise GDPR rights (access, erasure,
etc.). The form and all request handling live on consentmanager.net's remote script; the submodule
only embeds it. Plugin `dsr` (block-enabled). Depends on `consent_manager`. Config
`consent_manager_dsr.settings` at `/admin/config/consent-manager/dsr` (permission `administer
consent manager settings`, restrict access). No permission/drush/plugin-type of its own.

- **Settings form, config keys, how to set it, block placement & rendering** →
  [configure/settings.md](configure/settings.md)
- Plugin-type internals (shared base, `getCode()`, generic block) →
  [../../../../3.0.x/agent/plugins/plugin.md](../../../../3.0.x/agent/plugins/plugin.md)

Key facts:
- Plugin `src/Plugin/ConsentManager/Dsr.php`, `CODE = <div id="dsar"></div><script async
  src="https://@host/delivery/dsarform.php?dsarid=@codeid&type=script" data-cmp-ab="1"></script>`.
- Config keys: `codeid` (required), `host` (optional, default `delivery.consentmanager.net`,
  hostname-validated). `getCode()` returns FALSE (renders nothing) without a Code-ID.
- Output via generic block deriver `consent_manager:dsr`; cache tag `consent_manager_dsr`.
- No local route/controller/storage for subject requests — only the admin settings form.
