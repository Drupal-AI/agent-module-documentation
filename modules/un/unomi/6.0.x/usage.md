<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unomi Integration links a Drupal site to an Apache Unomi customer-data platform (self-hosted or a hosted service such as Dropsolid), so visitor profiles and segments computed by Unomi can drive personalization in Drupal.

---

Connectivity is handled by a pluggable `UnomiConnector` plugin type: the shipped `BasicAuthUnomiConnector` talks to the Unomi REST API via `@http_client` using an admin-configured server URI plus HTTP basic-auth username/password. `UnomiClientBase`/`UnomiClientBasicAuth` wrap the API calls and cache responses in a dedicated `cache.unomi` bin; `UnomiCookieManager` reads/writes the Unomi profile cookie from the request. A `SegmentSelection` condition plugin lets other modules/blocks show or hide content based on the visitor's Unomi segments. All settings live at `/admin/config/services/unomi` behind the `administer unomi` permission.

The Unomi server URI is admin-configured and TLS is left at Guzzle defaults. The connector re-uses the existing saved password when the form is submitted without a new one. Setup: stand up or obtain a Unomi endpoint, add a connector with its URL + basic-auth credentials at the settings form, then use the segment condition where personalization is needed.

---
- Connect Drupal to an Apache Unomi CDP.
- Authenticate to Unomi with HTTP basic auth.
- Configure the Unomi server URI and credentials.
- Use a hosted Unomi (e.g. Dropsolid) instead of self-hosting.
- Read the visitor's Unomi profile cookie.
- Fetch a visitor's segments from Unomi.
- Show/hide a block based on Unomi segment membership.
- Cache Unomi API responses to reduce load.
- Add a custom connector plugin for a different auth strategy.
- Personalize content by CDP segment.
- Track anonymous visitor profiles across sessions.
- Restrict Unomi configuration with a permission.
- Map Unomi segments to Drupal visibility conditions.
- Log Unomi API errors to a dedicated channel.
- Reuse the saved password when updating other settings.
- Drive marketing personalization from a central CDP.
