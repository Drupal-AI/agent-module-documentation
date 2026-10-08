<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Overrides Drupal's logger factory with a channel-aware one so you can enable or disable (toggle) logging for specific channels emitted by core and contrib/custom modules.

---

Some modules are noisy and write log entries you cannot easily turn off, flooding dblog/syslog. This module swaps the `logger.factory` service class for `NullableLoggerChannel` via a `ServiceProvider` (`ToggleChannelsServiceProvider::alter()`), injecting request/current-user/config plus a `NullableLogger` sink tagged as a logger. When a channel is toggled off in configuration, log calls for that channel are routed to `NullableLogger`, whose PSR-3 methods are all empty — the message is silently dropped instead of being written.

Configuration is a simple admin form at `/admin/config/development/logging/toggle_channels` (permission `administer site configuration`) that lists channels and lets you disable the ones you don't want. Because it replaces the logger factory globally, it affects all logging backends at once; the choice of which channels to silence is stored in `toggle_channels.settings`. This is a developer/operations convenience — silenced channels lose their audit trail, so avoid disabling security-relevant channels.

Setup: enable the module, visit the settings form, tick the channels to disable, and save. No further wiring is needed.

---

- Silence a noisy contrib module's log channel
- Disable logging for a specific channel across all backends
- Re-enable a previously disabled channel
- Reduce dblog/watchdog noise during development
- Cut syslog volume from chatty channels in production
- Override the core logger factory with a channel-aware one
- Route disabled channels to a no-op logger sink
- Keep important channels logging while muting others
- Manage channel toggles from a single admin form
- Store channel on/off state in module configuration
- Stop a bug-spamming channel from filling the log table
- Focus debugging by muting unrelated channels
- Apply toggles globally without patching the noisy module
- Gate the settings form behind administer site configuration
- Trim log storage growth from unwanted messages
- Temporarily quiet a channel during a migration/import
- Avoid disabling security/audit channels by choice
- Clean up log output for clearer status reports
