# Configuration

Setting up Workflow has three parts: (1) create a workflow with its states and
transitions, (2) attach a **Workflow state** field to the content you want to govern, and
(3) grant the per-workflow permissions to your roles. All the admin screens below require
the **Administer workflow** permission.

## 1. Create a workflow

1. Go to **Configuration → Workflow → Workflow**, or navigate to
   `/admin/config/workflow/workflow`.
2. Click **Add workflow**, give it a name (for example "Editorial"), and save. Every
   workflow automatically includes an implicit **(creation)** state — the state content
   starts in when it is first created.

### Workflow settings

On the workflow's edit form you can adjust how it behaves, including:

- **Name as title** — whether to use the workflow's name as the field's title.
- **How states are shown** — display the state choices as radios, a select list, or
  buttons.
- **Scheduling** — enable scheduled transitions and choose the timezone used for them.
- **Logging options** — whether to add a log entry to the node and/or write to the
  site log (watchdog) on each change.

## 2. Add states

1. From the workflow, open its **States** tab
   (`/admin/config/workflow/workflow/{workflow}/states`).
2. Add each state your process needs — for example **Draft**, **Needs Review**, and
   **Published** — giving each a label and a weight (the weight controls the order they
   appear in).

## 3. Define transitions (and who may use them)

1. Open the workflow's **Transitions** tab
   (`/admin/config/workflow/workflow/{workflow}/transition_roles`).
2. This is a grid of "from state → to state" moves. Tick which **roles** may make each
   move. For instance, you might let an *Author* move content from Draft to Needs Review,
   but only allow an *Editor* to move it from Needs Review to Published.
3. You can also set friendly **transition labels** on the *Transition labels* tab
   (`/admin/config/workflow/workflow/{workflow}/transition_labels`) so buttons read, say,
   "Submit for review" rather than just the target state name.

Because transitions are role-restricted, the same current state can offer different next
steps to different users.

## 4. Attach the Workflow state field to content

A workflow does nothing until you add a **Workflow state** field to a bundle and bind it
to that workflow:

1. Go to the content type (or other entity) you want to govern — for example **Structure
   → Content types → Article → Manage fields → Add field**.
2. Choose the **Workflow state** field type and give it a label such as "Editorial state".
3. In the field's **storage settings**, set **Workflow type** to the workflow you created.
   This binding is what connects the field to your states — you do **not** enter an
   allowed-values list yourself; the options come from the workflow's states
   automatically.
4. Save.

### Choose the widget and formatter

- On **Manage form display**, the field uses the **Workflow** widget, which shows the
  current state plus the allowed next states (as radios, select, or buttons, per the
  workflow settings), an optional comment/log field, and — if scheduling is enabled — a
  date/time to schedule the change.
- On **Manage display**, pick a formatter:
  - **Workflow** — shows the state together with the change form.
  - **Workflow state** (`workflow_state_label`) — shows just the current state's label.
  - **Workflow state history** (`workflow_state_history`) — shows the full transition
    history.

You can also place the state-change form in a **block** (the "Workflow" transition block)
instead of on the entity view, if you'd rather show it in a region.

## 5. Grant permissions to roles

Beyond **Administer workflow** (which controls who can build workflows), each workflow you
create generates its own permissions, named after the workflow's machine name (`<wid>`).
Grant these on **People → Permissions** to let roles participate:

- **Create `<wid>` workflow_transition** — the key "participate" permission: the role may
  execute state changes. (The per-transition role settings from step 3 refine this
  further.)
- **Schedule `<wid>` workflow_transition** — may schedule a transition for a future time.
- **Access own / any `<wid>` workflow history** — may see the "Workflow history" tab on
  their own, or any, content.
- **Access `<wid>` workflow_transition form** — may see and submit the transition
  widget/block on the entity.
- **Edit / Revert own or any `<wid>` workflow_transition** — may edit the comment on, or
  revert, past transitions.
- **Bypass `<wid>` workflow_transition access** — ignore all transition restrictions
  (superuser-like; grant sparingly).

When a workflow is first created, most roles are given the basic "participate" permission
by default — review and tighten this to match your process.

## Scheduled transitions

If you enabled scheduling in the workflow settings, editors can pick a future date/time
when changing state, and the transition is applied automatically on the next **cron** run
after that time. Make sure cron runs regularly for scheduled transitions to fire.
