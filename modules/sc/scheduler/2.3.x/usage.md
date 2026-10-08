Scheduler lets editors set a future date and time at which a piece of content (or other supported entity) is automatically published, and/or a later date at which it is automatically unpublished, driven by Drupal cron.

---

Scheduler adds two optional date/time fields — **Publish on** and **Unpublish on** — to the add/edit form of any enabled entity bundle, and processes them on every cron run (or via its own lightweight cron). Support is enabled per entity type and per bundle through third-party settings stored on the bundle config entity, so you might schedule Articles but not Pages. A site-wide settings form at Admin → Configuration → Content authoring → Scheduler controls default behaviour: the date/time format, a default time for date-only input, whether to allow past dates, whether to create new revisions on publish/unpublish, and logging. Out of the box it supports core Nodes, and via bundled plugins it also handles Media, Taxonomy terms and Commerce products; new entity types are added by writing a `SchedulerPlugin` plugin. When cron runs, the `scheduler.manager` service selects entities whose scheduled time has passed, dispatches events and invokes hooks so other modules can allow, deny or customise each action, then publishes or unpublishes them using the standard entity actions. A separate "lightweight cron" route and Drush command let you run only Scheduler's processing on a tighter schedule than full site cron. Permissions gate who may set scheduling dates and who may view the list of scheduled content, generated dynamically for each supported entity type. It integrates with Views (providing "scheduled content" listings), Rules (via the sub-module), Devel Generate and Content Moderation.

---

- Publish a news article at 9am on launch day without anyone being online.
- Automatically unpublish a job posting once the vacancy closes.
- Set an embargo date so an announcement goes live only at a fixed time.
- Take a promotional banner node offline automatically after a sale ends.
- Schedule a Media item (e.g. a video) to appear at a release time.
- Publish a Taxonomy term / landing section at a planned date.
- Schedule a Commerce product to go on sale at midnight.
- Require an unpublish date on time-limited content so nothing is left live indefinitely.
- Require a publish date on a workflow where nothing is published immediately.
- Enable scheduling for Articles but leave Basic pages unaffected.
- Give editors a vertical-tab or fieldset on the edit form for the two date fields.
- Set a default publish time (e.g. 00:00) and let editors enter a date only.
- Allow publishing with a past date to immediately publish on save.
- Create a new revision each time content is published or unpublished, for an audit trail.
- Run a "lightweight cron" every minute via a URL so scheduled changes happen promptly.
- Trigger scheduled processing from Drush (`drush scheduler:cron`) in a custom cron job.
- View a list of all upcoming scheduled content via the provided View.
- Restrict who can set scheduling dates using the per-type "schedule publishing" permission.
- Prevent publication until an approval field is set, using `hook_scheduler_publishing_allowed()`.
- Add extra entity ids into a cron run with `hook_scheduler_list_alter()`.
- React to publish/unpublish in code by subscribing to Scheduler events.
- Integrate with Content Moderation so scheduling changes a moderation state instead of the status flag.
- Build Rules reactions on scheduled publishing/unpublishing via the Rules integration sub-module.
- Bulk-generate scheduled test content with Devel Generate.
- Add Scheduler support to a custom entity type by writing a `SchedulerPlugin` plugin.
- Migrate legacy scheduled dates into `publish_on`/`unpublish_on` fields.
- Keep entity creation time in step with the scheduled publish time (publish touch).
- Hide the publish/unpublish date fields conditionally from certain users via a hook.
