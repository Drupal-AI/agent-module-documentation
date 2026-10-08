# Configuration

Views Bulk Operations has **no global settings form** — you configure it per View
by adding its special field to a display. Everything below happens inside the
Views UI.

## Add the VBO field to a View

1. Log in as a user who can administer views (an administrator by default).
2. Go to **Structure → Views** (`/admin/structure/views`) and edit the View you
   want bulk operations on — or add a new one, for example a listing of content
   or of users.
3. In the **Fields** section click **Add**, search for **Views bulk
   operations** (it's under the *Global* group), and add it. You can add only one
   VBO field per display.
4. Drag the field to the **top** of the field list so its checkbox column renders
   at the start of each row.

When you add the field, its configuration form opens. The main options are below.

## Selected actions

A list of checkboxes, one per available Action plugin (delete, publish/unpublish,
cancel user, plus any custom actions and any provided by other modules). Tick the
actions you want offered in this View's dropdown. **Leave every box unticked to
offer all available actions.** Restricting the list is useful when a particular
View should only allow, say, "publish" and "unpublish".

For each action you enable, you can additionally set:

- **Preconfiguration** — fix certain settings ahead of time so the editor doesn't
  have to supply them at run time (for actions that support it).
- **A custom label** — rename how the action appears in the dropdown.
- **Configuration step** — whether the action shows a form to collect input
  before it runs.
- **Confirmation step** — whether the user must confirm before a destructive
  action executes. Turn this on for anything irreversible, such as deletion.

## Batch and batch size

- **Process in a batch** — when enabled, the operation runs through Drupal's
  Batch API rather than all at once, showing a progress bar. This is what lets VBO
  handle thousands of rows without timing out.
- **Batch size** — how many rows are processed per batch pass (**default 10**).
  Lower it if individual items are heavy to process; raise it to reduce overhead
  on light operations.

## Selection behavior

A few smaller options control how selection behaves:

- **Clear selection when exposed filters or sorts change** — wipe the current
  selection if the user re‑filters the list, so they don't accidentally act on
  rows they can no longer see.
- **Force selection info** — always show the "N items selected" summary.

These, together with tempstore, are what let a selection survive as the user pages
through results with AJAX before running the action.

## How it flows for the end user

Once configured, a person using the View will: tick rows (or choose **select all
results** to act on the entire result set, across all pages) → pick an action
from the dropdown and submit → optionally fill in a **configuration** step →
optionally **confirm** → and then watch the batch run the action. 

## Save

Click **Apply** on the field form, then **Save** the View. Because VBO settings
are stored as part of the View's configuration, the whole thing exports and
deploys between environments like any other View.
