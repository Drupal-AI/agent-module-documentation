# Entity Browser Validation — manual setup guide

**Entity Browser Validation** (`entity_browser_validation`) fixes a small but
irritating gap in the [Entity Browser](https://www.drupal.org/project/entity_browser)
module: when an Entity Browser entity-reference field fails validation on a
content form, the widget is not visually flagged. Drupal core marks failed
inputs, selects, and textareas with a red "error" highlight, but the Entity
Browser widget had no targetable element to receive that treatment — so an editor
who left a required media/reference field empty would see the form refuse to save
without any obvious indication of *which* field was at fault.

This module closes that gap. It adds a `name` attribute to the widget's wrapper
(built from the field name and the form's parents) so the error can target it, and
attaches a tiny CSS library that styles the flagged widget in red — exactly the way
core styles its own fields. The result is a consistent, familiar error cue across
your whole content form.

There is nothing to configure. The module works the moment you enable it, and it
only affects fields that use the Entity Browser "entity reference" widget. Because
the highlight is applied with the same `error` CSS class core uses, you can restyle
it from your theme to match your design system if you want. Its only dependency is
the Entity Browser module itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Entity Browser Validation adds no admin page and has no settings form. Once
enabled, it applies automatically to every Entity Browser entity-reference widget
across your content forms.

## How to use it

There is no setup beyond enabling the module. Continue using your Entity Browser
fields exactly as before — when a validation error occurs (for example a required
reference left empty), the widget now turns red like any other failed field. To
change the look of that highlight, override the `error` class from your theme's
CSS.
