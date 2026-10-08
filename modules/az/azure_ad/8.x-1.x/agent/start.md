<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange Azure AD / B2C Synchronization (azure_ad) — agent index

**Provisions/de-provisions Drupal users to and from Azure AD / B2C via Microsoft Graph (miniOrange connector).**

- **Version:** 8.x-1.x (8.x-1.16)
- **Core:** ^9 || ^10 || ^11
- **Depends:** `user_provisioning` (performs the actual directory/token calls)
- **Config entry:** `azure_ad.overview` → `/admin/config/people/azure_ad/overview`
- **Routes:** ~16 admin forms under `/admin/config/people/azure_ad/*` (overview, configure_azure, azure_to_drupal_configure, mapping, advance_settings, automatic/manual provisioning, manualuserSync, audit_logs, reviewconfig, trial/upgrade/support). **All require `administer site configuration`.**
- **Endpoints (src/moAzureConstants.php):** `login.microsoftonline.com/{tenant}/oauth2/v2.0/{authorize,token}`, `graph.microsoft.com` users, scope `.default`.
- **Helper:** `MoAzureUtilities::createCallbackUrl()` forces `https:`.

**Security:** every route is permission-gated by `administer site configuration`; no anonymous or public callback route is exposed by this module (the OAuth/token exchange lives in the `user_provisioning` dependency). No custom permissions. Handles Azure client credentials — store the client secret via a Key entity / env var, not plaintext config. Trial/support/customer-request forms transmit data to miniOrange; review before use. No disabled-TLS or raw-SQL sinks found in this module's own `src/`.

See [configure/azure_ad.md](configure/azure_ad.md)
