<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Piano Analytics Short URL sends Piano Analytics (PA) server-side events for short URL visits.

---

An event subscriber (`VisitAnalyticsSubscriber`) listens for the `shorturl` module's `ShortUrlVisitEvent` and, unless the visitor has opted out, queues a PA event through `pianoanalytics_server`'s `ServerSideEventSender::queueEvent()`; the server module then dispatches it during `kernel.terminate`. The event name is configurable (default `page.display`) and the payload carries the short URL slug, destination, referrer, language and domain as PA properties, along with a resolved visitor ID and extracted browser headers. A config subscriber and form hooks integrate the settings with the PA configuration.

This lets you measure short-link traffic in Piano Analytics server-side — capturing visits even when client-side JS trackers are blocked, and enriching each hit with the short URL's destination and referrer. It has no routes or permissions of its own; it is a bridge that reacts to short-URL visit events. Typical setup: install `shorturl` and `pianoanalytics_server`, configure PA credentials in the server module, then set the desired event name for short-URL visits.

---
- Track short-URL visits in Piano Analytics
- Send server-side PA events (resilient to ad blockers)
- Record the destination of each short link
- Capture the referrer for short-URL hits
- Include language and domain in analytics properties
- Set a custom PA event name for visits
- Respect visitor opt-out before sending events
- Resolve a stable visitor ID for PA
- Forward browser headers to Piano Analytics
- Defer sending until kernel.terminate for performance
- Measure campaign short-link performance
- Attribute traffic to specific short URLs
- Bridge shorturl visits into an existing PA setup
- Enrich analytics with slug-level detail
- Report short-link engagement centrally
