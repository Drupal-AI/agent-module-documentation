consentmanager Data Subject Rights (DSR) is a consent_manager submodule that embeds a consentmanager.net Data Subject Rights request form into a page via a block, letting visitors exercise GDPR data-subject rights (access, deletion, etc.).

---

The submodule defines the `dsr` consent_manager plugin (`Dsr`, block-enabled) with the code template `<div id="dsar"></div><script async src="https://@host/delivery/dsarform.php?dsarid=@codeid&type=script" ...></script>`. Unlike the cookie banner it is rendered through the generic `consent_manager` block deriver, so you place the "Data Subject Rights" block on the desired page/region. Its settings form (`consent_manager_dsr.settings` at `/admin/config/consent-manager/dsr`, permission `administer consent manager settings`) collects a required `codeid` and optional `host` (default `delivery.consentmanager.net`, hostname-validated). `getCode()` (inherited base) escapes the Code-ID/host placeholders and returns FALSE without a Code-ID; the block output carries the `consent_manager_dsr` cache tag. Configuration is only editable behind the restricted admin permission.

---

- Add a GDPR Data Subject Rights request form to your site.
- Let visitors request access to their personal data.
- Let visitors request deletion/erasure of their data.
- Place the DSR form on a dedicated privacy/contact page via a block.
- Configure the DSR form with a consentmanager.net Code-ID.
- Point the DSR form at a custom consentmanager host.
- Auto-fill the Code-ID/host via the "Install now" onboarding popup.
- Embed the DSR form in any block region (footer, sidebar, page body).
- Comply with GDPR data-subject-request obligations without custom form code.
- Cache the DSR block output and invalidate on settings change.
- Restrict DSR configuration to trusted administrators.
- Combine the DSR form with the consentmanager cookie banner and analytics.
- Show the DSR form only on pages where the block is placed.
- Use consentmanager.net's hosted form logic rather than building your own.
- Provide a self-service privacy request channel for visitors.
- Serve the DSR form from a region-specific consentmanager host.
