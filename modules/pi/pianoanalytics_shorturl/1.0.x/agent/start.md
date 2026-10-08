<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Piano Analytics Short URL (pianoanalytics_shorturl) — agent index

**Queues Piano Analytics server-side events on short URL visits (shorturl → pianoanalytics_server bridge).**

- **Version:** 1.0.x (1.0.0-beta1)
- **Core:** ^10.2 || ^11
- **Dependencies:** pianoanalytics:pianoanalytics_server, shorturl:shorturl
- **Mechanism:** `VisitAnalyticsSubscriber` on `ShortUrlVisitEvent` → `ServerSideEventSender::queueEvent()`; event name from config `pianoanalytics_shorturl.settings` (default `page.display`); honours `ServerSideEventSender::isOptedOut()`.
- **Routes/permissions:** none of its own.

**Security:** No custom routes, permissions or endpoints — a passive event subscriber. Sends slug/destination/referrer/visitor-id to PA only when not opted out. No security findings. See [extend/events.md](extend/events.md)
