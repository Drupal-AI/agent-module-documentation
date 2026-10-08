# Expression Field — manual setup guide (2.0.x)

**Expression Field** (`field_expression`) provides a new field type whose value
is **calculated from an expression you write**, rather than typed in by an
editor. The expression is a mathematical formula, and it can pull in values from
other fields using **tokens** — so you can, for example, compute a total from a
quantity and a price, derive a sortable key from a date, or assemble a display
number from several fields. Because the result is stored on the entity, Views can
sort and filter on it just like any ordinary field.

Two decisions are worth making deliberately. First, **when the expression is
evaluated**: by default it is computed when the entity is saved and stored, which
means a value that reads a *referenced* entity will not update when that other
entity later changes — the field formatter offers an option to instead evaluate
on every render, at a performance cost. Second, **what an expression can reach**:
tokens can expose more than the immediate entity, so on a site where the person
configuring fields is not fully trusted, the token boundary deserves a look
rather than an assumption. Treat expression configuration as an admin‑trusted
capability.

Expression Field is described by its maintainers as a Drupal 8+ successor to the
old *Mathfield* module, using the same class of underlying expression‑evaluation
library. Token support is strongly recommended — without the Token module you can
only hard‑code static expressions in the field settings.

> **Which version is this?** This is the **2.0.x** guide. Version **2.1.x** is a
> larger release that adds typed numeric field variants (integer/decimal/float),
> variables and user‑defined functions, and pins a specific sandboxed math
> evaluation library (`webit/eval-math`). If you are choosing between them, read
> the 2.1.x guide too — this 2.0.x line provides the single, original Expression
> string field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the recommended Token module.

There is **no site‑wide configuration page** for this module. An Expression field
is configured like any other field, on your entity's field settings and display,
described below.

## Where it lives in the admin menu

Expression Field adds no admin page of its own. You add and configure an
Expression field through Field UI: **Structure → Content types → *(type)* →
Manage fields → Add field**, then pick the **Expression** field type. The
expression itself, any per‑token defaults, and whether unresolved tokens fall
back to zero are set on the field's settings; whether the value is recomputed on
render is a formatter option under **Manage display**.

## How to use it

1. Add a new field to your content type and choose the **Expression** field type.
2. In the field settings, write the expression. Reference other fields with
   tokens — for example a quantity token multiplied by a price token — and
   optionally provide defaults for tokens that may not resolve.
3. Save. When an entity is created or updated, the tokens are replaced and the
   expression is evaluated; the result is stored on the entity so it can be
   displayed, sorted, and filtered.
4. If your expression reads content that changes independently of this entity and
   you need it always current, enable the "evaluate on render" behavior in the
   field's display settings under **Manage display** — at the cost of computing
   on every page load.
