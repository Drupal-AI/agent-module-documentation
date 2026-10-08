<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brightcove Extras (brightcove_extras) — agent index

**Shared helper + submodules: in-page video.js player, GA4 analytics, admin reports, and incremental sync for Brightcove.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10.3 || ^11 · **Package:** Brightcove
- **Base:** `BrightcoveEmbedUrl` helper; no hard runtime dependency (submodules declare their own, e.g. brightcove)
- **Submodules:** `brightcove_extras_player` (in-page video.js player formatter + SDC), `brightcove_extras_ga4` (GA4 dataLayer events), `brightcove_extras_admin` (video overview View + broken-reference report, depends entity_usage/views), `brightcove_extras_sync` (incremental sync + Drush)
- **Security:** base module has no routes/permissions; submodule admin/settings routes are permission-gated; sync talks to the Brightcove API via configured credentials. No anonymous mutating endpoints.

See [extend/submodules.md](extend/submodules.md)
