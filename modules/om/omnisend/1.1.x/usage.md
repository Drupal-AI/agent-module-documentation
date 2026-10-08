<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Omnisend connects Drupal to the Omnisend marketing platform, syncing form submissions as contacts and surfacing lists and campaigns in an admin dashboard.

---

The module provides an `OmnisendApi` service that calls Omnisend's REST API (`api.omnisend.com` / `a.omnisend.com`) to fetch lists and campaigns and to create/subscribe contacts (`syncContact()` posts email plus optional name/address/demographic fields). A Webform handler plugin (`OmnisendFormHandler`) lets a Webform push submissions to Omnisend on submit. Admin screens include a settings form at `/admin/config/services/omnisend` (`administer site configuration`) for the API key and a dashboard/campaigns view (`access omnisend dashboard`).

API calls use Guzzle with default TLS verification (enabled) and hard-coded Omnisend endpoints. The API key is stored in the `omnisend.settings` config object and sent as an `X-API-KEY`/`Omnisend-API-Key` header. Note the dashboard permission is referenced but not defined by a `permissions.yml`, so those routes are effectively limited to user 1 until the permission is provided.

---
- Sync newsletter/contact form submissions into Omnisend.
- Subscribe visitors to Omnisend from a Webform.
- Push name, address, and demographic fields to Omnisend contacts.
- View your Omnisend lists inside Drupal.
- Review Omnisend campaigns from an admin dashboard.
- Centralise email-marketing signups through Webform.
- Map a signup Webform to Omnisend via a handler.
- Store the Omnisend API key in site configuration.
- Grow a marketing audience from site forms.
- Trigger a welcome email flow on new contact creation.
- Keep contact data flowing to Omnisend automatically.
- Segment contacts using data collected on the site.
- Connect an e-commerce or content site to Omnisend.
- Manage the integration from a single settings form.
- Reuse the OmnisendApi service in custom code.
- Bridge Drupal audiences to Omnisend automations.
