<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zoom API is a developer module that wraps the Zoom.us REST API: it registers a Zoom client through the API Tools framework and re-broadcasts incoming Zoom webhooks as Drupal events, so custom code can call Zoom endpoints and react to meetings, webinars, recordings and participants.

---

Rather than shipping a UI, the module gives developers the two halves of a Zoom integration. Outbound, it defines an API Tools client plugin (`zoomapi`, service `zoomapi.client`, class `Drupal\zoomapi\Plugin\ApiTools\Client`) that authenticates with a Zoom **Server-to-Server OAuth** app using the `account_credentials` grant and exposes Guzzle-style `get`/`post`/`patch`/`delete` methods returning decoded JSON; credentials, base URI (`https://api.zoom.us`), path (`v2`) and token URL live on the API Tools client form (`configure: apitools.client_config_form.zoomapi`, config object `apitools.client.zoomapi`), and a `ZoomapiServiceProvider` wires the client into the container. Inbound, the single route `/zoomapi-webhooks` accepts **POST only** and hands the payload to `ZoomApiWebhooksController::capture()`, which dispatches a `ZoomApiWebhookEvent` carrying the decoded payload, the Zoom event name and the original request on `ZoomApiEvents::WEBHOOK_POST` (`zoomapi.webhook.post`); the controller also answers Zoom's `endpoint.url_validation` handshake. Secrets are held as **Key** entities (the module requires `apitools`, which requires `key`). As the description says, this is "mainly meant to be a developer module" — you write a custom module that calls the client and/or subscribes to the event.

---

- Call Zoom REST endpoints (users, meetings, webinars) from custom code via `zoomapi.client`.
- Authenticate with a Zoom Server-to-Server OAuth app without managing tokens yourself.
- React in Drupal when a Zoom meeting starts or ends.
- Store recording links when Zoom publishes a recording.
- Create Drupal content from Zoom webinar registrations.
- Sync meeting participants into Drupal user or membership records.
- Trigger notifications or emails on specific Zoom events.
- Subscribe to specific Zoom event types in a custom event subscriber.
- Build a meetings or webinars dashboard from Zoom data.
- Schedule Zoom meetings from Drupal content edits.
- Update event nodes when a Zoom webinar changes.
- Answer Zoom's endpoint URL-validation handshake automatically.
- Manage Zoom credentials and endpoints through the API Tools client form.
- Keep API secrets in Key entities (env var or file provider).
- Provide a single webhook endpoint for all Zoom Event Subscriptions.
- Inspect the raw incoming request through the event's `getRequest()`.
- Reuse the same client for any Zoom API v2 endpoint.
- Support multiple environments by overriding `base_uri`/`base_path` in config.
- Automate follow-up workflows after a Zoom session completes.
- Decouple Zoom webhook handling from your own controllers.
