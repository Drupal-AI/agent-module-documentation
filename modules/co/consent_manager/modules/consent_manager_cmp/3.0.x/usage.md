consentmanager Cookie Banner is the main consent_manager submodule: it injects the consentmanager.net cookie-banner / auto-blocking script into every non-admin page, so visitors get the GDPR/CCPA consent layer configured in your consentmanager.net account.

---

The submodule defines the `cmp` consent_manager plugin (`Cmp`, `has_block: FALSE`) whose `getCode()` builds either an automatic-blocking or semi-automatic `<script>` tag pointing at `https://<cdn>/delivery/...` with your Code-ID, host, and CDN, and prepends an optional `custom_code` string. Its settings form (`consent_manager_cmp.settings` at `/admin/config/consent-manager/cmp`, permission `administer consent manager settings`) collects: `blocking` (automatic vs semi-automatic), `codeid` (required), `host`, `cdn`, and `custom_code` (a free HTML textarea). Because the banner must load early, the code is emitted directly, not through a block: `consent_manager_cmp_page_attachments()` adds it to `html_head` when blocking is `automatic`; `consent_manager_cmp_preprocess_html()` adds it to `page_top` otherwise. Both skip admin routes and tag the output with the `consent_manager_cmp` cache tag. Host/CDN are validated as hostnames. The `custom_code` value is output unescaped (by design — it is meant to hold additional vendor markup); it and all cmp settings are only editable behind the restricted `administer consent manager settings` permission.

---

- Show a consentmanager.net cookie consent banner on every front-end page.
- Enable automatic ad/cookie blocking until the visitor consents.
- Use semi-automatic blocking mode when you manage tag firing yourself.
- Configure the banner with a consentmanager.net Code-ID.
- Point the banner at a custom consentmanager delivery host / CDN.
- Auto-fill the Code-ID/host by clicking "Install now" and completing onboarding.
- Add extra vendor markup before the banner script via the custom HTML code field.
- Load the banner script in the document head (automatic) or page top (semi-automatic).
- Keep the banner off admin routes.
- Become GDPR/CCPA compliant by collecting and storing visitor consent.
- Cache the banner output with a dedicated cache tag and invalidate on settings change.
- Restrict banner configuration to trusted administrators.
- Integrate the consentmanager.net TCF/consent layer without editing templates.
- Switch blocking strategy without code changes.
- Serve the banner from a self-configured consentmanager host for a specific account/region.
- Provide the base cookie-consent layer that other consentmanager products build on.
