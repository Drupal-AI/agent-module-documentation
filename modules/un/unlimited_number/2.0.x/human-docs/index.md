# Unlimited Number — manual setup guide

**Unlimited Number** (`unlimited_number`) provides an "Unlimited or a specific
number" control — the classic cardinality‑style choice where a user either picks
**Unlimited** or types a concrete limit. It solves the common awkwardness of a
plain number field where "-1 means unlimited" but the editor has to just *know*
to type `-1`. Instead, editors get two clear radios, and the numeric input only
appears when they choose "Limited".

The module ships two things that use the same control:

- A **field widget** called **Unlimited or Number** (`unlimited_number`) for
  **integer** fields. This is what most people want: set an integer field's form
  widget to it, and editors get the guided radios‑plus‑number UI. When they pick
  "Unlimited", the widget stores a real integer of your choosing — `0` by default,
  or `-1` for the core cardinality convention — so the field's database column
  stays a plain integer and Views/queries stay simple.
- A **Form API render element** (`#type => unlimited_number`) for developers to
  drop the same control into a custom or settings form. At that layer, "Unlimited"
  resolves to the string `'unlimited'` and "Limited" to the entered integer.

There is no admin settings page, no permissions, and no Drush commands. The only
thing you configure is the widget's settings on an entity form display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Unlimited Number has **no configuration page of its own**. You use it by assigning
its widget to an integer field under **Structure → Content types → (your type) →
Manage form display** (`/admin/structure/types`).

## How to use it

**On a content field (the common case):**

1. Enable the module (see [Installation](installation/index.md)).
2. Add or pick an **integer** field on your content type.
3. Go to **Manage form display**, and set that field's widget to **Unlimited or
   Number**.
4. Click the gear icon to edit the three settings, then **Save**:
   - **Value stored for "Unlimited"** — the actual integer saved when the editor
     picks Unlimited. Default `0`; set it to `-1` for the core cardinality style.
     Pick a value that can never be a genuine limit, since a real limit equal to
     this value is indistinguishable from "unlimited."
   - **Label for "Unlimited"** — the wording of the unlimited radio (default
     *Unlimited*; e.g. "Forever" or "No limit").
   - **Label for "Limited"** — the wording of the number radio (default
     *Limited*; e.g. "Until a number" or "Set a limit").

Editors then see the two radios on the edit form; choosing "Limited" reveals the
number input, which is required when that option is selected. The field's own
min/max settings bound the numeric input.

**In a custom form (for developers):** use the render element directly —
`'#type' => 'unlimited_number'` — which supports `#default_value`, `#min`, `#max`,
`#step`, `#field_prefix`/`#field_suffix`, `#ajax`, and custom radio labels via
`#options['unlimited']` / `#options['limited']`. It returns the string
`'unlimited'` or the entered integer; map "unlimited" to your own sentinel in
code. (See the sibling `agent/` docs for the full property list.)
