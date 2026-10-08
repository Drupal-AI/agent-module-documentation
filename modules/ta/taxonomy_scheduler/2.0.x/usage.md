<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Scheduler adds scheduled (future-dated) publishing to taxonomy terms, mirroring the way node scheduling works. It adds a datetime field to a chosen vocabulary and, on cron, publishes terms whose scheduled date has arrived. Configured at /admin/config/taxonomy_scheduler under the "administer site configuration" permission.

---

The module lets a site pick a vocabulary and a base publish date, then automatically manages an unpublish/publish lifecycle for terms in that vocabulary. A cron event subscriber scans terms and queues those whose scheduled datetime is due; a presave subscriber and queue worker apply the state change and invalidate the relevant cache tags. It relies on hook_event_dispatcher for its cron/presave hooks and on core taxonomy + datetime.

Use it when editorial teams need terms (campaigns, categories, seasonal tags) to go live at a set time without manual intervention. All configuration is admin-only; there are no public routes and no custom permissions — access is governed by "administer site configuration" on the single settings form.

---

- Schedule taxonomy terms to publish at a future date.
- Add a scheduling datetime field to a chosen vocabulary.
- Auto-publish due terms on cron runs.
- Manage a publish/unpublish lifecycle for terms.
- Mirror node-style scheduling for taxonomy.
- Queue due terms for background processing.
- Invalidate term cache tags when state changes.
- Configure the target vocabulary from the admin form.
- Set a base publish date for scheduling.
- Keep seasonal or campaign tags hidden until launch.
- Avoid manual publishing of terms.
- Drive scheduling through cron, not user action.
- Restrict configuration to site administrators.
- Integrate with hook_event_dispatcher for cron/presave.
- Use core datetime for the schedule field.
- Publish category terms on a marketing timeline.
- Coordinate term visibility with content releases.
- Batch-process large vocabularies via the queue.
