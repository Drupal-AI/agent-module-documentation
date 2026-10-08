<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_config — agent index

Submodule of **events_log_track**. Records **configuration changes** (config saves and deletes)
into the shared `event_log_track` table, with a concise diff of what changed. Depends on
`event_log_track` only.

- Handler (`hook_event_log_track_handlers`): type **`config`**, title *Configuration*,
  operations `save`, `delete` — `EventLogTrackConfigHooks`.
- Recording is done by an **event subscriber**, `EventLogTrackConfigSubscriber` (service
  `event_log_track_config_subscriber`), on core `ConfigEvents::SAVE` and `ConfigEvents::DELETE`:
  - New config → description `"Config added"`.
  - Changed config → description is a `; `-joined diff of changed keys built by comparing raw
    data to the original (`key: old -> new`, with nested-array add/remove/change handling).
    Keys `dependencies`, `third_party_settings`, `_core`, `uuid`, `langcode` are ignored.
  - Deleted config → description `"Config removed"`.
  - `ref_char` = the config object name (e.g. `system.site`).
- Pairs well with the parent's **`skip_patterns`** (matched on `ref_char`) to silence noisy
  config, e.g. `system.*`, `core.*`.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
