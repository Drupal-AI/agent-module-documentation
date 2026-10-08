<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Brightcove Extras is an umbrella of complementary utilities for the Brightcove video module, providing a shared `BrightcoveEmbedUrl` helper and four focused submodules.

The base module carries no hard runtime dependency; each submodule declares its own. `brightcove_extras_player` renders a Brightcove embed URL as a responsive in-page video.js player instead of an iframe (via a field formatter + SDC component). `brightcove_extras_ga4` pushes GA4 video-engagement events (video_start/progress/complete) to the dataLayer for those players. `brightcove_extras_admin` adds a Brightcove video overview View (title/ID search) plus a broken-reference report backed by entity_usage. `brightcove_extras_sync` incrementally syncs only videos changed since the last run instead of a full nightly reconcile, with Drush commands. Enable just the pieces you need.

Use it to improve on the stock Brightcove integration with a native player, analytics, admin tooling, and faster incremental syncing.
---
Shared helper plus submodules adding an in-page video.js player, GA4 analytics, admin reports, and incremental sync for Brightcove.
---
- Render Brightcove videos as an in-page video.js player, not an iframe
- Provide a responsive player field formatter
- Emit GA4 video_start / video_progress / video_complete events
- Push video engagement to the dataLayer for analytics
- List all Brightcove videos in an admin View with title/ID search
- Report broken/missing Brightcove video references (entity_usage)
- Sync only videos changed since the last run (incremental)
- Run incremental sync via Drush
- Reduce sync time versus a full nightly reconcile
- Enable only the submodules you need
- Share a single embed-URL helper across submodules
- Track video completion rates in GA4
- Find nodes referencing deleted Brightcove videos
- Configure GA4 event pushing per site
- Improve editor visibility into the Brightcove library
- Replace iframe embeds with a themeable component player
