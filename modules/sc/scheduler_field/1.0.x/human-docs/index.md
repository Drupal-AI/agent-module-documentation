# Scheduler Field — manual setup guide

**Scheduler Field** (`scheduler_field`) adds a field type that schedules an action
on its host entity. At its heart it's a date‑range field with an extra "scheduler
type" selector: you set a start (and optional end) date, and when cron reaches
those dates a pluggable action runs on the entity. Out of the box, that action is
publishing and unpublishing — set a start date to have a node go live
automatically, and an end date to have it come down again, giving you a fixed
publishing window with no manual intervention.

Because the schedule lives on a field (not baked into the entity), you can add
several independent scheduler fields to one entity, and you can schedule any
entity that supports publishing — nodes, custom entities, and so on — not just
nodes. Editors pick, per item, whether a given schedule is active or "Disabled".
It also integrates with Views, adding a field, filter, and argument for the
scheduler type so you can list or filter content by how it's scheduled.

Everything runs from Drupal's cron and queue system, so no external scheduler
service is needed — but that also means **you must run cron regularly** (for
example `drush cron`) for schedules to actually fire. There's no admin settings
page and no permissions; you extend the module by writing your own scheduler‑type
plugin (for example to change a moderation state, update a field, or send an email
on a date).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — there's no configuration page. You add and configure the
field through Field UI: **Structure → (your content type) → Manage fields**, and
its widget under **Manage form display**.

## How to use it

**1. Add the field.** On a content type's **Manage fields** tab, add a field and
choose the **Scheduler field** type.

**2. Pick a default scheduler type.** In the field's **storage settings**, choose
the default scheduler type — for example **Publication** (publish at the start
date, unpublish at the end date) or **Disabled** (no action). This default can't be
changed once the field holds data.

**3. Configure the widget.** On **Manage form display**, the scheduler widget adds
a scheduler‑type `<select>` to the date inputs. Its settings:

- **Show end date** — when off, hides the end‑date input and relabels the start as
  just "Date" (useful for open‑ended, publish‑only schedules). *(On by default.)*
- **Show type selector** — when off, hides the scheduler‑type dropdown from editors
  and forces the field's default type. *(On by default.)*

If a signer enters only an end date, the start date is automatically filled with
"now".

**4. Set up cron.** Schedules are executed by cron: on each run the module collects
the entities whose dates are due, queues them, and processes them. Make sure cron
runs on a schedule that matches how precise your timing needs to be (a scheduler
that should publish "at 9am" needs cron to run around then). Running `drush cron`
regularly — or using a cron module like Ultimate Cron or Simple Cron — keeps
schedules firing.

**Extending it.** The scheduler behavior is a plugin type
(`scheduler_field_type`). Developers can write a custom plugin to change a
workflow state, update arbitrary field values, send a notification, or perform any
action when a date is reached — see the sibling
[`agent/`](../agent/plugins/scheduler-field-type.md) docs.
