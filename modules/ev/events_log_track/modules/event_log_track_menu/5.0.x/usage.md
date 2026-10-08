Enables menu tracking for Events Log Track: creating, editing, or deleting custom menus and menu links appears in the audit report with type `menu`.

---

`EventLogTrackMenuHooks` registers the `menu` handler and records events two ways. Menu config entities and menu-link content entities are logged through `hook_menu_*` and `hook_menu_link_content_*` (description `"<label> (<id>)"` for menus, `"<bundle>: <title>"` for links). In addition, the handler declares the menu-link add/delete form ids and a `form_submit_callback`, so the parent's form-alter dispatch calls `EventLogTrackMenuHooks::formSubmit()` to emit richer `link insert`/`link update`/`link delete` entries that include the link title, URI, id, and parent-menu name. All entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission.

---

- Audit creation of new custom menus.
- Track edits to menu labels and settings.
- See who added, moved, or removed a menu link.
- Record the URL/path of each affected menu link.
- Filter the audit report to only `menu` events.
- Distinguish menu-level from link-level operations by operation label.
- Trace a menu link's history by its id (`ref_numeric`).
- Detect unauthorized navigation changes.
- Investigate broken navigation after an edit.
- Correlate menu changes with the acting user and IP.
- Demonstrate governance over site navigation.
- Prune old menu-change records via cron retention.
- Exclude specific menus using skip patterns.
- Export a report of navigation changes over a period.
- Identify links added then quickly deleted.
