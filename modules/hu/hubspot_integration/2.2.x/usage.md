<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hubspot Integration connects a Drupal site to HubSpot's CRM/marketing platform: it embeds HubSpot forms and behaviour through Field API formatters/widgets and a JS block, maps a visitor's HubSpot contact data onto Drupal taxonomy terms, and drives persona-based personalisation via a cookie.
---
The `HubspotAPI` service (`@database, @session, @config.factory`) reads the `hubspotutk` tracking cookie, calls the HubSpot Contacts API for the visitor's profile, and derives a set of term ids (tids) representing the contact. A sanitising `getCookie()` validates the `hubspot_integration` cookie before use. Admin config lives under `/admin/config/hubspot_integration` (menu block, Settings, Mapping, Sort forms) behind the `Administer hubspot integration` permission. Views plugins (argument/sort/argument_default) let you filter/sort content by the visitor's HubSpot tids, and Field plugins provide HubSpot form/behaviour fields, widgets and formatters. It depends on Paragraphs + Entity Reference Revisions.

Three routes are `_access: 'TRUE'` (public) by design: two read-only GET AJAX endpoints (`/hubspot_integration/ajax/is-contact`, `/is-limit-reached`) that return JSON booleans derived from the current visitor's own cookie/tids, and `/set-persona/{persona_id}` which sets a `hubspot_integration` persona cookie and redirects (destination built via `Url::fromUserInput` on a slash-prefixed path). This module was security-reviewed as SOUND: the AJAX endpoints only reflect the caller's own state and the persona route does not produce an open redirect. Outbound HubSpot API calls carry the API key from config.
---
- Enter the HubSpot API key/portal settings at /admin/config/hubspot_integration/admin.
- Map HubSpot contact properties to Drupal taxonomy terms.
- Configure mapping order on the Sort form.
- Embed a HubSpot form on a node via the HubSpot form field.
- Render HubSpot behaviour with the behaviour field formatter.
- Place the HubSpot JS form block in a region.
- Detect whether the current visitor is a known HubSpot contact (AJAX).
- Check whether the anonymous-contact limit has been reached (AJAX).
- Set a persona cookie via /set-persona/{persona_id} and redirect.
- Personalise content by the visitor's HubSpot-derived tids.
- Filter a View by HubSpot contact tids (Views argument).
- Provide a default argument from the visitor's HubSpot tids.
- Sort View results by HubSpot terms.
- Read the `hubspotutk` cookie to look up a contact profile.
- Sanitise the `hubspot_integration` cookie before use.
- Limit anonymous contact creation with a configurable max.
- Use paragraphs to build HubSpot-driven personalised sections.
- Cache-bust the AJAX endpoints (`no_cache: TRUE`).
- Send an anonymous-contact mail template with the hub cookie.
- Restrict all admin config to the HubSpot admin permission.
