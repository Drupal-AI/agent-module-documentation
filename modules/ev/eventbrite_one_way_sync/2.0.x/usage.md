<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Eventbrite One-Way Sync pulls events from one or more Eventbrite accounts into Drupal — initial bulk sync plus ongoing updates driven by Eventbrite webhooks — in a single direction (Eventbrite → Drupal only).
---
The core module talks to the Eventbrite v3 REST API (`https://www.eventbriteapi.com/v3`) using a private token per account, read from `settings.php`/config (`eventbrite_one_way_sync.unversioned` `api-keys`, keyed by account label) — tokens are never hardcoded. A `Session` fetches the org's events, and a `ProcessorFactory` picks a `SingleDateProcessor` or `SeriesProcessor` per event; events are modelled as valid/invalid/single-date/multi-date value objects. Webhooks are received through the required `webhook_receiver`/`webhook_receiver_defer` modules — the `Eventbrite` WebhookReceiver plugin defers processing (Eventbrite times out fast) and the `WebhookManager` routes the payload by its `config.action` (`test`, `event.updated`) to a processor. The sync itself is implemented as plugins via `EventbriteOneWaySyncPluginManager`, and the module ships smoke-test / end-to-end self-test services and a `hook_requirements` check.

The optional submodule **Eventbrite One-Way Sync Node** maps synced events onto nodes (requires `datetime_range`), providing a `NodeFactory` and configurable `FieldMapper`. Because this is one-way, Drupal is treated as a read replica of Eventbrite. Security note: this module contributes no public routes of its own — webhook authentication and endpoint exposure are delegated entirely to the `webhook_receiver` contrib module; the Eventbrite plugin performs no HMAC/signature verification of the payload, so the trust boundary is whatever `webhook_receiver` enforces. All outbound Eventbrite calls use HTTPS with Guzzle default TLS verification (not disabled).
---
- Configure one or more Eventbrite private tokens in settings.php keyed by account label.
- Set the Eventbrite organization id per account.
- Run an initial bulk import of an organization's events.
- Keep events up to date via Eventbrite `event.updated` webhooks.
- Defer webhook processing so Eventbrite's fast timeout is not hit.
- Sync a single specific event by its Eventbrite event id.
- Handle single-date events (SingleDateProcessor).
- Handle multi-date / series events (SeriesProcessor).
- Import synced events as Drupal nodes (submodule).
- Map Eventbrite fields to node fields via the FieldMapper.
- Store event start/end using datetime_range on the node.
- Run the built-in smoke test to verify connectivity.
- Run the end-to-end self-test against a dummy account.
- Check `hook_requirements` for missing tokens/dependencies.
- Add a custom sync plugin via the plugin manager.
- Support multiple Eventbrite accounts in one site.
- Treat Drupal as a read-only mirror of Eventbrite events.
- Log webhook actions through webhook_receiver's logger.
- Extend payload handling with a custom processor.
- Validate incoming payloads before processing.
