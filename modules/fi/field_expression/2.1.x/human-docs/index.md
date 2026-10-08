# Expression Field — manual setup guide (2.1.x)

**Expression Field** (`field_expression`) provides field types whose value is
**calculated from a mathematical expression** you write, rather than typed in by
an editor. Expressions can pull in values from other fields using **tokens**, so
you can compute a total from a quantity and a price, derive a sortable numeric
key from other fields, or assemble a display number — and because the result is
stored on the entity, Views can sort and filter on it like any ordinary field.

The **2.1.x** release broadens the original single string field into a small
family. Alongside the base `field_expression` string field there are typed
numeric variants — **Expression (integer)**, **Expression (decimal)**, and
**Expression (float)** — that extend Drupal core's own number field types, so
their stored value formats and sorts like a real number rather than as text.

Expressions support the operators `+ - * / ^ %` (where `^` is exponentiation and
`%` is modulo) and a fixed set of single‑argument math functions such as `sin`,
`cos`, `sqrt`, `abs`, `ln`, and `log` (plus their inverses and hyperbolic
forms). The numeric field types additionally let you assign variables and define
your own multi‑argument functions across several `;`‑separated statements — for
example `min(a,b) = (a+b-abs(a-b))/2; min(3,5)`. Tokens are replaced by the Token
module when the entity is saved; you can give a token a per‑token default in
curly braces (`[node:field_x]{100}`) and optionally have unresolved tokens fall
back to zero so a missing value does not break the whole expression.

Two decisions are worth making deliberately. First, **when the expression is
evaluated**: by default it is computed on save and stored, so a value that reads a
*referenced* entity will not refresh when that other entity changes — the
formatter's **Always Evaluate** option recomputes on every render, at a
performance cost. Second, **what an expression can reach**: tokens can expose more
than the immediate entity, so on a site where whoever configures fields is not
fully trusted, the token boundary deserves a look. Reassuringly, in 2.1.x the
math itself is parsed by a **sandboxed evaluator** (`webit/eval-math`), *not* by
PHP's `eval()`, so the expression engine cannot execute arbitrary PHP — the
consideration is about which tokens are exposed, not about code execution.

> **Which version is this?** This is the **2.1.x** guide, and it differs from
> **2.0.x** in several ways: it requires **Drupal 10.2 or newer** (2.0.x supports
> Drupal 9), it adds the typed integer/decimal/float field variants plus
> variables and user‑defined functions, and it pulls in the `webit/eval-math`
> Composer library as an explicit sandboxed evaluator. The 2.0.x line provides
> only the single original Expression string field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `webit/eval-math` library) and enable the module and the recommended Token
   module.

There is **no site‑wide configuration page** for this module. An Expression
field is configured like any other field, on your entity's field settings and
display, described below.

## Where it lives in the admin menu

Expression Field adds no admin page of its own. You add and configure an
Expression field through Field UI: **Structure → Content types → *(type)* →
Manage fields → Add field**, then pick one of the **Expression** field types
(the base string field or a typed integer/decimal/float variant). The expression,
any per‑token defaults, variables, and functions are set on the field's settings;
whether the value is recomputed on render (**Always Evaluate**) is a formatter
option under **Manage display**.

## How to use it

1. Add a new field to your content type and choose the appropriate **Expression**
   field type — the string variant for text output, or an integer/decimal/float
   variant when you need the result to sort and format as a number.
2. In the field settings, write the expression. Reference other fields with
   tokens (optionally with `{default}` values), use operators and math
   functions, and — for the numeric types — assign variables or define functions
   across `;`‑separated statements.
3. Optionally have unresolved tokens fall back to zero, and suppress evaluation
   errors so a bad expression yields a blank value rather than an error.
4. Save. When an entity is created or updated, tokens are replaced and the
   expression is evaluated by the sandboxed math engine; the result is stored so
   it can be displayed, sorted, and filtered.
5. If your expression reads content that changes independently of this entity and
   must stay current, enable **Always Evaluate** in the field's display settings
   under **Manage display** — at the cost of recomputing on every render. If the
   Devel module is installed you can inspect an expression's token replacement and
   result while debugging.
