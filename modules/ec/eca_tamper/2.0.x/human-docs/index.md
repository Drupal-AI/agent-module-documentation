# ECA Tamper — manual setup guide

**ECA Tamper** (`eca_tamper`) is a bridge between two automation modules:
[ECA](https://www.drupal.org/project/eca) (Event – Condition – Action, a visual
workflow/business-rules engine) and [Tamper](https://www.drupal.org/project/tamper)
(a library of small data-transformation plugins). It exposes **every** Tamper
plugin to ECA as an **action** — and, where it makes sense, as a **condition** —
so your ECA models can trim, find-and-replace, change case, encode/decode, cast,
reformat dates, and otherwise transform string and data values without any custom
code.

For every Tamper plugin you get an ECA action named `eca_tamper:<plugin>` (for
example `eca_tamper:trim`, `eca_tamper:find_replace`, `eca_tamper:encode`). Text,
Date-time, Number and Other Tamper plugins additionally get an ECA condition
(`eca_tamper_condition:<plugin>`) that transforms a value and compares it. Any
custom Tamper plugin you have written becomes available in ECA automatically, with
no glue code.

This is a thin integration module. It has **no admin UI, no configure route, no
permissions, and no Drush commands** of its own — you use everything from inside
ECA models. It requires both the ECA and Tamper modules and PHP 8.1+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside ECA and Tamper) and enable it.

## How to use it

There is nothing to configure globally — you use the derived actions and
conditions inside your ECA models (built in the ECA modeller, for example with
BPMN.iO).

### As an action

Add an action to your model and pick a plugin whose name starts with
`eca_tamper:` — for example **Trim** (`eca_tamper:trim`). Every ECA Tamper action
has two extra settings on top of the wrapped Tamper plugin's own options:

- **Data** (`eca_data`) — the value to transform. This is token-aware, so you can
  feed it `[node:title]`, a token from an earlier action, or a literal.
- **Token name** (`eca_token_name`) — the name of the token that receives the
  transformed result, so later steps in the model can use it.

Below those you configure whatever the underlying Tamper plugin exposes (for
example, which side and characters `trim` strips, or the find/replace strings).
Chaining several `eca_tamper:*` actions lets you build a small transformation
pipeline in one model.

### As a condition

For Text / Date-time / Number / Other plugins, you can instead add a condition
(`eca_tamper_condition:<plugin>`) to branch a model. It transforms a **left** value
and compares it against a **right** value using ECA's comparison operators (with
the usual case-sensitivity and negate options). This is handy for, say, comparing a
trimmed or normalised token against an expected value to decide which path a gateway
takes.

Note: a few Tamper plugins that need per-item context are not exposed, since ECA has
no such context to give them.
