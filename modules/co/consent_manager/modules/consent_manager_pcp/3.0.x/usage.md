consentmanager Privacy Policy Generator is a consent_manager submodule that embeds a consentmanager.net-generated privacy policy into a page via a block.

---

The submodule defines the `pcp` consent_manager plugin (`Pcp`, block-enabled) with the code template `<div class="cmppolicy@codeid cmpstyleroot"></div><script src="https://@host/delivery/pcpinfo.php?cdid=@codeid&format=simple&lang=automatic" async></script>`. It is rendered through the generic `consent_manager` block deriver, so you place the "Privacy Policy Generator" block on your privacy-policy page. Its settings form (`consent_manager_pcp.settings` at `/admin/config/consent-manager/psp`, permission `administer consent manager settings`) collects a required `codeid` and optional `host` (default `delivery.consentmanager.net`, hostname-validated). `getCode()` (inherited base) escapes the Code-ID/host placeholders and returns FALSE without a Code-ID; the block output carries the `consent_manager_pcp` cache tag. Configuration is only editable behind the restricted admin permission.

---

- Embed an auto-generated privacy policy on your site.
- Keep the privacy policy in sync with your consentmanager.net configuration.
- Place the privacy policy on a dedicated legal/privacy page via a block.
- Configure the policy with a consentmanager.net Code-ID.
- Point the policy script at a custom consentmanager host.
- Auto-fill the Code-ID/host via the "Install now" onboarding popup.
- Show a localized privacy policy (`lang=automatic`).
- Comply with GDPR/CCPA disclosure requirements without writing the policy by hand.
- Cache the policy block output and invalidate on settings change.
- Restrict privacy-policy configuration to trusted administrators.
- Combine the policy with the consentmanager cookie banner and other products.
- Render the policy inside any block region.
- Use consentmanager.net's hosted policy generator rather than a static page.
- Style the policy via the `cmppolicy<codeid>` / `cmpstyleroot` container classes.
- Serve the policy from a region-specific consentmanager host.
- Provide up-to-date legal text managed centrally in your consentmanager account.
