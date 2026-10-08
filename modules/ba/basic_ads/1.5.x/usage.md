Basic Ads is a core-only advertisement manager: image/link ads placed by taxonomy placement, rotated with weighted random selection, and reported with impression/click/CTR tracking.

---

Basic Ads models each advertisement as a `basic_ad` node (image + optional link + one or more placement terms + optional start/end dates + a weight). Placements are terms in a `basic_ad_placement` vocabulary. You display ads by placing the "Basic Ad block (by placement)" block and choosing a placement term and how many ads to show. The block renders only a cacheable placeholder; the real ad HTML is fetched client-side from an uncacheable `/ad/fragment/{term}` endpoint, so the host page stays fully cached (Drupal, nginx, or CDN) while a fresh weighted-random ad is picked on every view. Impressions are recorded client-side (`/ad/view/{nid}`), clicks server-side through a tracked redirect (`/ad/click/{nid}`); IPs are anonymized before storage and rows older than a year are pruned by cron. Cron also unpublishes ads past their end date. Admins get a statistics dashboard (impressions, clicks, CTR — overall, 7/30-day, today, and by placement) and can exclude chosen roles from tracking. Everything is built on core node, taxonomy, datetime, image, link, views, and block — no external services.

---

- Run a rotating banner in a theme region (header, sidebar, footer) without a third-party ad server.
- Serve house ads on a fully page-cached site — the async fragment keeps ads rotating while the page is cached.
- Show a single sidebar promo by placing one block on a placement term.
- Rotate several eligible ads in one slot by setting "Number of ads to display" (1–50) on the block.
- Prioritize a campaign over others by giving it a lower weight (each 10 weight units roughly doubles/halves relative odds).
- Give all ads equal exposure by leaving weights at 0 (uniform random selection).
- Schedule an ad to go live on a future date via the Start Date field.
- Auto-expire a campaign by setting an End Date; cron unpublishes it after that day.
- Link an ad image to a landing page and count the click via the `/ad/click` redirect endpoint.
- Show a non-clickable brand image by leaving the link field empty.
- Add custom placement zones (e.g. "Article Inline") by adding terms to the Basic Ad Placement vocabulary.
- Report campaign performance to stakeholders with the impressions/clicks/CTR dashboard at /admin/reports/ad-stats.
- Drill into one ad's performance over today / 7 days / 30 days / all time.
- Compare how the same ad performs across different placements (per-placement stats table).
- Exclude editor/admin roles from tracking so internal traffic doesn't inflate impression and click counts.
- Keep analytics GDPR-friendlier by relying on the built-in IPv4/IPv6 anonymization.
- Cap data retention automatically — tracking rows older than one year are pruned on cron.
- Restrict who can create or edit ads using the standard `basic_ad` node permissions.
- Theme the ad markup by overriding `node--basic-ad.html.twig` or the ad image formatter template.
- Localize placement names and ad content using core translation on the terms and nodes.
- Serve ads only within a date window on Views-driven listings (the module's Views query alter enforces the schedule).
- Add a "Number of ads" A/B rotation by placing multiple placement blocks in different regions.
