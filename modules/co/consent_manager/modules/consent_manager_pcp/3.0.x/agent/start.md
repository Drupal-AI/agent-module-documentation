# consentmanager Privacy Policy Generator (consent_manager_pcp) — agent index

consent_manager submodule that embeds a consentmanager.net-generated, auto-localized privacy
policy via the generic `consent_manager` block. Plugin `pcp` (block-enabled). Depends on
`consent_manager`. Config `consent_manager_pcp.settings` at `/admin/config/consent-manager/psp`
(permission `administer consent manager settings`, restrict access). No permission/drush/plugin-type
of its own.

- **Settings form, config keys, how to set it, block placement & rendering** →
  [configure/settings.md](configure/settings.md)
- Plugin-type internals (shared base, `getCode()`, generic block) →
  [../../../../3.0.x/agent/plugins/plugin.md](../../../../3.0.x/agent/plugins/plugin.md)

Key facts:
- Plugin `src/Plugin/ConsentManager/Pcp.php`, `CODE = <div class="cmppolicy@codeid
  cmpstyleroot"></div><script src="https://@host/delivery/pcpinfo.php?cdid=@codeid&format=simple&lang=automatic"
  async></script>`.
- Config keys: `codeid` (required), `host` (optional, default `delivery.consentmanager.net`,
  hostname-validated). `getCode()` returns FALSE (renders nothing) without a Code-ID.
- Route path is `/admin/config/consent-manager/psp` (vendor typo; machine name is `pcp`).
- Output via generic block deriver `consent_manager:pcp`; cache tag `consent_manager_pcp`.
