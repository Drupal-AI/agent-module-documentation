Submodule of Simple XML Sitemap that automatically submits your sitemaps to search engines and pings IndexNow-compatible engines whenever site content changes.

---

`simple_sitemap_engines` adds two capabilities on top of Simple XML Sitemap. First, it periodically submits your generated sitemap URLs to configured search engines (Bing, Yandex, Seznam, Naver, Yep and others) on a configurable interval via cron. Second, it supports the IndexNow protocol, notifying compatible engines about individual entity insertions, updates and deletions so new or changed pages are discovered quickly. Search engines are stored as `simple_sitemap_engine` config entities and managed at Admin → Configuration → Search and metadata → Simple XML Sitemap → Search engines. IndexNow uses a verification key exposed at a generated route, and can optionally fire on entity form save (gated by a permission). Submission timing is throttled by a `submission_interval` setting to avoid over-pinging. It integrates through cron, entity hooks and a queue worker, requiring no code to operate.

---

- Automatically submit `/sitemap.xml` to Bing on a schedule.
- Ping Yandex, Seznam, Naver or Yep with your sitemap URL.
- Notify IndexNow-compatible engines when a node is published.
- Send IndexNow change notices when an entity is updated.
- Send IndexNow delete notices when content is removed.
- Throttle submissions with a configurable interval (hours).
- Enable/disable individual search engines as config entities.
- Choose a preferred engine for IndexNow key verification.
- Let editors opt a single entity into IndexNow on save.
- Restrict per-save IndexNow notices with the `index entity on save` permission.
- Serve an IndexNow verification key file at a generated route.
- Add a custom search engine endpoint as a config entity.
- Speed up indexing of time-sensitive news content.
- Reduce manual sitemap resubmission in webmaster consoles.
- Keep multiple search engines in sync automatically via cron.
- Export search-engine submission settings between environments.
- Monitor submission status on the engines status page.
- Combine scheduled sitemap pings with real-time IndexNow updates.
- Ensure new landing pages are crawled shortly after launch.
- Disable submissions temporarily by toggling the `enabled` setting.
