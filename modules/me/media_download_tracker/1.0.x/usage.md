Media Download Tracker logs every media file download that goes through the Media Entity Download route (`/media/{media}/download`), writing one row per download to a dedicated database table and exposing that data to Views. Requires the Media Entity Download module.

---

The module registers a single kernel `REQUEST` event subscriber. On every request it checks whether the matched route is `media_entity_download.download`; if so it reads the media entity id from the route, the full request URI, the `Referer` header, the client IP, the current user id and the request time, and inserts one row into its own `media_download_tracker` table. There is no counter on the media entity and no aggregation at write time — each download is a discrete log record. Reporting is handled entirely through Views: the module implements `hook_views_data()` to expose the log table as a Views base table (fields id, media_id, timestamp, uid, requested_url, referrer, ip_address, plus relationships to the media and user entities) and ships an install-time view (`media_download_tracker`) with two admin report pages under Reports — a detailed download log at `/admin/reports/media-entity-downloads` and an aggregated per-media download count at `/admin/reports/media-entity-downloads/count`. The bundled view is restricted to the administrator role and is meant to be cloned or edited to suit the site. The module declares no permissions of its own, no config form, no Drush commands, and no config schema; access to the reports is governed by the view's own access settings, and the download event itself is gated by Media Entity Download's `download media` permission and media view access.

---

- Record who downloaded which media file, and when, across the whole site.
- Build a downloads report over time using the shipped log view at `/admin/reports/media-entity-downloads`.
- See total downloads per media item via the aggregated count view at `/admin/reports/media-entity-downloads/count`.
- Track download activity for gated/paywalled documents delivered through Media Entity Download.
- Identify your most-downloaded assets (PDFs, brochures, datasheets, forms).
- Attribute downloads to specific authenticated users via the user relationship.
- Distinguish anonymous downloads (uid 0) from logged-in user downloads.
- Capture the referrer of each download to learn which pages drive downloads.
- Log the client IP address of each download for auditing or geographic analysis.
- Filter download logs by date range using the exposed timestamp filter.
- Filter by media id, user id, requested URL, referrer, or IP via Views filters.
- Add a media-name column to reports by using the built-in media relationship.
- Add a username column to reports by using the built-in user relationship.
- Export download logs to CSV with a Views data export display for external analysis.
- Feed download data into custom dashboards or blocks by adding Views displays on the base table.
- Measure download trends before and after a marketing campaign.
- Detect unusually high download volume from a single IP or user.
- Report downloads per media type or bundle by joining through the media relationship.
- Provide editors a report of how often their published files are downloaded.
- Archive a historical record of file access that persists independently of the media entity.
- Combine with the media entity's own fields (author, created date, tags) through the relationship for richer reports.
- Schedule periodic review of top downloads for content-strategy decisions.
- Support compliance/record-keeping needs that require a log of file access requests.
