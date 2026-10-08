<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Events remove expired cleans up finished events on cron: after a configurable number of days it either unpublishes (archives) or deletes them, in batches, so a what's-on section does not accumulate years of dead listings.

---

The submodule is a settings form plus a cron hook. `localgov_events_remove_expired.settings` holds three values — `action` (`none` by default, or `unpublish` / `delete`), `expire_days` (30) and `items_per_cron` (100) — configured at `/admin/config/content/expired-events` behind the restricted `administer expired events` permission. On each cron run it computes the cut-off as midnight today minus `expire_days`, then queries `localgov_event` nodes whose occurrences all finished before that point, processing at most `items_per_cron` of them. For `delete` it simply calls `$entity->delete()`. For `unpublish` it is content-moderation aware: if `content_moderation` is enabled and the node has a `moderation_state` field it loads the `ContentModerationState`, checks the workflow, and moves the node to the **archived** state; otherwise it falls back to `$entity->setUnpublished()`. It also verifies the `localgov_event` node type still exists and logs an error to its own channel if not. Because the default action is `none`, installing the module changes nothing until an administrator opts in — a deliberate safety default given that one of the options permanently deletes content.

---

- Automatically unpublish events a month after they finish.
- Delete old events to keep the events archive small.
- Archive finished events through a content moderation workflow.
- Keep a what's-on listing free of stale entries without manual tidying.
- Batch the clean-up so cron runs stay fast on large sites.
- Choose a longer retention period for events of record.
- Keep events published indefinitely by leaving the action as none.
- Move events to an archived state rather than deleting them.
- Reduce index size by removing expired events from search.
- Apply a consistent retention policy across a council site.
- Let content owners set the retention period without code.
- Prevent accidental deletion by requiring an explicit opt-in.
- Process a backlog gradually rather than in one destructive sweep.
- Keep recurring events alive until their last occurrence has passed.
- Log a clear error when the event content type is missing.
- Restrict retention configuration to trusted administrators.
- Align event retention with a records-management policy.
- Free up editorial attention from manual archiving.
- Combine with moderation states for an auditable archive.
- Tune batch size to match the site's cron frequency.
