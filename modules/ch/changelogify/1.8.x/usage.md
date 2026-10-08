Changelogify automatically records site change events, groups them into structured, workflow-driven Release entities, and publishes them as a themeable public changelog with RSS/Atom feeds and a read-only JSON API.

---

Changelogify captures events from content, module/theme, user, and config-import sources into a `changelogify_event` content entity, then lets editors generate `changelogify_release` entities that bucket the changes into Keep-a-Changelog sections (Added, Changed, Fixed, Removed, Security, Other). Releases move through a private draft → review → published → archived editorial workflow (permission-gated), carry revisions and translations, and publish at a configurable path (default `/changelog`) with stable public slugs, slug-history redirects, RSS/Atom feeds, a versioned JSON API, and two display blocks. Capture is privacy-first: per-entity-type/bundle content-capture policy, optional unpublished tracking, and event/provenance retention windows. The optional `changelogify_ai` submodule adds evidence-backed, bring-your-own-key AI drafting via the Drupal AI module. It requires Drupal core `content_translation`, `language`, `node`, `options`, and `user`, PHP 8.1+, and no external libraries.

---

- Maintain a public product changelog at `/changelog` that updates as you ship.
- Automatically track node create/update/delete events for release notes.
- Track module/theme install/uninstall events as site changes.
- Track user account and role changes when enabled.
- Correlate configuration-import changes with a release window.
- Generate a draft release from a date range or "since last release."
- Group raw events into Added/Changed/Fixed/Removed/Security/Other sections.
- Edit and reorder release-note items before publishing.
- Run releases through a draft → ready-for-review → published → archived workflow.
- Restrict who can create, submit, publish, or archive releases via granular permissions.
- Keep full revision history of each release and revert to prior wording.
- Translate releases per language with a configurable missing-translation fallback (hide/fallback/label).
- Serve an RSS 2.0 feed at `/changelog/feed.rss` for changelog subscribers.
- Serve an Atom 1.0 feed at `/changelog/feed.atom`.
- Expose a stable read-only JSON API at `/changelog/api/v1/releases` (and `/{slug}`) for external sites.
- Publish releases on a schedule via cron using an approved revision.
- Place a "Latest release" block or "Recent releases" block in any region.
- Serve maintenance reports to agency clients ("what we did this month").
- Give internal staff an intranet feed of system updates.
- Change the public changelog base path from `/changelog` to a custom URL.
- Auto-generate SEO-friendly public slugs from release titles, preserving old slugs as redirects.
- Purge old events and provenance automatically on a retention schedule.
- Inspect the source evidence (provenance) behind each generated release.
- Explore captured raw events in an admin Event Explorer with filters.
- Extend event capture with custom tagged event-source services.
- Draft clearer release notes with optional AI assistance (via the changelogify_ai submodule).
