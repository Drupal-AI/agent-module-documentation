# Required by Form mode — manual setup guide

**Required by Form mode** (`required_by_form_mode`) lets a single field be
required in one form display and optional in another. Drupal normally stores
"required" as a property of the field itself, so it applies everywhere the field
appears. This module lifts that restriction: you keep the field *not* required in
its base settings, then mark it as required only on the specific form modes where
it matters.

A common example is a field that should be mandatory on your full editorial form
but optional on a quick "inline" or registration form mode — or the other way
around. The module is tested with node, user, and taxonomy term entities and pairs
well with the **Form Mode Manager** module.

There is no central settings page. You turn the base field's "Required" setting
off, then enable the requirement per form mode on that form mode's field
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no configuration page of its own — setup happens per field and per
form mode, described in "How to use it" below.

## Where it lives in the admin menu

There is no dedicated admin page. You work from the field settings under
**Structure → Content types (or Users, or Taxonomy) → Manage form display**, after
selecting the form mode you want to configure.

## How to use it

1. Go to the field's base settings (**Manage fields → *(the field)* → Edit**) and
   make sure **Required field** is *unchecked*. This is what lets the per-form-mode
   rule take over.
2. Go to **Manage form display** for the same bundle and switch to the form mode
   you want (using the form-mode selector at the top, or via Form Mode Manager).
3. In that form mode's field settings, mark the field as **required**.
4. Save.

The field is now required only when that particular form mode is used, and remains
optional elsewhere. Note this is a form-validation rule for the editing UI — it is
not a data constraint on every write, so saves made through other form modes or
the API are not forced.
