# Configuration

Setting up Scheduler is a two-part job:

1. **The module settings page** controls how the date/time inputs behave and lets
   you run Scheduler's own lightweight cron. These settings apply site-wide.
2. **Per content type**, you switch scheduled publishing/unpublishing on or off.
   This is what actually adds the **Publish on** / **Unpublish on** fields to the
   add/edit form.

The two parts are covered in turn below.

## Part 1 — The module settings page

### Open the settings page

1. Go to **Configuration → Content authoring → Scheduler**
   (`/admin/config/content/scheduler`).
2. You land on the **Settings** tab.

![The Scheduler settings page](../images/settings.png)

As the page explains, **most Scheduler options are set independently for each
entity type and bundle** — those live on the content type's own edit form
(Part 2 below). The **Entity Types** drop-button near the top is a shortcut to
jump straight to a specific type's settings. The options directly on this page are
common to *all* entity types:

- **Date only** — *"Allow users to enter only a date and provide a default
  time."* Tick this if you want editors to be able to type just a date, with the
  time filled in automatically. When only a date is entered, the time defaults to
  a specified value, but the editor can still change it if needed.
- **Time settings** — *"Hide the seconds."* Tick this to show only hours and
  minutes in the time input field, leaving seconds off.

3. Adjust the checkboxes as you like and click **Save configuration**.

### The Lightweight cron tab

Scheduler normally processes due content on Drupal's regular cron run. If you
need scheduled changes to happen more promptly than your full site cron allows,
switch to the **Lightweight cron** tab (at the top of the settings page). This
gives you a way to run *only* Scheduler's processing — via a URL you can call
from an external scheduler or webcron on a tight interval (for example every
minute), or via the `drush scheduler:cron` command in a custom cron job.

## Part 2 — Enable scheduling for a content type

Scheduling is **opt-in per content type** — you might schedule Articles but leave
Basic pages untouched. Here is how to turn it on for one type:

1. Go to **Structure → Content types** (`/admin/structure/types`).
2. Click **Edit** on the content type you want to schedule (for example
   *Article*).
3. On the type's edit form, open the **Scheduler** vertical tab (in the list of
   settings tabs on the left of the form).
4. Tick **Enable scheduled publishing for this content type** to add the
   **Publish on** field, and/or **Enable scheduled unpublishing for this content
   type** to add the **Unpublish on** field. You can enable either one or both.
5. *(Optional)* Once a field is enabled, you can choose to **require** a date —
   for example, require an unpublish date so no time-limited content is ever left
   live indefinitely, or require a publish date on a workflow where nothing goes
   out immediately.
6. Click **Save content type**.

### What this changes

Enabling scheduling adds the **Publish on** and/or **Unpublish on** date/time
fields to that content type's add and edit form. From then on, when an editor
creates or edits a piece of that content, they can set a future date and time:

- **Publish on** — the content stays unpublished until this moment, then the next
  cron run after that time publishes it automatically.
- **Unpublish on** — the content is taken offline automatically by the next cron
  run after this time.

Because the action happens on cron, remember that its promptness depends on how
often cron runs (see [Installation](../installation/index.md)).
