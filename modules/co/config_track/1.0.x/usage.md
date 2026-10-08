<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Track records every configuration change on a site as a revision, giving a searchable history of what config changed, when, and by whom.

---

Drupal's active configuration has no built-in history: a view stops returning results, a permission goes missing, a field display changes, and the site itself cannot answer "what changed and when". On projects that keep configuration in version control the answer lives in git; on the many sites where configuration is edited directly in production, there is no answer at all. Config Track fills that gap by turning every config write into a revision.

It works entirely from the event and hook layer. A ConfigTrackSubscriber listens to core's config SAVE/DELETE/RENAME events for simple configuration (and to language config-override save/delete events when the language module is present), while a decorated module handler forces the module's entity presave/predelete hooks to run first and last around all other modules so config-entity changes are captured in their true order. Changes are buffered per request and written to a dedicated config_track database table on kernel terminate / shutdown, together with the acting user's uid and the request timestamp; empty diffs (a re-save that changed nothing) are skipped. A UI at /config-revisions lists recent revisions with a pager and links each to a rendered diff against the previous revision of the same config object. The whole report is gated by the core "administer site configuration" permission, and access to config history should be treated as a deliberate decision because configuration can hold sensitive values. There are no module settings and nothing to configure. Note that revisions accumulate: on an active site config changes are small but constant, so plan for table growth and pruning over time.

---

- Answer "what configuration changed and when?" from inside the site.
- See who (which user) triggered a given configuration change.
- Investigate a view that suddenly stopped returning results.
- Track permission and role changes over time.
- Audit configuration edits on a site with several administrators.
- Get a change history on a site where config is edited in production, not exported.
- Compare a configuration object against its previous revision via a rendered diff.
- Capture changes to simple configuration (system settings, third-party settings).
- Capture changes to config entities (views, fields, image styles, roles).
- Record configuration renames and deletions, not just edits.
- Track per-language configuration overrides when the language module is enabled.
- Preserve the exact order of a burst of related config changes in one request.
- Establish a baseline snapshot of all existing config at install time.
- Support a change-control / accountability process for site builders.
- Explain an unexplained setting change after the fact.
- Complement (not replace) exported configuration and git-based deployment.
- Detect config drift introduced by module installs or updates.
- Review recent config activity from the Administration > Configuration > Development menu.
- Restrict configuration-history visibility to trusted administrators.
- Plan storage and pruning for a long-lived revision table.
