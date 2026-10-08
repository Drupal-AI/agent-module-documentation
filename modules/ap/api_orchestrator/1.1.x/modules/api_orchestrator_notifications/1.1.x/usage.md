Multi-channel notification providers (Email, Slack, Microsoft Teams, WhatsApp) that fire on API Orchestrator request events, configured per service or per endpoint.

---

The Notifications submodule provides pluggable `NotificationProvider` plugins that deliver messages when an API request event occurs (primarily permanent failure). `NotificationDispatcherService` reads the `notification_providers` config on the endpoint (falling back to the service) and dispatches to each enabled provider. Ships Email (Drupal mail), Slack (incoming webhook), Microsoft Teams (webhook) and WhatsApp (Twilio or Meta Cloud API) providers. Every provider builds a rich message from request/service/endpoint context and supports token replacement in all config fields, including `{{env:…}}`, `{{state:…}}` and `{{config:…}}` for webhook URLs and API secrets, plus context tokens like `{{request_id}}`, `{{service_name}}`, `{{error_message}}`. Webhooks are sent over Guzzle with TLS verification on. Requires `api_orchestrator`.

---

- Notify a team on Slack when an API request fails permanently.
- Post failures to a Microsoft Teams channel via webhook.
- Send failure alerts to WhatsApp using Twilio or the Meta Cloud API.
- Email one or more addresses on request failure.
- Configure providers per endpoint, overriding service-level defaults.
- Configure providers at the service level as a default for all its endpoints.
- Keep webhook URLs and tokens out of stored config using `{{env:SLACK_WEBHOOK}}`-style tokens.
- Customize Slack messages with title, message, channel override, bot username, emoji and user mentions.
- Include or omit full request detail fields (method, URL, duration, retry count) in messages.
- Template WhatsApp messages with request-context tokens (Twilio free-form or Meta approved templates).
- Mask recipient phone numbers in logs.
- Send a test notification to verify a provider's configuration.
- Add a custom channel by implementing the `NotificationProvider` plugin.
- Reuse the same token/context model across all channels for consistent messages.
