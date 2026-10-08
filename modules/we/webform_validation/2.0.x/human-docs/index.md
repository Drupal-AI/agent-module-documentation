# Webform Validation — manual setup guide

**Webform Validation** (`webform_validation`) adds **cross-element validation** to the
[Webform](https://www.drupal.org/project/webform) module — rules that look at more than
one field at once. Drupal core and Webform can already check a single field (required,
email format, number range), but they can't easily say "these two fields must match" or
"fill in at least one of these three". This module adds exactly that.

It gives you three rules, each configured right inside Webform's own element settings:

- **Equal values** — several elements must all hold the same value (great for
  "Confirm email" or "re-enter account number" fields; emails are compared
  case-insensitively).
- **Compare two values** — one element compared against another with `>`, `>=`, `<`, or
  `<=` (for example, an end date must be after a start date), with an optional custom
  error message.
- **Some of several** — require that a number of elements out of a group be completed —
  at least *N*, at most *N*, or exactly *N* — optionally only on the final page of a
  multi-step wizard.

There is no separate admin screen and nothing global to switch on. Every rule is set up
per element, so you add validation exactly where you need it, entirely through the
Webform UI without writing any code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform.
2. [Configuration](configuration/index.md) — the three validation rules, field by
   field, and where they appear in the Webform element editor.

## Where it lives in the admin menu

Webform Validation has **no page of its own**. You use it inside each webform's
builder: **Structure → Webforms**, open a form, go to its **Build** tab, edit an
element, and look for the **Form extra validation** section on the element's settings
form.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit the webform where you want a rule and open the element that should carry the
   check — for example the **Confirm email** field, or the **End date** field.
3. In that element's settings, open the **Form extra validation** fieldset and turn on
   the rule you need.
4. Save the element, then save the form. The rule runs automatically when a visitor
   submits, showing an error if the condition isn't met.

See [Configuration](configuration/index.md) for exactly what each rule does and which
element types support it.
