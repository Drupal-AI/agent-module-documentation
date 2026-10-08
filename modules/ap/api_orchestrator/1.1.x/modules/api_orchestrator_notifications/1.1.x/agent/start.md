<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Notifications (api_orchestrator_notifications) — agent index

Multi-channel notification providers for API Orchestrator request events. Depends on `api_orchestrator`.

## Provides
- Plugin type **NotificationProvider** (`Attribute\NotificationProvider` (+ legacy `Annotation\`), manager `plugin.manager.api_orchestrator_notification_provider`, interface `Plugin\NotificationProviderInterface`, base `NotificationProviderBase`). Bundled providers under `Plugin/NotificationProvider/`:
  - `EmailNotificationProvider` (`email`), `SlackNotificationProvider` (`slack`), `TeamsNotificationProvider` (`teams`), `WhatsAppNotificationProvider` (`whatsapp`).
- `NotificationProviderBase`: `sendWebhook()` (Guzzle POST, `timeout` 10, `http_errors` false, TLS on), `extractRequestInfo()`, `buildAutoTokens()` (request/service/endpoint + site/date tokens), `replaceTokens()`/`replaceConfigTokens()` supporting `{{name}}`, `{{name|default}}`, `{{env:}}`, `{{config:}}`, `{{state:}}`.
- Service `api_orchestrator.notification_dispatcher` (`NotificationDispatcherService`): `dispatchFailureNotification($request)` reads endpoint→service `notification_providers` config and sends to each enabled provider; also `sendTestNotification()`, `getAvailableProviders()`, `validateProviderConfig()`.
- Service `api_orchestrator.notification.email` (`Notification\EmailNotification`) — Drupal mail helper.
- `ApiOrchestratorNotificationsHooks` (constructed with the dispatcher) wires request-failure dispatch.

## WhatsApp specifics
`WhatsAppNotificationProvider` supports Twilio (`POST api.twilio.com/.../Messages.json`, HTTP basic auth with account SID/token) and Meta Cloud API (`POST graph.facebook.com/v18.0/{phone_id}/messages`, Bearer token, approved template). Recipients parsed from a newline list; phone numbers masked in logs.

## Notes
No routes/permissions/entities of its own — configuration lives on the parent `api_orchestrator_service` / `api_orchestrator_endpoint` `notification_providers` field. Add a provider: implement `NotificationProviderInterface` (extend `NotificationProviderBase`) with `#[NotificationProvider]`.
