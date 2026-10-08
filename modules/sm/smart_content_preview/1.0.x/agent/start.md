<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content Preview - agent index

Preview Smart Content variations by forcing chosen segments to pass. Version **1.0.2** (1.0.x), core `^8..^11`. Depends on `smart_content`.

- Service `preview_settings_events_subscriber` (`PreviewSettingsEventsSubscriber`, event_subscriber) injects preview state into Smart Content decision JS settings so selected segments evaluate as matched.
- No routes/permissions of its own.

Security: preview state affects only which client-side variation renders for the viewer (self-scoped); it does not bypass server-side access control. No verified finding. (Confirm production visibility of preview controls during review.)
