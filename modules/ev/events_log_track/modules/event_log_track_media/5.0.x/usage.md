Enables media-entity tracking for Events Log Track: media create/update/delete operations appear in the audit report with type `media`, including the media name, bundle, and revision log message.

---

`EventLogTrackMediaHooks` registers the `media` handler (operations insert/update/delete) and implements the three `media` entity hooks; each records the media name, bundle, and (when present) revision log message in the description, the media id in `ref_numeric`, and the label in `ref_char`, writing through the parent `event_log_track.manager` service. A separate `EventLogTrackMediaViewsHooks` adds the `elt_media_join` Views relationship so reports can join the logged media by id. Filtering, retention, and the `access event log track` permission are inherited from the parent.

---

- Audit media creation across all media types.
- Track edits to media items, including revision notes.
- See who deleted a media asset.
- Filter the audit report to only `media` events.
- Distinguish media insert vs update vs delete.
- Trace a media item's history by its id (`ref_numeric`).
- Build a Views report joining media events to the media entity.
- Detect unauthorized removal of images or videos.
- Correlate media changes with the acting user and IP.
- Demonstrate accountability for the media library.
- Prune old media-change records via cron retention.
- Exclude specific media names using skip patterns.
- Export a report of media activity over a period.
- Combine with file tracking for complete asset auditing.
- Identify media published then quickly changed.
