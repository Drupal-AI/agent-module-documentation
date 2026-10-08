# Select Radio Checkbox HTML5 Validation — manual setup guide

**Select Radio Checkbox HTML5 Validation** (`s_r_c_html5_validation`) fills a small
but annoying gap in Drupal's forms: it automatically applies native HTML5
validation to **select lists, radio buttons and checkboxes** that are marked
required.

Out of the box, Drupal's markup for these particular element types does not
reliably trigger the browser's built-in HTML5 required-field validation the way a
text field does. If your project relies on that native client-side validation — the
browser popping up "Please select an item in the list" before the form submits —
required select/radio/checkbox fields can slip through without it. This module adds
that behaviour back, across all forms, so those elements get the same immediate
in-browser feedback as everything else.

It works the moment you enable it. There is **no configuration**, no settings form,
and nothing to set up per form — it applies site-wide automatically. It has no
dependencies on other modules, no submodules, and no third-party libraries.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.

## How to use it

There is nothing to use, as such — once the module is enabled, required select,
radio and checkbox fields on your site's forms simply start enforcing native HTML5
validation. To see it in action, find (or build) a form with a required select or
radio field, leave it unset, and try to submit: the browser should now block
submission and prompt you to make a choice.
