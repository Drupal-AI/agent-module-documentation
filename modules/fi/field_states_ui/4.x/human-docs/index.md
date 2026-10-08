# Field States UI — manual setup guide

**Field States UI** (`field_states_ui`) puts Drupal's form **States API** —
the mechanism that shows, hides, requires, or disables one field based on another
field's value — into the point‑and‑click **Manage form display** UI. So a site
builder can create logic like "only show the *Other, please specify* text box when
the dropdown is set to *Other*" without writing a line of PHP or a custom form
alter.

You attach one or more "field states" to a field's widget on any entity's Manage
form display page. Each state pairs a behaviour with a condition: pick a
behaviour — `visible`, `invisible`, `required`, `optional`, `enabled`, `disabled`,
`checked`, `unchecked`, `expanded`, or `collapsed` — then say which other field to
watch, how to compare it, and against what value. At form‑build time the module
translates your states into the `#states` array core understands, producing live,
client‑side behaviour as the user fills in the form.

Because the states are stored on the widget itself (as third‑party settings inside
the form‑display configuration), your conditional logic is exported and deployed
right alongside the rest of your form‑display config. It works across 50+ core and
contrib widgets — including Address, Paragraphs, Select2, and Webform — and lets
developers add new state types by writing a custom FieldState plugin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the plugin API and
the stored config shape — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and tune field states on a
   widget, field by field.

## Where it lives in the admin menu

Field States UI has **no central settings page**. You configure it in place, on
each field, from the **Manage form display** tab of any bundle — for example
**Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`). It adds no permissions of
its own and no Drush commands.
