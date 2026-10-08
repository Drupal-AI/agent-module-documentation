# Configuration

Zoom API is configured in two places: the API Tools client form (credentials and
the webhook secret) and your Zoom app (pointing its webhook at your site). After
that, the integration is driven by custom code that calls the client and
subscribes to the webhook event.

## 1. Configure the API Tools client

Zoom API does not have its own settings form — its configuration is the API Tools
client form for the Zoom client (`apitools.client_config_form.zoomapi`). Open it
from the admin menu (or resolve the route with Drush). On that form you set:

- **Zoom API credentials / OAuth settings** — the client details Zoom issued for
  your app, so the outbound client can authenticate against the Zoom REST API.
- **Base URL** — the Zoom API base URL, if the form asks for it.
- **Event Secret Token** — the secret you also configure in your Zoom app. This is
  what the module uses to verify incoming webhooks. **It is required for the
  webhook to work at all:** if no secret token is set, every incoming webhook is
  rejected.

Treat the credentials and the Event Secret Token as secrets — follow this
project's convention of sourcing them from environment variables (via a Key entity
where supported) rather than committing them into exported configuration.

## 2. Point Zoom at your webhook

In your Zoom app's event configuration, set the webhook (event notification)
endpoint to:

```
https://your-site.example/zoomapi-webhooks
```

and configure the **same Event Secret Token** there. The endpoint accepts **POST
requests only**. When a request arrives, the module checks the `x-zm-signature`
header against a signature it rebuilds from the request body and your secret token;
only a match is allowed through, and unverified attempts are logged.

## 3. React to webhook events in custom code

Once verified webhooks are arriving, they are dispatched as a Drupal event
(`ZoomApiWebhookEvent`) carrying the decoded payload, the Zoom event name and the
original request. Write a small custom module with an event subscriber to react —
for example creating content from a webinar registration, or storing a recording
link. The [`agent/`](../agent/start.md) docs show the subscriber signature and the
event details.

## 4. Call the Zoom API from custom code

For outbound calls, use the API Tools client that this module registers. Because
this is a developer module, there is no UI for making calls — read the module's
README and the API Tools documentation for how to obtain and use the client
service.
