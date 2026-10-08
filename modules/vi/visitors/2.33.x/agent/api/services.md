<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & tracking pipeline

All services are defined in `visitors.services.yml` (interfaces in `src/Visitors*Interface.php`).

## Tracking flow

1. `visitors.page_attachments` (`PageAttachmentsService`) attaches the JS tracker to pages
   (respecting `script_type` and `disable_tracking`).
2. The tracker posts to `/visitors/_track` (`Visitors::track`, open access, GET/POST).
3. `visitors.visibility` (`VisibilityService`) decides whether this request is tracked (path /
   role / account rules from `visitors.config.visibility`).
4. `visitors.tracker` (`TrackerService`) writes the visit to the `visitors` log table.

## Key services

| Service id | Class | Purpose |
|---|---|---|
| `visitors.tracker` | `TrackerService` | Record a visit to the log. |
| `visitors.visibility` | `VisibilityService` | Should this request be tracked? |
| `visitors.report` | `ReportService` | Build report data from the log. |
| `visitors.counter` | `CounterService` | Per-entity hit counter (`counter.*` config). |
| `visitors.device` | `DeviceService` | Device/browser/OS via matomo/device-detector. |
| `visitors.location` | `LocationService` | Geolocation (with visitors_geoip). |
| `visitors.online` | `OnlineService` | Who is online now. |
| `visitors.cron` | `CronService` | Prune old logs on cron. |
| `visitors.date_range` | `DateRangeService` | Report date filtering. |
| `visitors.rebuild.route` | `RebuildRouteService` | Recompute route data. |
| `visitors.rebuild.ip_address` | `RebuildIpAddressService` | Recompute IP data. |
| `visitors.cookie` | `CookieService` | Tracking cookie handling. |

`visitors.negotiator` (`VisitorThemeNegotiator`) renders report pages in the configured `theme`.
