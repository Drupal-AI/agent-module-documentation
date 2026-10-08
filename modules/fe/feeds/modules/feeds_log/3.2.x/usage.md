Feeds Log is a submodule of Feeds that records detailed, per-item reports of every import so you can see exactly what was fetched, parsed, and which entities were created, updated, deleted, or failed.

---

Feeds Log subscribes to Feeds' `REPORT` and stage events and writes an `feeds_import_log`
content entity for each import run, backed by a Views-driven report at
`/admin/content/feed` (view `feeds_import_logs`). For every import it stores the raw fetched
source data and each processed item as files on the filesystem (by default under
`private://feeds/logs/<import_id>/source/` and `.../items/`), plus per-item log messages in the
database. Logging can be enabled globally, per feed type (via a third-party setting on the feed
type), or per individual feed. Because it captures a lot of data, it includes a **stampede**
guard (max logs per feed within a time window) and an **age limit** to prune old logs. Settings
live in `feeds_log.settings` (route `feeds_log.settings`, `/admin/config/content/feeds_log`).
Access is gated by its own permission on top of the user's Feeds view access. It depends on
core Views and the parent Feeds module.

---

- See which source data was used for a specific import.
- Inspect how each source item looked after parsing.
- Find out which entities were created during an import.
- Find out which entities were updated during an import.
- Track which entities were deleted or cleaned by an import.
- Diagnose which items failed to import and why.
- Audit imports for compliance or data-provenance requirements.
- Debug a misconfigured field mapping by reading logged item data.
- Compare a run's parsed items against the original fetched file.
- Enable detailed logging for just one problematic feed type.
- Enable logging per individual feed for targeted troubleshooting.
- Turn logging off globally to save disk once debugging is done.
- Limit how long import logs are kept with an age limit.
- Prevent log overload from frequent imports with the stampede guard.
- Store fetched source files under a private stream for later review.
- Browse all import runs in a Views-based report page.
- Download the exact payload that produced a given entity.
- Verify a scheduled/cron import actually ran and what it changed.
- Provide editors visibility into their own feed imports.
- Investigate intermittent import errors across multiple runs.
- Keep an audit trail of remote data ingested into the site.
- Confirm expire/clean behaviour removed the right items.
