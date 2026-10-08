<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pigeon Paywall integrates the hosted Pigeon paywall service so nodes flagged with a boolean field are wrapped by a client-side subscription paywall.
---
Pigeon (from Sabramedia) is a JavaScript-based "soft" paywall: the site adds a boolean field to a content type, and the "Pigeon Paywall controller" field formatter (`pigeon_paywall_checkbox`) attaches the remote `pigeon.js` library (loaded from the configured subdomain) and a `drupalSettings.pigeon` payload identifying the entity. The Pigeon script then hides the DOM marked with the `pigeon-remove` class for non-subscribers and reveals a `pigeon-context-promotion` teaser. Global settings at `/admin/config/services/pigeon-paywall` (permission `administer pigeon paywall`) hold the subdomain, fingerprint/idp flags, published-only toggle and a bypass query argument.

Enforcement is entirely CLIENT-SIDE. `CheckboxPaywall::viewElements()` renders the full node content into the page and only attaches JS + drupalSettings; the protected content is present in the HTML delivered to anonymous visitors and is merely hidden/removed by `pigeon.js`. Anyone viewing source, disabling JavaScript, or reading the raw markup bypasses the paywall — so this is a trivially bypassable content gate, not a server-side access control. There is also an intentional per-entity bypass code (a plain-text field compared against a URL query argument using loose `==`); it is a designed feature but the loose comparison and the client-side model reinforce that no server-side protection exists. Setup: enter the Pigeon subdomain, add a boolean field, apply the formatter on the "full" view mode, add `pigeon-remove`/`pigeon-context-promotion` classes in the entity template.
---
- Flag individual nodes as paywalled with a boolean field.
- Apply the `pigeon_paywall_checkbox` formatter on the full view mode.
- Load the Pigeon JS from a configured account subdomain.
- Configure the Pigeon subdomain / account hostname.
- Enable browser fingerprinting to reduce cookie-removal fraud.
- Enable the IDP option for cross-domain Pigeon setups.
- Restrict the paywall to published content only.
- Mark page regions to hide with the `pigeon-remove` CSS class.
- Provide a teaser with the `pigeon-context-promotion` region.
- Add a `pigeon-open` link to open the Pigeon sign-in modal.
- Set a site-wide bypass query argument (default `pigeon`).
- Store a per-entity bypass code in a plain-text field.
- Share a bypass link (`?pigeon=CODE`) to preview without subscribing.
- Select which field holds the bypass code in the formatter settings.
- Link editors to the Pigeon admin dashboard from the settings form.
- Restrict paywall administration with the `administer pigeon paywall` permission.
- Integrate with Field Permissions to control who edits the flag field.
- Pass entity type:id, title and created time to the Pigeon script.
