# Paragraphs Limits — manual setup guide

**Paragraphs Limits** (`paragraphs_limits`) lets site builders set a **minimum and
maximum number of each paragraph type** allowed on a Paragraphs field. Instead of a
single blanket cardinality for the whole field, you can say "require exactly one Hero",
"allow at most two Call‑to‑action blocks", and "unlimited Text" — all on the same field.
It's a small but effective guardrail for keeping page‑builder content consistent and
stopping editors from overloading a layout.

The limits are enforced two ways. First, once a paragraph type reaches its maximum, that
type is removed from the "Add more" control, so an editor simply can't add another one.
Second, a validation constraint runs on save: adding too few of a required type or too
many of a capped type raises a clear error message. It works with both the classic and
the stable Paragraphs widgets, and it cleans up after itself — uninstalling the module
reverts affected fields back to the default paragraph handler and strips the limit
settings, so nothing is left dangling.

There is **no admin settings page**. You turn the feature on per field by changing that
field's *reference method* to **Paragraphs with limits**, which then adds "Lower limit"
and "Upper limit" number columns to the paragraph‑types table on the field settings form.
A value of `0` means "no limit" for that bound. The module requires the Paragraphs module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

Limits are configured on the **Paragraphs field itself**, not on a central page:

1. Go to the bundle's field list and edit your Paragraphs (entity reference revisions)
   field — **Manage fields → *your field* → Edit** (the field settings tab).
2. Set the **Reference method** to **Paragraphs with limits**.
3. The paragraph‑types table now shows a **Lower limit** and an **Upper limit** number
   column for each type. Enter your values — remember **`0` means no limit** for that
   bound. For example: Hero lower `1` / upper `1` (exactly one), CTA lower `0` / upper `2`
   (at most two), Text lower `0` / upper `0` (unlimited).
4. **Save**.

From then on, editors can't add more than the upper limit of a type — its option
disappears from "Add more" once the cap is reached — and submitting too few or too many of
a type raises a validation error on save. Apply different limits to different types on the
same field to define your page structure exactly.

The values are stored in the field's configuration (under the field's handler settings),
so they export cleanly with your configuration for deployment.
