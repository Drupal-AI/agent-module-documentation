# consentmanager Whistleblowing Tool (consent_manager_wb) — agent index

consent_manager submodule that embeds a consentmanager.net whistleblowing report form (EU
Whistleblowing Directive / Whistleblower Protection Act) via the generic `consent_manager` block.
Plugin `wb` (block-enabled). Depends on `consent_manager`. Config `consent_manager_wb.settings` at
`/admin/config/consent-manager/wb` (permission `administer consent manager settings`, restrict
access). No permission/drush/plugin-type of its own.

- **Settings form, config keys, how to set it, block placement & rendering** →
  [configure/settings.md](configure/settings.md)
- Plugin-type internals (shared base, `getCode()`, generic block) →
  [../../../../3.0.x/agent/plugins/plugin.md](../../../../3.0.x/agent/plugins/plugin.md)

Key facts:
- Plugin `src/Plugin/ConsentManager/Wb.php`, `CODE = <div id="whistleblower"></div><script async
  src="https://@host/delivery/whistleblowerform.php?wbid=@codeid&type=script" data-cmp-ab="1"></script>`.
- Config keys: `codeid` (required), `host` (optional, default `delivery.consentmanager.net`,
  hostname-validated). `getCode()` returns FALSE (renders nothing) without a Code-ID.
- Output via generic block deriver `consent_manager:wb`; cache tag `consent_manager_wb`.
- Form `\Drupal\consent_manager_wb\Form\SettingsForm` extends parent `SettingsBaseForm`
  (`getPluginType()` → `wb`); menu link under `consent_manager.admin_index`.
