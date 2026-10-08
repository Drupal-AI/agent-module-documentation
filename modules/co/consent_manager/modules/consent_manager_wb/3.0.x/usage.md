consentmanager Whistleblowing Tool is a consent_manager submodule that embeds a consentmanager.net whistleblowing report form into a page via a block, helping comply with the EU Whistleblowing Directive.

---

The submodule defines the `wb` consent_manager plugin (`Wb`, block-enabled) with the code template `<div id="whistleblower"></div><script async src="https://@host/delivery/whistleblowerform.php?wbid=@codeid&type=script" ...></script>`. It is rendered through the generic `consent_manager` block deriver, so you place the "Whistleblowing Tool" block on the desired page. Its settings form (`consent_manager_wb.settings` at `/admin/config/consent-manager/wb`, permission `administer consent manager settings`) collects a required `codeid` and optional `host` (default `delivery.consentmanager.net`, hostname-validated). `getCode()` (inherited base) escapes the Code-ID/host placeholders and returns FALSE without a Code-ID; the block output carries the `consent_manager_wb` cache tag. Configuration is only editable behind the restricted admin permission.

---

- Add a whistleblowing report form to your website.
- Help comply with the EU Whistleblowing Directive / Whistleblower Protection Act.
- Let employees or third parties submit confidential reports.
- Place the whistleblowing form on a dedicated compliance page via a block.
- Configure the form with a consentmanager.net Code-ID.
- Point the form script at a custom consentmanager host.
- Auto-fill the Code-ID/host via the "Install now" onboarding popup.
- Embed the form in any block region.
- Use consentmanager.net's hosted whistleblowing workflow rather than custom code.
- Cache the whistleblowing block output and invalidate on settings change.
- Restrict whistleblowing configuration to trusted administrators.
- Combine the tool with the consentmanager cookie banner and other products.
- Provide a confidential reporting channel required by compliance obligations.
- Show the form only on pages where the block is placed.
- Serve the form from a region-specific consentmanager host.
- Offer a self-service intake form managed centrally in your consentmanager account.
