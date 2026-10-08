<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Scheduler extends scheduled publishing to content-moderation states, so content can be scheduled to move to any moderation state, not just published/unpublished.

---

The Scheduler module handles scheduled publishing and unpublishing, but on a site using content moderation, "published" is only one of several states — Draft, Needs Review, Published, Archived. Scheduling that a piece move to Archived next month, or to Needs Review at a launch time, is not something base scheduled-publish covers. Advanced Scheduler fills that gap: it schedules **moderation-state transitions**, so content can be set to move to any workflow state at a chosen time.

That makes it the scheduling layer for an editorial workflow rather than just a publish switch — an embargo that flips a story to Published at 9am, an automatic archive of time-limited content, a staged review deadline. It works with content moderation's states and transitions.

The security-relevant point is that a scheduled transition **executes a state change automatically**, so it must respect the workflow's integrity: the scheduling should not become a way to bypass transition permissions or moderation controls. Confirm that scheduled transitions honour the workflow — that scheduling a move to Published is governed the same way a manual move is — and restrict who can set schedules, since a scheduled transition is an action that will run without a person present to authorise it at the moment it fires.

---

- Schedule a moderation-state change.
- Move content to any state on a schedule.
- Schedule an archive.
- Embargo a story to Published.
- Schedule Needs Review at launch.
- Extend Scheduler to workflows.
- Automate a state transition.
- Schedule content moderation.
- Archive time-limited content.
- Set a staged review deadline.
- Schedule beyond publish/unpublish.
- Flip a story to Published at a time.
- Respect workflow integrity.
- Restrict who can schedule.
- Honour transition permissions.
- Automate editorial timing.
- Schedule a workflow move.
- Publish on embargo.
- Auto-archive old content.
- Plan content transitions.