<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Manager prunes old entity revisions across all revisionable content entity types (nodes, media, taxonomy terms, block content, menu links, groups, and more) using pluggable retention rules — keep a minimum count and/or delete revisions older than an age — configured per entity type and overridable per bundle.

---

The module discovers every supported entity type (content entity, changed-tracking,
revisionable, with a canonical link) and lets you enable revision management for it on the
settings form at `/admin/config/content/revision-manager` (route `revision_manager.settings`,
permission `administer revision_manager`). Retention logic lives in **RevisionManager plugins**
(`@RevisionManager` annotation, manager `plugin.manager.revision_manager`): the shipped `amount`
plugin keeps a minimum number of revisions, and `age` deletes revisions older than a chosen
number of months. Defaults are stored per entity type in `revision_manager.settings`
(`enabled_entities`, `defaults`); a bundle can override them via a third-party setting
(`node.type.*`, `media.type.*`, etc. `third_party.revision_manager`) added to the bundle edit
form. When both `amount` and `age` are enabled, deletion is **conservative** — a revision is
removed only if *every* enabled plugin independently flags it (the current and forward
revisions are always preserved, and multilingual/translation-affected revisions are handled per
language). Cleanup is queue-based: entities are enqueued (automatically when updated, unless
`disable_automatic_queueing` is set, or on demand) into the `remove_revisions` queue and
processed by a queue worker; the Drush command **`rm:queue`** batch-enqueues all enabled
entities. Optional `verbose_log` records deletions to watchdog. Config schema covers the
settings object and each plugin's settings (`revision_manager.plugin.settings.age|amount`).

---

- Automatically cap the number of stored revisions per content type (keep the newest N).
- Delete node revisions older than a set age (e.g. 6 months) to reclaim database space.
- Apply revision retention to media, taxonomy terms, block content, menu links, and groups — not just nodes.
- Combine "keep 5" and "older than 6 months" so only revisions both rules agree on are deleted.
- Override the site-wide policy for a specific bundle on its edit form (third-party setting).
- Keep unlimited revisions on important bundles while pruning noisy ones.
- Always preserve the current (and forward/pending) revision when pruning.
- Handle multilingual entities correctly, pruning per translation-affected language.
- Trigger an immediate cleanup batch from the settings form ("Enqueue enabled entities now").
- Run `drush rm:queue` from cron or CI to enqueue all enabled entities for cleanup.
- Disable automatic queue-on-save and rely solely on scheduled `rm:queue` runs.
- Log every revision deletion to watchdog for auditing (`verbose_log`).
- Migrate off Node Revision Delete to a solution covering all entity types.
- Prevent revision tables from growing unbounded on high-edit sites.
- Enforce a compliance policy that limits how long historical revisions are retained.
- Keep a minimum revision history for rollback while trimming the rest.
- Enable revision management only for chosen entity types, leaving others untouched.
- Write a custom retention plugin (implement the RevisionManager plugin interface) for bespoke rules.
- Process large revision sets safely (chunked queries avoid loading all revisions at once).
- Gate who can configure retention with the `administer revision_manager` permission.
- Tune per-entity-type defaults (Amount count, Age months) from one admin screen.
- Reduce backup size and speed up DB operations by removing stale revisions.
- Schedule conservative pruning that never deletes a revision unless all criteria agree.
