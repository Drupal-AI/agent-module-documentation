<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

## Open the settings form

1. Log in as a user with the **Administer scheduled transitions** permission.
2. Go to **Configuration → Workflow → Scheduled transitions settings**, or
   navigate directly to `/admin/config/workflow/scheduled-transitions`.

## Enable your content types (required)

Scheduled Transitions only appears on entities that are **both** moderated by a
Content Moderation workflow **and** enabled here. On the settings form, tick each
entity type and bundle (for example *Content → Article*) you want to schedule.
Until you do this, no "Scheduled transitions" tab appears anywhere.

## The settings, field by field

- **Enabled bundles** — which moderated entity types/bundles can have scheduled
  transitions (as above).
- **Create queue items on cron** *(on by default)* — when on, Drupal's cron finds
  due transitions and queues them for processing. Leave it on unless you plan to
  process transitions another way.
- **Revision-log message templates** — three templates control the log message
  written when a transition runs: one for transitioning the latest revision, one
  for a historical (non-latest) revision, and one for when a former unpublished
  revision is shifted back on top. They support tokens such as
  `[scheduled-transitions:from-state]` and `[scheduled-transitions:to-state]`.
- **Allow editors to override the message** *(off by default)* — when on, editors
  can replace the default log message per transition on the add form.
- **Mirror operations** — instead of using the dedicated view/add/reschedule
  permissions, you can mirror those checks to another entity operation. By default
  all three mirror the entity's **update** operation, so anyone who can edit the
  content can also schedule transitions for it.
- **Retain processed transitions** *(off by default)* — when off, a transition
  record is deleted once processed. Turn it on to keep processed records for
  auditing, and set a **retention duration** (default 28 days; use `-1` to keep
  them forever).

Click **Save configuration** to apply. Some settings can also be set from Drush,
for example:

```bash
drush config:get scheduled_transitions.settings
drush config:set scheduled_transitions.settings automation.cron_create_queue_items 0 -y
```

## Permissions

Grant permissions at **People → Permissions**:

- **View all scheduled transitions** — see the site-wide listing at
  `/admin/content/scheduled-transitions`.
- **Administer scheduled transitions** *(restricted)* — access this settings form.
- Per-bundle permissions, generated for each enabled moderated bundle:
  - **`view scheduled transitions <type> <bundle>`** — see upcoming transitions on
    that entity type.
  - **`add scheduled transitions <type> <bundle>`** — schedule new transitions.
  - **`reschedule scheduled transitions <type> <bundle>`** — change the date of a
    pending transition.

For example: `drush role:perm:add editor 'add scheduled transitions node article'`.

> If you enabled **Mirror operations** (the default), the three per-bundle checks
> defer to the entity's update permission — so a user who can edit an Article
> effectively gains the add/view/reschedule capability without the explicit
> permissions.

## Processing transitions

Transitions run when they come due, provided cron runs regularly and **Create
queue items on cron** is on. To force due transitions to be queued and processed
immediately, run:

```bash
drush scheduled-transitions:queue-jobs
```

(the alias is `sctr-jobs`).
