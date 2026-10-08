<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eventbrite_one_way_sync — setup

1. Enable `webhook_receiver` + `webhook_receiver_defer` (dependency) and this module.
2. In `settings.php` (or the `eventbrite_one_way_sync.unversioned` config) define
   `api-keys` keyed by account label, each with `private_token` and
   `organization_id`. Tokens are read at runtime — never hardcode them in code.
3. Point an Eventbrite webhook at the `webhook_receiver` endpoint; the
   `eventbrite_one_way_sync` receiver plugin defers and processes
   `event.updated` / `test` actions.
4. (Optional) Enable `eventbrite_one_way_sync_node` + `datetime_range` and
   configure the `FieldMapper` to write events to node fields.

**Trust boundary:** this module adds no route of its own. Whatever
authentication `webhook_receiver` is configured with is the only gate on
inbound webhooks — the Eventbrite payload itself is not signature-verified
here. Outbound calls go to `https://www.eventbriteapi.com/v3` over HTTPS with
default certificate verification.
