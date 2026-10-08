# Math Field — manual setup guide

**Math Field** (`math_field`) is a field formatter that reads a plain text field
containing a simple arithmetic expression and renders the computed result. You
store something like `(1 + 2) * 4` in a normal text field, choose the Math Field
formatter on the entity's display, and the site shows `(1 + 2) * 4 = 12`.

The module is deliberately narrow and honest about its boundaries. It understands
the four basic operators — `+`, `-`, `*`, `/` — along with parentheses and decimal
(floating‑point) numbers, and it respects operator precedence. It **cannot** handle
negative numbers or unary operations, so `(2 + 3) * 4.5` evaluates but `-5 + 3`
does not.

What makes the module worth knowing is *how* it computes. Evaluating user‑supplied
arithmetic is exactly the place where reaching for PHP's `eval()` would turn a
harmless display formatter into a remote‑code‑execution hole. Math Field instead
uses a small hand‑written lexer and parser, exposed as a service, so the only
things it can ever compute are the four operations it implements. That restricted
grammar is the security property, not a limitation to work around.

Two practical things to keep in mind: the field stores the *expression*, not the
result, so the value is recomputed on every render and cannot be sorted or filtered
in Views; and errors for malformed expressions are shown **inline** in the rendered
output, so double‑check any public‑facing display. Note also that the module
declares its package as `custom`, so it appears under the **custom** heading on the
Extend page rather than somewhere more obvious.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
use it entirely by choosing the formatter on a field's *Manage display*, described
in "How to use it" below.

## Where it lives in the admin menu

Math Field adds no admin page of its own. You configure it on a content type's (or
any fieldable entity's) display at **Structure → Content types → *(type)* → Manage
display** (`/admin/structure/types/manage/CONTENT_TYPE/display`).

## How to use it

1. Add (or reuse) a **plain text** field on your content type — this is where the
   arithmetic expression is stored.
2. Go to the content type's **Manage display** tab.
3. For that field, choose **Math field formatter** as the format.
4. Enter an expression such as `10 + 20 - 30 + 15 * 5` when editing content; the
   display renders both the expression and its result (here, `75`).

Because the stored value is the expression rather than the answer, the result is
always live — edit the formula and the displayed total updates on the next render.
