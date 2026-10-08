<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduled Updates changes field values on any entity — node, user, term, file — at a chosen future time: publish at nine on Monday, switch a price on the first of the month, deactivate a user at term end. Updates are themselves entities, so they are listable, reviewable and revisable before they fire, and they run on cron.

---

The mechanism has two moving parts. A **Scheduled Update Type** (`scheduled_update_type`, a config entity that is also the bundle) targets exactly one entity type, declares a **field map** from fields on the update to fields on the target, and picks an **Update Runner** plugin. A **Scheduled Update** (`scheduled_update`, a content entity of that bundle) holds the new field values plus an `update_timestamp`. When cron fires (`hook_cron` -> `UpdateRunnerUtils::runAllUpdates(..., TRUE)`, also runnable manually via the runner form or `drush sup:run`), each type's runner queues the updates whose timestamp has passed and are still un-run, then copies the mapped values onto the target and saves it. There are two families of type. **Embedded** updates live on an entity-reference field added to the target's own add/edit form (via Inline Entity Form) — the `default_embedded` and `latest_revision` runners scan those reference fields for entities carrying ready updates; attaching one therefore requires edit access to the target. **Independent** updates (`default_independent` runner) are created through their own add form where the editor picks target entities by autocomplete; a single update can target many entities. Runner options control what happens after a run (`DELETE`/`ARCHIVE`), what happens to an invalid update (`DELETE`/`REQUEUE`/`ARCHIVE`), whether a new revision is created, and — importantly — which user the update runs *as* (`USER_UPDATE_RUNNER`, `USER_OWNER`, `USER_REVISION_OWNER`, `USER_UPDATE_OWNER`); under cron the runner switches to user 1. The operational reality to plan for is cron: an update fires when cron next runs, not at the configured instant, so a site whose cron runs hourly cannot honour a nine-o'clock embargo to the minute. Requires core `options` and `inline_entity_form`; core requirement `^10.4 || ^11.3 || ^12`. Version 3.0.2.

---

- Publish a node at a set date and time.
- Unpublish a campaign page when it ends.
- Change a commerce/price field on a specific date.
- Embargo a document until an announcement.
- Toggle a promoted or sticky flag on a schedule.
- Deactivate (block) a user account at a future date.
- Grant a role to a group of users at the start of next month.
- Expire a status field on a user account.
- Schedule a taxonomy-term field change.
- Update any field, on any entity type, at a future moment.
- Select many entities and update them all in one independent update.
- Embed publish/unpublish scheduling directly on the node edit form.
- Review or revise a pending update before it fires.
- Let different teams own different update types via per-type permissions.
- Coordinate an editorial content release.
- Automate a seasonal or recurring content change.
- Retire content on a schedule.
- Run updates against the latest revision for moderated (forward-revision) content.
- Choose whether an update creates a new entity revision.
- Run scheduled updates manually or from Drush (`sup:run`) instead of waiting for cron.
- Archive completed updates for an audit trail instead of deleting them.
- Re-queue an update automatically when the target fails validation.
