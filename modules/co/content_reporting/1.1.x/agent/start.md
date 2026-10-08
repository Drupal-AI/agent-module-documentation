<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Reporting (content_reporting) — agent index

First-party engagement analytics for nodes. A client-side tracker (`js/track.js`) POSTs view, click
and time-spent events to backend routes; events are queued and written to two custom tables by cron
queue workers; an admin dashboard reports and exports the aggregates. Version **1.1.0-beta23**,
core `^9 || ^10 || ^11`.

- **Dependencies:** core `node`, `views`. Optional: `eu_cookie_compliance` (GDPR signal),
  `charts` (only for the submodule).
- **Submodule:** `content_reporting_charts` — see
  `../../modules/content_reporting_charts/1.1.x/agent/start.md`.

## What it provides
- **Routes/controllers** (`content_reporting.routing.yml`):
  - `content_reporting.dashboard` → `ContentReportingController::getReport` (`/admin/content-reporting/dashboard`, perm `content reporting view`).
  - `content_reporting.export_to_csv` → `ContentReportingController::exportToCsv` (perm `content reporting view`).
  - `content_reporting.settings` → `ContentReportingSettingsForm` (perm `content reporting admin`).
  - `content_reporting.track_node` (`/track-content`, POST) and `content_reporting.track_interaction`
    (`/track-content/interaction`, POST) → `TrackingController`, perm `access content`.
- **Forms:** `ContentReportingSettingsForm` (config `content_reporting.settings`),
  `ContentReportingFiltersForm` (dashboard filter form).
- **Queue workers** (`src/Plugin/QueueWorker/`): `content_reporting_track_queue`
  (`ContentReportingTrackWorker`) and `content_reporting_interactions_queue`
  (`ContentReportingInteractionWorker`).
- **Tables** (`content_reporting.install`): `content_reporting_reports`,
  `content_reporting_interactions`.
- **Permissions** (`content_reporting.permissions.yml`): `track content views`,
  `content reporting view`, `content reporting admin`.
- **Hooks** (`content_reporting.module`): `hook_preprocess_page` (attaches the tracker to node
  pages), `hook_cron` (deletes report rows older than 30 days), `hook_help`.
- **Library:** `content_reporting/track_node` (jQuery), `content_reporting/content_reporting.styles`.

## Solution docs
- Configuration & tracking modes: `config/settings.md`
- Reporting dashboard, routes & permissions: `reporting/dashboard.md`
- Tracking endpoints & queue pipeline: `api/tracking.md`
