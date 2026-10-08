<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Event flow

`VisitAnalyticsSubscriber::onVisit` subscribes to `\Drupal\shorturl\Event\ShortUrlVisitEvent` (priority 10).

- Skips when `ServerSideEventSender::isOptedOut($request)`.
- Reads event name from config `pianoanalytics_shorturl.settings:event_name` (default `page.display`).
- Builds PA properties from the event fields: `page` (slug or path), `page_chapter1='shorturl'`, `src='server'`, `shorturl_destination`, `shorturl_referrer`, optional `shorturl_langcode`, `shorturl_domain`.
- Calls `ServerSideEventSender::queueEvent($name,$properties, resolveVisitorId($request), extractBrowserHeaders($request))`; `pianoanalytics_server` dispatches during `kernel.terminate`.

No routes/permissions; configure PA credentials in `pianoanalytics_server`.
