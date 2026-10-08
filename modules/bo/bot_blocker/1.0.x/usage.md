Bot Blocker rejects incoming HTTP requests whose User-Agent contains a banned substring or reports an out-of-date major browser version, answering with a configurable 403 or 410 page before Drupal renders anything.

---

Bot Blocker is a lightweight, dependency-free request filter for Drupal 10/11. A single kernel `REQUEST` event subscriber (`BotBlockerEventSubscriber`, priority 101) inspects the `User-Agent` header of every main request. It blocks the request if the UA contains any configured case-insensitive substring (defaults `Scrapy`, `HTTrack`, `Go-http-client`) or if it identifies as one of six mainstream browser families (Chrome, Firefox, Safari, Edge, Opera, IE) at or below an admin-set minimum major version. Blocked clients receive an admin-authored HTML body with HTTP 403 Forbidden, or optionally HTTP 410 Gone. Users holding the `bypass bot blocker` permission are never blocked. All behavior is driven from one config object, `bot_blocker.settings`, edited at `/admin/config/system/bot-blocker` (guarded by `administer bot blocker`). When a fast cache backend (memcache or redis) is enabled the module also tallies blocked/allowed request counters and records the last blocked request. The maintainer positions this module as a last line of defense — CDN/WAF-layer bot mitigation is preferable where available.

- Block scraping frameworks such as Scrapy, HTTrack, or Go's default `Go-http-client` client by their User-Agent signature.
- Add custom User-Agent substrings (one per line) for other crawlers, SEO tools, or libraries you want to reject.
- Reject clients reporting an obsolete Chrome major version at or below a chosen threshold.
- Reject obsolete Firefox versions to reduce exposure from abandoned automation.
- Block old Safari versions while allowing newer ones (mind OS-pinned Safari caveats).
- Block old Microsoft Edge (Chromium `Edg/`) versions below a set major.
- Block old Opera (`OPR/`) versions below a set major.
- Block Internet Explorer entirely by setting a high IE minimum (IE is deprecated).
- Leave a browser family's minimum blank to skip version checking for that family.
- Serve a custom branded "Access denied" HTML page to blocked clients.
- Return HTTP 410 Gone instead of 403 Forbidden to signal permanent removal to well-behaved crawlers.
- Grant trusted internal tools or monitoring bots the `bypass bot blocker` permission so they are never filtered.
- Restrict who can change filtering rules via the `administer bot blocker` permission.
- Reduce hosting cost and backend load caused by aggressive crawling of expensive pages.
- Complement (not replace) CDN/WAF bot mitigation as a last line of defense at the application layer.
- Track how many requests are blocked vs. allowed when running memcache or redis, for tuning thresholds.
- Inspect the IP, path, and User-Agent of the most recent blocked request (fast-cache backends only) to spot false positives.
- Periodically review site traffic and raise minimum browser versions as older browsers age out.
- Deploy filtering rules across environments by exporting/importing the `bot_blocker.settings` config object.
