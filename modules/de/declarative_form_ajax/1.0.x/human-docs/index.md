# Declarative Form Ajax — manual setup guide

**Declarative Form Ajax** (`declarative_form_ajax`) is a developer tool that gives
Drupal's Form API a simpler way to update one form element by AJAX when another
element changes — declaratively, right in the form array, instead of hand-wiring
`#ajax` callbacks.

If you've built dependent fields in Drupal before, you know the boilerplate: an
`#ajax` definition, a callback method, and code to return the right part of the
form. This module works much like core's `#states` system — you describe the
relationship declaratively and it wires up the behaviour for you. You mark an
element as being **updated by** another element (identified by its form parents)
and add a single after-build callback to the form; when the controlling element's
value changes, the dependent element refreshes automatically. No custom callback
required.

It ships a **demo submodule** (`declarative_form_ajax_demo`) with working examples,
which is the fastest way to see the API in action. The project is a proof of
concept for a Drupal core issue but is perfectly usable as a contrib dependency
today. It has no dependencies of its own beyond core and supports Drupal 10 and 11.

Because this is an API for developers, there's nothing to configure in the admin
UI — you use its syntax in your own form code. Note the usual Form API caution: the
AJAX callbacks it wires run with the current user's privileges, so build and escape
your form output as you normally would.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the demo submodule.

There is **no configuration page** — this is a developer API you use in your form
code, shown below.

## How to use it

Declarative Form Ajax is used from your module's form-building code, not the admin
UI. In outline, you:

1. Give the dependent element an `#ajax` definition with an `updated_by` key that
   lists the form parents of the element(s) it should react to.
2. Register the module's after-build handler on the whole form (an
   `$form['#after_build'][]` entry pointing at the module's `FormAjax` class) so it
   sets up the AJAX behaviour.

When a user changes a controlling element, the dependent element is re-rendered
automatically — no per-field callback needed. The bundled
**`declarative_form_ajax_demo`** submodule contains complete, working examples;
enable it and read its forms to copy the exact pattern into your own code.
