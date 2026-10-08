# Multistep Form Framework — manual setup guide

**Multistep Form Framework** (`multistep_form_framework`) is a **developer‑only**
framework for building multi‑step ("wizard") forms in Drupal. Long forms are
easier to complete when they are broken into a sequence of steps, and this module
provides the machinery to do that while keeping the process simple for developers
and flexible in how it is configured. It deliberately ships **no UI of its own** —
if you want to click a form together in the admin, use Webform instead; this is a
toolkit for writing code.

Its distinguishing idea is a **YAML plugin system**, similar to core's
`*.links.action.yml`. You declare each step of a wizard in a
`MODULE.multistep_wizard.yml` file — giving each step an id and the PHP class that
renders it — so everything about a wizard is configured in one place, and you can
namespace steps logically when a module contains several wizards. Compared with
other examples, it removes the need for a separate "step manager" class and lets
a form **jump to any step**, even based on custom logic in a previous step's
submit handler.

An optional **examples submodule** (`multistep_form_framework_examples`)
demonstrates the pattern with a working "buy a book" wizard. The framework itself
adds no fixed security surface: forms built on it inherit standard Form API
validation and access, so when you build a wizard, validate each step's data (a
later step must not blindly trust an earlier step's input) and enforce access at
every step, not just the first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the examples submodule.

There is **no configuration page** for this module — it has no settings form and
no admin UI at all. You "configure" a wizard entirely in code, described in "How
to use it" below.

## How to use it

Building a wizard takes two pieces of code in your own module:

1. Create your form class and extend
   `\Drupal\multistep_form_framework\Form\MultistepForm`. The one required thing
   is to set the form id via `::getFormId()` — this id is what ties the form to
   its step definitions.
2. Add a `MODULE_NAME.multistep_wizard.yml` file that lists the steps for that
   form id. Each step entry has an `id` and a `class` (the PHP class that renders
   that step). For example:

   ```yaml
   your_form_id_here:
     steps:
       - id: greetings
         class: \Drupal\my_module\Form\BuyBookStep\Greetings
       - id: book_attributes
         class: \Drupal\my_module\Form\BuyBookStep\BookAttributes
       - id: description
         class: \Drupal\my_module\Form\BuyBookStep\Description
       - id: congratulation
         class: \Drupal\my_module\Form\BuyBookStep\Congratulation
   ```

The framework then drives the sequence, carries state between steps, and lets you
jump to any step from a submit handler. Enable the examples submodule if you want
a complete, working reference implementation to copy from.
