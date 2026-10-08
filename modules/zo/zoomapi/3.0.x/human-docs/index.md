# Zoom API — manual setup guide

**Zoom API** (`zoomapi`) is a developer module that wraps the
[Zoom.us](https://zoom.us/) REST API. As its own description says, it is "mainly
meant to be a developer module": it does not ship an end-user UI, but instead
gives developers the two halves of a Zoom integration — an outbound API client and
an inbound webhook endpoint — to build custom functionality on top of.

On the **outbound** side, the module registers a Zoom client through the
[API Tools](https://www.drupal.org/project/apitools) framework, so credentials,
base URL and OAuth settings are managed on API Tools' own client configuration
form. Custom code can then call Zoom REST endpoints through that client.

On the **inbound** side, it provides a single webhook endpoint at
`/zoomapi-webhooks` that accepts POST requests from Zoom and turns each one into a
Drupal event (`ZoomApiWebhookEvent`) carrying the payload, the event name and the
original request. Your own module subscribes to that event and reacts — for
example creating content when a webinar registration comes in, or storing
recording links when Zoom publishes them.

Security is built into the webhook: access is granted only when Zoom's signature
header matches a signature rebuilt from your configured **Event Secret Token**. If
no secret token is configured, every webhook is rejected — so the endpoint fails
closed. Unverified attempts are logged.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — and read the module's own README
before wiring it into custom code.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it with API Tools.
2. [Configuration](configuration/index.md) — configure the API Tools client
   credentials and Event Secret Token, and point Zoom at your webhook.

## Where it lives in the admin menu

Zoom API has no settings page of its own — its `configure` route is API Tools'
client configuration form (`apitools.client_config_form.zoomapi`). That is where
you set Zoom credentials and the Event Secret Token. The webhook endpoint itself
is the route `/zoomapi-webhooks` (POST only); there is no admin page for it.
