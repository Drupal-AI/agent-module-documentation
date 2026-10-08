# Field States — manual setup guide

**Field States** (`field_states`) adds a **state‑machine layer** on top of an
options field. A plain options field lets an editor pick any value at any time —
fine for a category, wrong for a status. A support ticket shouldn't jump from
*new* straight to *closed* without passing through *resolved*; an approved
application shouldn't slip back to *draft*. Field States lets you define the list
of allowed **states** and the legal **transitions** between them, so a value can
only move where the configuration permits.

You list the states in the field's storage (as a list of strings) and describe the
transitions in the field settings using a small YAML format — you can even copy and
paste transition definitions straight from a core Workflows YAML file. Each
transition can carry a button label, the states it's allowed *from* and *to*, and
optional role, permission, group, guard, workflow, and action hooks for custom
logic. The module can visualize the resulting state machine with mermaid.js, and
there's an interactive editor for drawing states and transitions (Bootstrap 5
theme only). In the field formatter, editors get transition buttons for the moves
that are currently valid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site‑wide settings form**. Everything is configured on the field
itself, with a per‑field state‑machine screen at
`/field-states/state-machine/{field}`; the setup steps are in "How to use it"
below.

## How to use it

1. Add (or edit) a field of an options/list type on your entity.
2. In **field storage**, list all the states as the allowed values (this looks
   like a normal list‑of‑strings setting).
3. In the **field settings**, define the transitions in YAML — each with a
   `label`, `from` (one or more states), `to` (a single state), and optionally
   `role`, `permission`, `group`, `guard`, `workflow`, and `action` for custom
   behavior. You can paste these from a Workflows YAML file.
4. Optionally open the per‑field state‑machine screen
   (`/field-states/state-machine/{field}`) to view or draw the machine visually.

When editing content, editors then see transition buttons only for the moves that
are legal from the current state.

## Permissions

Field States provides two permissions: **`access states`** for viewing and
**`admin states`** for editing the state machine. Grant them under **People →
Permissions** as appropriate. Note that user 1 always bypasses permission checks;
test transition behavior with a normal (non‑user‑1) account to see what your
editors will actually get.
