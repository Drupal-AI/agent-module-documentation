# Configuration

Scheduled Publish has no global settings form. You configure it by adding a
**Scheduled publish** field to a moderated bundle; after that, scheduling is
something editors do on the content edit form, and transitions are applied by
cron.

## Before you start: Content Moderation

The bundle you add the field to **must** be enabled in a Content Moderation
workflow (**Configuration → Workflows → Workflows**), because the field's
state selector only offers states from that workflow. If a bundle isn't moderated,
there are no target states to schedule toward.

## Add the Scheduled publish field

1. Go to the bundle's **Manage fields** page — for example
   **Structure → Content types → Article → Manage fields**
   (`/admin/structure/types/manage/article/fields`).
2. Click **Add field** and choose **Scheduled publish**.
3. Give it a label (e.g. *Scheduled moderation*). If editors should be able to
   queue more than one transition on a single entity, set **Allowed number of
   values** to *Unlimited* — this is the usual choice.
4. Save. The **Scheduled publish** widget is used on *Manage form display* by
   default, and the **Generic formatter** renders it on *Manage display*.

## How editors schedule a transition

On the entity's edit form, the Scheduled publish widget shows, for each entry:

- a **date and time** picker — when the change should happen, and
- a **moderation state** selector — the state the entity should move to (limited
  to the bundle's workflow).

An editor adds one or more of these entries and saves the entity as normal.
Nothing happens immediately; the entries simply wait for their scheduled time.

## When and how transitions fire

- **On cron.** Every Drupal cron run, the module looks for scheduled entries whose
  time has passed and applies the matching moderation transition, saving a new
  revision. So publishing, unpublishing, or archiving happens with no editor
  present — provided cron runs regularly.
- **On demand with Drush.** To apply all currently-due transitions right away
  (useful in a deployment or for testing without waiting for cron):

  ```bash
  drush scheduled_publish:doUpdate
  # short alias:
  drush schp
  ```

## Review pending scheduled changes

A site-wide listing of everything still queued lives at **Content → Scheduled
publish** (`/admin/content/scheduled-publish`), with **add**, **edit**, and
**delete** forms under that path. Access is controlled by two permissions
(**People → Permissions**):

- **Access scheduled publish pages** — required for the add/edit/delete forms.
- **View any unpublished content** — additionally required to see the listing
  itself.

## Displaying the scheduled dates

If you want the scheduled entries to show on the rendered entity, the **Generic
formatter** on *Manage display* offers a configurable **date format** and **text
pattern** so you can control how each queued change is presented.
