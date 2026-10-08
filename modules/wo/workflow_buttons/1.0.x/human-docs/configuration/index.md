# Configuration

Setting up Workflow buttons has two parts: turning the button widget on for a
content type (the main step), and an optional global settings form.

## Prerequisite: Content Moderation

The buttons are generated from a moderation workflow's **transitions**, so the
content type must already be under **Content Moderation**. Set that up first at
**Configuration → Workflow → Workflow** (`/admin/config/workflow/workflows`):
create or edit a workflow, define its states and transitions, and add your
entity type and bundle to it. If a bundle is not attached to a workflow, there
are no transitions and therefore no buttons.

## Turn the widget on for a content type

1. Go to **Structure → Content types → [your type] → Manage form display**
   (`/admin/structure/types/manage/<type>/form-display`).
2. Find the **Moderation state** field.
3. Set its **Widget** to **Workflow buttons**.
4. Click **Update**, then **Save**.

Because the module also registers Workflow buttons as the moderation‑state
field's *default* widget, on many sites this is already selected — in which case
you only need to confirm it.

### Widget option

Click the gear icon next to the Moderation state field to reveal the one widget
setting:

- **Show current state** (`show_current_state`) — when ticked, the current
  moderation state is displayed in the form's meta/sidebar section, so editors
  can see where the content stands before they click a transition button.

### What editors see

On the edit form, the moderation‑state dropdown and the default Save / Publish /
Unpublish buttons are replaced by **one button per transition the current user
is allowed to perform**, grouped as a dropbutton in the form actions. Each
button is labelled with its transition name, the first button (and any "publish"
transition) is styled as the primary action, and a "delete" transition appears
as a red danger/trash button.

## Global settings form

Go to **Configuration → Workflow → Workflow buttons**
(`/admin/config/workflow/workflow-buttons`). You need the **Administer site
configuration** permission. There is a single option:

- **Show buttons at the top of the form** (`display.top_buttons`, default
  **off**) — when enabled, the workflow buttons also appear at the **top** of the
  edit form, not just at the bottom. This saves scrolling on long forms. Note
  that with the **Gin** admin theme the buttons already live in Gin's sticky
  header, so in that case a second set is added at the bottom instead.

Click **Save configuration** to apply. The setting takes effect on the next edit
form you open.
