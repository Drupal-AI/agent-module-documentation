# Calculation Fields — manual setup guide

**Calculation Fields** (`calculation_fields`) adds a form element that evaluates
a mathematical expression over other fields' values. Instead of hard-coding a
formula in custom PHP, you define the expression as configuration — so the
people who own the business rule can see and change it. It shines on forms that
compute a result: an order total from quantity and price, a BMI from height and
weight, a score from weighted answers, a quotation from a set of options, a
subtotal plus tax.

It also integrates with Webform, so you can add a calculated element to a
webform, and it ships example submodules to show the pattern in practice. Access
to the expression settings is guarded by an `administer calculation_fields
configuration` permission, which is deliberately marked as restricted — a stored
expression is stored logic, so treat that permission like the ability to change
how the site behaves.

Three things are worth establishing before you rely on it for anything that
matters:

- **Where the value is computed.** A value calculated in the browser is a value
  the submitter can tamper with. Anything that matters — a price, an eligibility
  score — must be recomputed on the server when the form is submitted, whatever
  the widget shows the user.
- **How the expression is evaluated.** A real expression parser is the right
  design; an implementation that reached PHP's `eval()` would make that
  permission equivalent to running code. Worth confirming either way before you
  trust it with sensitive formulas.
- **Numbers and money.** Floating-point arithmetic is the wrong tool for
  currency — a total computed as a float and stored as money will eventually be
  a penny out, and someone will notice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.

## Where it lives in the admin menu

Calculation Fields is in the **Fields** package on the Extend (modules) page. It
provides an `administer calculation_fields configuration` permission — set under
**People → Permissions** (`/admin/people/permissions`) — which you should grant
only to trusted roles, since it controls stored formulas.

## How to use it

Enable the module (plus the Webform submodule if you build webforms), then add
the calculation element to a form and set its expression to reference the other
fields' values. On submission the expression is evaluated to produce the
calculated result. Start from the bundled example submodules to see a working
setup, and remember to recompute anything sensitive server-side.
