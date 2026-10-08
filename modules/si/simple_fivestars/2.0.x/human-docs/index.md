# Simple Fivestars — manual setup guide

**Simple Fivestars** (`simple_fivestars`) gives you a reusable five‑star rating
control for Drupal. It bundles three things that work together: a custom
`fivestars` form element, a matching **field widget** for typing in a 0–5 value,
and a **field formatter** that shows a stored number as filled stars. If you have
ever wanted a "rate this out of five" control on a content type without pulling in
a full voting framework, this is the lightweight way to get it.

The rating lives on an ordinary numeric field — integer, decimal, or float — so it
behaves like any other field you attach to a node, user, taxonomy term, or other
entity. Editors set the value through the normal entity edit form, and the
formatter renders it on display as a proportional star fill (a decimal such as 3.5
shows three and a half filled stars). There is no public "vote" button and no
anonymous submission endpoint: values are entered through standard, access‑gated,
CSRF‑protected entity forms, so the module adds no vote‑stuffing or request‑forgery
surface of its own.

There is nothing you must configure globally — the module has no settings page. You
simply add a numeric field, choose the Fivestars **widget** on the form display,
and the Fivestars **formatter** on the display, and it works. The one widget option
is a "Hide label" toggle. Developers can also drop the element straight into a
custom form with `'#type' => 'fivestars'`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module surfaces entirely through Drupal's **Field UI**, so there is no admin
menu entry of its own:

1. Add (or reuse) an **integer**, **decimal**, or **float** field on the entity you
   want to rate — for example an article content type.
2. Go to **Manage form display** for that bundle and set the field's widget to
   **Fivestars**. The optional **Hide label** setting renders the star control
   without its field label, which is handy when the surrounding layout already
   makes the meaning clear.
3. Go to **Manage display** and set the field's formatter to **Fivestars**. Stored
   values now render as filled stars, with decimals shown as a partial fill.

Developers who need the control outside a field can use the form element directly,
e.g. `$form['rating'] = ['#type' => 'fivestars', '#default_value' => 3];`. Input is
constrained to whole values 0–5, and the bundled CSS and star assets are attached
automatically when the element renders.
