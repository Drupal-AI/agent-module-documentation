# ECA VBO — manual setup guide

**ECA VBO** (`eca_vbo`) is a bridge between two popular Drupal tools: the
[ECA](https://www.drupal.org/project/eca) no‑code automation engine (Event –
Condition – Action) and [Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)
(VBO), which lets editors select rows in a View and run an action on all of them at
once. With ECA VBO you build a bulk action entirely as an ECA model — no custom PHP
— and it shows up as a selectable operation on your View's bulk‑operations
checkbox column.

The connection between the two sides is an **operation name** that you type in. In
the ECA UI you add a "VBO: Execute" event and give it an operation name like
*Publish and notify*. That name automatically becomes a bulk action you can pick in
the Views UI. When an editor selects some rows and runs the operation, ECA fires
your event — either once per selected entity, or once for the whole selection — and
your ECA actions do the work (set a field, change a state, send an email, build a
report, and so on).

Because everything is ECA, you get its full toolbox: conditions so the operation
only touches matching entities, a configuration form and confirmation step you can
customize, a completion message you can set, and even dynamic access rules that
decide per‑user or per‑selection whether the operation may run. Runtime data (the
view, the action, the current entity or the queued selection) reaches your model as
ECA tokens.

There is no admin settings page of the module's own. You build operations in the
**ECA UI** and wire them into a **View** — the full walkthrough is in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it pulls in ECA and Views Bulk Operations).
2. [Configuration](configuration/index.md) — build an ECA operation and wire it
   into a View, including the important custom‑access caveat.

## Where it lives in the admin menu

ECA VBO has no page of its own. You work in two places: the **ECA** models list at
**Configuration → Workflow → ECA** (`/admin/config/workflow/eca`), and the **Views**
editor at **Structure → Views** where you add a bulk‑operations field.

## How to use it

At a high level:

1. Build an ECA model with a **VBO: Execute** event, give it an operation name, and
   add the actions that do the work (including one that **saves** the entity — this
   module only fires the event, it doesn't save for you).
2. Edit a View and add a bulk‑operations field, then select your operation among the
   available actions.
3. Editors now see it in the View's "Action" dropdown and can run it over selected
   rows.

The step‑by‑step recipes are in [Configuration](configuration/index.md).
