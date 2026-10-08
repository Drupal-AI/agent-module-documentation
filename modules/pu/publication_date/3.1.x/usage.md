Publication Date adds a `published_at` timestamp base field to every node that records when the node was *first* published, independent of the mutable `created` and `changed` dates.

---

The module implements `hook_entity_base_field_info()` to attach a revisionable, translatable `published_at` base field (a `no_ui` field type extending core `TimestampItem`) to the node entity type. The value stays empty (`NULL`) while a node is unpublished and is stamped with the current request time the first time the node is saved in a published state; from then on it is not overwritten, so it reliably captures the original go-live moment even if the node is later edited, unpublished, or re-published. Editors with permission see a "Published on" datetime widget grouped under *Authoring/revision information* on the node form (leave it blank to use the submission time, or set it to back-date/forward-date the record). A computed `published_at_or_now` property returns the stored timestamp, or the current time when none is set yet, so display code always has a value to format. The field can be shown with core's `timestamp` and `timestamp_ago` formatters (the module registers `published_at` with both), and a `[node:published]` token (plus date sub-tokens like `[node:published:custom:Y-m-d]`) is exposed for use in patterns and templates. Access is governed by granular permissions — global "any type" permissions plus generated per-content-type "set/view" permissions. On install it back-fills existing nodes by deriving each one's publication date from its first published revision (MySQL/MariaDB and PostgreSQL only). It also integrates with Feeds (a `published_at` import target), Workbench Moderation (stamps the date on the publish transition), and Node Clone (resets the date on cloned nodes).

---

- Show a stable "Originally published on" date on articles and blog posts that does not change when the content is edited.
- Distinguish the first-published date from the last-updated (`changed`) date in listings and bylines.
- Sort or filter a Views listing by true publication date rather than node creation date.
- Back-date imported/migrated content so historical articles show their real original publish date.
- Forward-date a node's publication record to a specific launch date while publishing manually.
- Expose `[node:published]` in a metatag or pattern (e.g. an `article:published_time` Open Graph tag).
- Feed the publication date into an XML sitemap or RSS `pubDate` via tokens.
- Display a human-friendly "published 3 days ago" using the `timestamp_ago` formatter on the field.
- Keep an accurate publication timestamp across unpublish/re-publish cycles for editorial workflows.
- Record go-live time automatically for content published by the Scheduler module (runs after Scheduler by weight).
- Stamp publication date on Workbench Moderation state transitions to a published state.
- Import a publication date column from a CSV/RSS source using the Feeds `published_at` target.
- Reset the publication date automatically when duplicating content with Node Clone / Quick Node Clone.
- Grant only certain roles the ability to change the "Published on" date via per-content-type permissions.
- Let some roles view but not edit the publication date (read-only widget) for auditing.
- Compute time-since-publication for "new" badges or embargo logic using `published_at_or_now`.
- Build "on this day" or anniversary content blocks keyed off the original publication timestamp.
- Provide a reliable publication timestamp to decoupled/JSON:API consumers as a node field.
- Report on publishing cadence (articles per month) using the true first-published date.
- Preserve original publication dates when moving content between environments (field is revisionable).
- Order a "latest articles" block by publication date while editors continue to tweak older posts.
- Populate a citation or academic "date published" field from node content.
- Set a canonical publication date for translated nodes independently per language (field is translatable).
- Drive cache/freshness rules that depend on when a node actually went live rather than when it was created.
- Show publication date only to editors by restricting the view permission to specific roles.
