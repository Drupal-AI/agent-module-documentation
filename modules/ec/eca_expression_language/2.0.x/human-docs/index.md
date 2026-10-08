# ECA Expression Language — manual setup guide

**ECA Expression Language** (`eca_expression_language`) brings **Symfony's
Expression Language** component into
[ECA](https://www.drupal.org/project/eca) (Event-Condition-Action), so your ECA
models can evaluate expressions to compute conditions — and, in an upcoming
feature, calculated values — dynamically. It turns fiddly multi-branch condition
logic into a single readable expression, roughly the way a spreadsheet formula
combines several inputs into one result.

The headline feature is the **Expression Language Condition**: a condition where
you type an expression that mixes ECA tokens with Expression Language syntax
(`and`, `or`, parentheses, comparisons, arithmetic, `in`, and so on). A concrete
example from the module's own docs:

```
[entity:nid] in [ 2, 6, 7 ] and ("[entity:type]" == "article" or [user:uid] == 1)
```

That single line replaces what would otherwise be several chained conditions and
gateways.

Because expressions are **evaluated** as logic, treat ECA-model editing as a
trusted activity: keep it to trusted administrators, and never build expressions
out of untrusted input. The module has no access-control role and no settings form
— you write expressions inside ECA models. It depends only on the ECA base module
(`eca`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside ECA.

There is **no configuration page** for this module — it has no settings form. You
write expressions inside the ECA modeller, described in "How to use it" below.

## Where it lives in the admin menu

ECA Expression Language adds no admin page of its own. You work with it inside the
ECA modeller at **Configuration → Workflow → ECA** (`/admin/config/workflow/eca`).

## How to use it

1. Open or create an ECA model at **Configuration → Workflow → ECA**.
2. Add a **condition** to a gateway and select **Expression Language Condition**.
3. Enter an expression that combines ECA tokens (for example `[entity:type]`,
   `[user:uid]`) with Expression Language operators, as in the example above.
4. Wire the condition's true/false outcomes to the actions you want.

Keep expression authoring to trusted administrators, and do not assemble
expressions from data supplied by untrusted users.
