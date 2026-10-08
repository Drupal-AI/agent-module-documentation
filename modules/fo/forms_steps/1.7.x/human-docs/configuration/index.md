# Configuration

You build wizards at **Configuration → Workflow → Forms Steps**
(`/admin/config/workflow/forms_steps`). The whole area requires the **Administer
forms steps** permission. A wizard is a "Forms Steps" configuration entity made
of ordered **steps** and optional **progress steps**.

## Before you start: create form modes

Each step renders an entity in a chosen **form mode**, so create those first in
**Field UI** (Manage form modes for your entity type), and place the fields you
want on each mode. A step can only reference a form mode that already exists.

## Add a workflow

On the Forms Steps page, click **Add a Forms Steps**. Give it an **ID**, a
**label**, and an optional description. This creates an empty wizard you then
fill with steps.

At the workflow level you also control a few options:

- **Only link saved progress steps** — in the progress bar, only make a step
  clickable once the user has actually saved that step.
- **Also link the next step** — additionally allow clicking the step
  immediately after the last saved one.
- **Redirection policy / target** — where to send the user when the wizard
  finishes (a route or a specific step).

## Add steps

Add one **step** per page of the wizard. For each step you set:

- **Label** and **Weight** — the display name and the order the steps run in.
- **Entity type** and **Entity bundle** — which entity this step creates or
  edits.
- **Form mode** — which form mode (and therefore which fields) shows on this
  step.
- **URL** — the front‑end path fragment for this step. The real page lives at
  `<url>/{instance_id}`, where the instance ID is the unique run identifier
  (see below).
- **Submit label**, **Cancel label**, **Previous label**, **Delete label** —
  the button texts.
- **Cancel route / Cancel step** — where "Cancel" goes: an arbitrary route, or
  back to a specific earlier step.
- **Display previous** — whether to show a Previous button.
- **Hide delete** — hide the Delete button on steps where deletion shouldn't be
  offered.

## Add progress steps

**Progress steps** are the labelled items shown in the progress bar. Add and
order them to reflect the stages of your wizard. Whether each one is clickable is
governed by the workflow‑level "only link saved" options described above.

## Place the progress‑bar block

Forms Steps provides a **Forms Steps progress bar** block (one variant per
workflow). Place it in a region at **Structure → Block layout** if you want the
progress bar to appear alongside your steps.

## How the front‑end flow works

Forms Steps automatically generates a front‑end route for each step at
`<step url>/{instance_id}`. The instance ID is a UUID that identifies one run of
the wizard, so the same entity carries across steps. These routes are gated by
the core **Access content** permission — which is what lets end users (including
anonymous visitors, if they have that permission) actually walk the wizard.

Because a public wizard is reachable by anyone who can view content, add
protections like CAPTCHA, Honeypot, or flood control at the site level if you
expose a flow to anonymous users.

## Settings and the instance list

- A module‑wide **Settings** form is available from the Forms Steps admin area.
- A **Workflow instance list** (at `/admin/config/workflow/forms_steps/workflows/list`)
  shows in‑progress runs; viewing it requires the **View forms_steps_workflow
  entity** permission.

## Permissions summary

| Permission | What it controls |
|-----------|------------------|
| **Administer forms steps** (`administer forms_steps`) | Full control of the Forms Steps admin area — creating, editing, and deleting workflows, steps, progress steps, and settings. There is no per‑workflow permission; this grants access to all of them. |
| **View forms_steps_workflow entity** | View the list of in‑progress workflow instances. |
| **Access content** (core) | The gate on the generated front‑end step routes — what lets end users complete a wizard. |

## Attaching an existing entity (developer note)

Forms Steps provides a Drush command, `forms_steps:attach-entity` (alias
`fs-attach-entity`), to bind an existing entity to a step and instance
programmatically. Developers can also react to step transitions by subscribing to
the module's `StepChangeEvent`.
