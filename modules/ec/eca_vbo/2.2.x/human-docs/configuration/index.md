# Configuration

ECA VBO has no settings form of its own. You build a bulk operation in two places
and connect them with an **operation name**: an ECA model provides the logic, and a
View exposes it as a bulk action.

## The two Views fields — and why the choice matters

Views Bulk Operations gives a View a checkbox column plus an "Action" dropdown.
There are two fields you can add, and the difference is important:

- **Views bulk operations** — the stock field. It can run ECA operations.
- **ECA bulk operations** — this module's own field. It lists only ECA‑derived
  actions and **does** enforce custom access.

If your operation changes content and you rely on ECA to decide who may run it, you
**must** use the *ECA bulk operations* field. Both fields list the same action, so
they are easy to confuse. When in doubt, use *ECA bulk operations*.

## Recipe A — a simple bulk operation

1. **In the ECA UI** (Configuration → Workflow → ECA), create or edit a model.
2. Add the event **"VBO: Execute Views bulk operation (one by one)"**. In its
   settings type an **Operation name**, for example `Publish and notify`. (You can
   optionally restrict it to a specific view id and/or display id; leave those empty
   to make it available on any View.)
3. Add the successor **actions** that do the work — set a field, change a moderation
   state, send an email, and so on. Crucially, include an action that **saves the
   entity**: ECA VBO only fires the event, it does not save changes for you.
4. Optionally add the **"VBO: Set result"** action to define the message shown to the
   editor after the batch finishes.
5. **Save** the ECA model. Saving refreshes the list of available bulk actions so
   your operation appears immediately.
6. **In the Views UI**, edit your View and add a bulk‑operations field (see the
   caveat above), then select your operation (`Publish and notify`) among the
   listed actions and save.

Editors will now see the operation in the View's "Action" dropdown.

## Recipe B — a bulk operation with custom access

To control who may run the operation, add a second event to the same model:

1. Do steps 1–5 above.
2. Add the event **"VBO: Custom access for Views bulk operation"** with the **same
   operation name**. As its successor add the action **"VBO: Set custom access on
   Views Bulk Operation"**, which grants or denies access. Put ECA **conditions**
   before it (checking a role, a field value, the selection, and so on) so access is
   decided dynamically.
3. **In the Views UI you must use the "ECA bulk operations" field**. Select your
   operation there.

## One‑by‑one vs. the whole selection

There are two execute events, and you can use either or both:

- **Execute (one by one)** runs your model once per selected entity, with that
  entity in scope. Best for per‑item changes.
- **Execute (multiple at once)** runs once for the entire selection. Best for
  summaries, aggregate work, or a single outbound call (one email listing
  everything, for instance). If you use both, the "multiple" event runs first.

## The confirmation step

By default the operation shows a confirmation screen before it runs. To skip it for
a smoother one‑click action, tick **"Skip confirmation step"** in the action's
settings on the Views field. You can also react to the confirmation form's lifecycle
with the ECA events **VBO: Confirm form build / validate / submit**, and add your own
fields to the action's configuration form with **VBO: Form build / validate /
submit**.

## Data available to your model (tokens)

Inside the model your ECA actions can read runtime data through tokens:

- `[event:view:id]` and `[event:view:display_id]` — which View and display ran it.
- `[event:action:plugin]` and `[event:action:config]` — the action and its config,
  useful for branching logic.
- On the one‑by‑one event: `[event:entity:id]`, `[event:entity:label]`,
  `[event:entity:type]`, `[event:entity:bundle]`, `[event:entity:langcode]`, and the
  entity itself.
- On the multiple event: `[event:queue:count]`, `[event:queue:ids]`,
  `[event:queue:revisions]`, and `[event:queue:items]` for the whole selection.

Two helper actions round things out: **VBO: Get configuration value** reads a value
the editor entered on the action form into a token, and **VBO: Get Views argument**
reads a Views contextual filter argument into a token.
