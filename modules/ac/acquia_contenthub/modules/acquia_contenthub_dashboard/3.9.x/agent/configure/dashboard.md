# Configure — dashboard, allowed origins & auto publisher discovery

Config object: **`acquia_contenthub_dashboard.settings`**
(schema in `config/schema/acquia_contenthub_dashboard.schema.yml`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `allowed_origins` | sequence of string | `[]` | Publisher webhook origins added to the site's CORS allow-list. |
| `auto_publisher_discovery` | boolean | `TRUE` | Master switch for the discovery + CORS-extension behavior. |

There is **no dedicated settings form**. The switch is exposed as an **Automatic Publisher
Discovery** checkbox added to the base module's Content Hub admin settings form
(`hook_form_acquia_contenthub_admin_settings_alter` in `.module`, only when
`acquia_contenthub_subscriber` is enabled). Saving that form, or the "Update webhook" action,
runs `_acquia_contenthub_dashboard_update_webhook_filters()`, which calls
`AutoPublisherDiscoveryFilterHandler::updateDefaultClientPublisherFilterToWebhook()`.

Set values directly if needed:
```
drush cset acquia_contenthub_dashboard.settings auto_publisher_discovery 1
```

## Automatic publisher discovery (`AutoPublisherDiscoveryFilterHandler`)

When enabled it:
- saves `auto_publisher_discovery`,
- attaches a `client_publisher_filter` to this site's webhook via
  `ContentHubConnectionManager::addDefaultFilterToWebhook()` — an Elasticsearch-style query
  matching client CDF objects with `data.attributes.publisher.value.und = 'true'`,
- seeds `allowed_origins` from `ContentHubAllowedOrigins::getAllowedOrigins()` (queries the
  service for `type: client` entities and collects each publisher's
  `metadata.settings.webhook.settings_url`).

When disabled it removes that filter from the webhook.

## Keeping origins fresh on incoming webhooks (`UpdateAllowedOrigins`)

Subscribes to `AcquiaContentHubEvents::HANDLE_WEBHOOK` (priority 110), which the base module
dispatches **after** it validates the incoming webhook. If `auto_publisher_discovery` is on and
the payload is an applicable client `update` (status `successful`, initiator not this client), it
looks up the publisher's client CDF object through the authenticated client, and if it is a
publisher with a webhook `settings_url`, merges that URL into `allowed_origins`.

## CORS override (`AcquiaContenthubDashboardServiceProvider` + `ContentHubCors`)

The service provider replaces the `http_middleware.cors` service class with `ContentHubCors`
**only if** the `acquia_contenthub_subscriber.tracker` service exists and the site's `cors.config`
is not a full wildcard; it also force-enables CORS. At request time, when
`auto_publisher_discovery` is on, `ContentHubCors` merges into the CORS config:
- headers `Authorization`, `X-Acquia-Plexus-Client-Id`, `X-Authorization-Content-SHA256`,
  `X-Authorization-Timestamp`;
- methods `GET`, `OPTIONS`, `POST`, `PUT`;
- origins from `allowed_origins`.

Wildcard (`*`) entries are preserved as-is rather than being narrowed.
