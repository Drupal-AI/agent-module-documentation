# Scheduler Content Moderation Integration — manual setup guide

**Scheduler Content Moderation Integration** (`scheduler_content_moderation_integration`)
is the bridge between the **Scheduler** module and Drupal core's **Content
Moderation** workflows. On its own, Scheduler can only flip an entity's published
flag on or off at a scheduled time. This sub-module makes it workflow-aware, so a
scheduled action can transition content to a *specific moderation state* — for
example "on Friday at 9am, move this from Draft to Published" or "at the end of the
campaign, transition this to Archived."

When an entity type is under a Content Moderation workflow and has scheduling
enabled, this module adds **Publish state** and **Unpublish state** selectors to the
entity form's Scheduling Options, right next to the existing "Publish on" and
"Unpublish on" date fields. At cron time it performs the chosen transition — but
only if that transition is actually valid in the workflow, otherwise it safely
abandons the job rather than forcing an illegal state change. It also handles
Scheduler's "publish immediately" case during a normal save, hides the date fields
when no transition is available, and blocks invalid or unauthorized selections with
validation constraints on the edit form.

This module has **no settings page and no permissions of its own** — all the
configuration lives in your Workflow and Scheduler settings. It requires the
**Scheduler** module (`^2.1`), core's **Content Moderation**, and core's **Options**
module. If you use Scheduler together with Content Moderation, this module is
essentially required to make the two cooperate. It also adds two node tokens that
expose the scheduled publish/unpublish state labels for use in messages or views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Scheduler and Content Moderation.

## Where it lives in the admin menu

This module adds **no admin page of its own**. You set things up in two existing
places, and the new fields then appear on the content edit form:

- **Configuration → Workflow → Workflows** (`/admin/config/workflow/workflows`) —
  where you put an entity type/bundle under a Content Moderation workflow.
- **Structure → Content types (or Media types) → your type → Scheduler tab** —
  where you turn on scheduled publishing/unpublishing for that bundle.

## How to use it

To schedule a moderation transition, for example a Draft that should go live later:

1. Put the entity type and bundle under a Content Moderation workflow at
   **Configuration → Workflow → Workflows** — edit your workflow and set "This
   workflow applies to" to include the bundle.
2. Enable scheduling on the bundle: go to **Structure → (Content or Media) types →
   your type → edit → the Scheduler tab**, and turn on "scheduled publishing"
   and/or "scheduled unpublishing."
3. Now, on the entity's edit form, expand **Scheduling Options**. You will see:
   - **Publish on** (a date) plus **Publish state** — the moderation state to
     transition to at that time (for example *Published*).
   - **Unpublish on** (a date) plus **Unpublish state**.
4. Set the date and the target state, then save. Make sure **cron is configured** —
   the scheduled jobs run on cron. At the appointed time, cron transitions the
   entity to the chosen state, provided that transition is valid in the workflow.

A few things worth knowing:

- The publish/unpublish **date** field is automatically hidden when no moderation
  transition is available for that state, so editors are not offered impossible
  choices.
- Only transitions that are valid in the workflow *and* permitted for the current
  user are accepted — invalid selections are blocked by validation when the form is
  saved.
- If, by the time cron runs, the workflow no longer permits the transition, the job
  is safely abandoned rather than forced.
- Two node tokens — `[node:scheduled-moderation-publish-state]` and
  `[node:scheduled-moderation-unpublish-state]` — expose the scheduled state labels
  for use in emails or views.
