<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Amplitude

## Global settings — `/admin/config/system/amplitude` (`amplitude.settings`)
- `api_key` — Amplitude public project key (shipped to the browser).
- `debug` — enable Amplitude SDK debug logging.
- `config_options` — extra SDK init options.
- `user_properties` — token-enabled string, token-replaced with route entities, `strip_tags`'d, then JSON-decoded and sent as user properties.

## Events (`amplitude_event` config entities)
Each event stores: `event_trigger_pages` (request-path visibility), `event_trigger`,
`event_trigger_other`, `event_trigger_selector`, `event_trigger_data_capture`,
`event_trigger_data_capture_properties`, and token-enabled `properties`.
On each request the module builds a `request_path` condition from `event_trigger_pages`;
matching events are appended to `drupalSettings.amplitude['events']` and dispatched by the JS.

Manage events via the list builder linked from the settings form (add/edit/delete forms).