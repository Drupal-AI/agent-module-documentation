<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Compliance embeds the third-party hu-manity.co consent banner into the site by injecting its remote script into the HTML head.
---
The module solves the "add a cookie-consent banner" task by wiring in the hosted hu-manity.co (cookie-compliance.co) service rather than shipping its own consent logic. You register a domain on cookie-compliance.co, obtain an **App ID** (and optional App Secret Key), and enter them at the settings form. When enabled with a non-empty App ID, `hook_page_attachments_alter()` writes an inline `<script>` that sets `huOptions.appID` plus a `<script src="https://cdn.hu-manity.co/hu-banner.min.js">` tag into the page `<head>` on every response.

Operationally it is a thin integration: one config object (`cookie_compliance.settings`) holding `enabled`, `app_id`, `app_secret_key`. The settings form validates that App ID / secret match `^[a-z0-9\-]+$`. The banner behaviour, categories, and consent storage all live in the remote hu-manity.co service and its CDN script — nothing is stored or enforced locally. Because the banner is loaded from an external CDN on every page, it is a client-side third-party dependency; there is no server-side callback or data ingestion. The settings route is gated by `administer site configuration`.
---
- Install and enable the module to add a cookie-consent banner backed by hu-manity.co.
- Register your domain at cookie-compliance.co to obtain an App ID.
- Enter the App ID at /admin/config/system/cookie-compliance-settings.
- Optionally store the App Secret Key alongside the App ID.
- Tick "Enable cookie compliance banner" to switch the banner on site-wide.
- Untick the enable box to remove the banner without deleting credentials.
- Confirm the hu-banner.min.js script appears in the page head after enabling.
- Verify the injected huOptions.appID matches your registered App ID.
- Restrict who can change the banner via the "administer site configuration" permission.
- Export cookie_compliance.settings to move the App ID between environments.
- Use a different App ID per environment (staging vs production) via config overrides.
- Disable the banner on internal-only sites where consent is not required.
- Audit the head markup to prove the consent banner is present for compliance.
- Rely on the external service for consent category management and cookie blocking.
- Combine with a CSP that allows cdn.hu-manity.co as a script source.
- Remove the module to fully strip the banner and its remote script tag.