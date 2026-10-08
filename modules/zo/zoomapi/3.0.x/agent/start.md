<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zoom API (zoomapi) — agent index

Developer module that talks to the Zoom.us REST API. It ships an **API Tools** client plugin
(`zoomapi`) that authenticates with a Zoom **Server-to-Server OAuth** app and exposes HTTP verb
methods, plus a webhook receiver route that dispatches a Drupal event for each Zoom event.
Does nothing on its own — you call `zoomapi.client` and/or subscribe to its event from your own
module. Requires contrib **`apitools`** (which in turn requires **`key`**). 3.x supports only
S2S OAuth; the 2.x JWT flow is gone. No permissions, no Drush, no config schema of its own.

Config is the API Tools client form: `configure: apitools.client_config_form.zoomapi`.

- **Set Zoom credentials, base URIs, the Event Secret Token; drush/PHP config** → [configure/settings.md](configure/settings.md)
- **Call the Zoom API from code (`zoomapi.client`), auth flow, methods, responses** → [api/client.md](api/client.md)
- **Receive Zoom webhooks, the dispatched event, subscribing, URL validation** → [api/webhooks.md](api/webhooks.md)

Key facts:
- Service **`zoomapi.client`** — class `Drupal\zoomapi\Plugin\ApiTools\Client` (extends apitools
  `ClientBase`, parent service `apitools.client_base`). Also `logger.channel.zoomapi`.
- API Tools client plugin id **`zoomapi`** (annotation `@ApiToolsClient`, `api = "zoomapi"`).
- Config object **`apitools.client.zoomapi`** (owned by apitools). Keys: `account_id`, `client_id`,
  `client_secret` (`key_select`), `event_secret_token` (`key_select`), `base_uri`
  (default `https://api.zoom.us`), `base_path` (default `v2`), `auth_token_url`
  (default `https://zoom.us/oauth/token`). `client_secret`/`event_secret_token` hold a **Key** entity ID.
- Route **`zoomapi.webhooks`** — `/zoomapi-webhooks`, `methods: [POST]`, controller
  `ZoomApiWebhooksController::capture`, custom access `ZoomApiWebhooksController::authorize`,
  `options.no_cache: 'TRUE'`.
- Event constant **`ZoomApiEvents::WEBHOOK_POST` = `'zoomapi.webhook.post'`**, object
  `Drupal\zoomapi\Event\ZoomApiWebhookEvent` with `getEvent()`, `getPayload()`, `getRequest()`.
- `ZoomapiServiceProvider::alter()` removes `zoomapi.client` when `apitools.client_base` is absent
  (prevents container errors if apitools is missing).
- `.install`: `hook_requirements` (runtime) errors if apitools is disabled or credentials are
  invalid; `zoomapi_update_9001` installs apitools; `zoomapi_update_9002` clears a legacy
  `event_verification_token` config key.
