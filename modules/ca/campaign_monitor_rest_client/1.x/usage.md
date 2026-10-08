<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Campaign Monitor REST Client provides configuration and a container service that wraps a lightweight, Guzzle-compatible HTTP client for the Campaign Monitor (createsend) REST API.

---

Campaign Monitor REST Client is developer infrastructure, not an end-user feature. It exposes one service, `campaign_monitor_rest_client`, that behaves like core's `http_client` but is pre-configured for the Campaign Monitor v3.2 REST API: it sets the base URI (`https://api.createsend.com/api/v3.2/`), applies API-key authentication, a 30-second timeout and a Drupal User-Agent, and decodes JSON responses automatically via a middleware. An admin settings form at `/admin/config/services/campaign_monitor_rest_client` stores the API key and an on/off status flag; when disabled the service returns a stub client that throws on any request. Other custom or contrib code injects the service and calls Guzzle-style methods (`$client->get('clients.json')`) to build subscriber, list, campaign and client integrations. It deliberately wraps the small `ilrwebservices/campaign-monitor-rest-api-client` library rather than the official `createsend-php` SDK, so it carries no entities, permissions, fields, plugins or Drush commands of its own.

---

- Add an API client for the Campaign Monitor / createsend REST API to a Drupal site.
- Inject the `campaign_monitor_rest_client` service into a custom service, controller or form.
- Configure the Campaign Monitor API key through the admin settings form.
- Toggle the client on production and off on staging/dev via the status checkbox.
- Retrieve the list of Campaign Monitor clients (`$client->get('clients.json')`).
- Fetch subscriber lists for a client and read list details.
- Add or update subscribers on a Campaign Monitor list from Drupal code.
- Look up a subscriber's status (active, unsubscribed, bounced) by email.
- Unsubscribe or delete subscribers in response to Drupal events.
- Send transactional or smart-campaign triggers through the API.
- Build a newsletter signup handler that forwards submissions to Campaign Monitor.
- Sync Drupal user or webform data into Campaign Monitor custom fields.
- Read campaign summary and reporting endpoints for dashboards.
- Reuse one shared, pre-authenticated client across multiple integration classes.
- Rely on automatic JSON decoding of API responses (DataAwareResponse) instead of hand-parsing bodies.
- Use a Guzzle-compatible client so existing Guzzle knowledge and patterns apply.
- Keep integration code decoupled from credential handling by reading the key from central config.
- Provide a simpler alternative to the heavier official `createsend-php` SDK.
- Fail fast in non-production environments by disabling the client so accidental API calls throw.
- Set a per-request or site-wide `base_uri` override (still constrained to the createsend API host).
- Extend the Guzzle handler stack (retries, logging middleware) through `http_client_config` settings.
- Serve as the shared HTTP layer for a larger Campaign Monitor feature module you write on top.
