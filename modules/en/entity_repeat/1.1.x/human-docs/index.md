# Entity Repeat — manual setup guide

**Entity Repeat** (`entity_repeat`) generates recurring copies of an entity from a
single base entity plus a repeat pattern — the classic "recurring event" or
"repeated content" workflow. You describe the recurrence on a date field, and the
module produces the individual instances for you.

Under the hood it stands on two well‑known contrib modules: **Date Recur**
supplies the recurrence rules (weekly, monthly, "every second Tuesday", and so on)
through its field type and modular widgets, and **Replicate** does the actual
entity cloning. Entity Repeat is the glue that turns "this event repeats every
Monday for ten weeks" into ten real entities. Inspired by the older Entity Recur
project, it is squarely a content‑automation feature: the entities it creates are
ordinary content governed by normal entity access, and the module has no
access‑control role of its own.

It works once you have added a Recurring Dates field to a bundle and set that
field's widget to the **Entity Repeat** widget. The module provides its own
permissions so you can decide who is allowed to trigger instance generation — when
a permitted user edits the entity, a checkbox appears alongside the Recurring
Dates field letting them generate the repeated entities. An optional submodule,
**Entity Repeat Group** (`entity_repeat_group`), associates each generated entity
with the original entity's Group (from the contributed Group module) if you use
Group.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Date Recur / Replicate dependencies, and optionally the Group
   submodule.

This module has no central settings form — setup happens on a field and in the
permissions screen, described in "How to use it" below.

## How to use it

1. Add a **Recurring Dates** field (from Date Recur) to the entity bundle you want
   to repeat, for example an Event content type.
2. On that bundle's **Manage form display**, set the field's widget to the
   **Entity Repeat** widget.
3. Go to **People → Permissions** and grant the **Entity Repeat** permissions to
   the roles that should be allowed to generate repeated entities.
4. When a user with that permission edits an entity, a checkbox appears next to
   the Recurring Dates field. Ticking it and saving generates the repeated
   entities according to the recurrence rule.

> **Using the Group submodule?** Enable **Entity Repeat Group**
> (`entity_repeat_group`) and each generated instance is associated with the
> original entity's group automatically.
