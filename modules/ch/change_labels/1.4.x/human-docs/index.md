# Change labels — manual setup guide

**Change labels** (`change_labels`) lets administrators rename the labels and
text shown on entity forms — field labels, the "Add another item" button on
multivalue fields, the "Remove" button on file and image widgets, and the entity
form's "Save" button — all through configuration rather than code or template
overrides. It gives you a place to add context that ordinary interface
translation can't reach, because the change is tied to a specific widget in a
specific form display.

The classic example: on a *Team* content type with a multivalue *Team members*
field, you can change the generic "Add another item" button to read "Add another
team member", and rename the field's label to match your organisation's wording —
without touching the field definition, which stays shared across every bundle
that uses it.

Because everything is stored as configuration, your label changes can be
exported and deployed like any other config. The module changes only how labels
*display*; it never alters field machine names, stored data, or access. It works
on the moment you enable it — there is no central settings page to fill in.
Note that its `composer.json` still lists `hook_event_dispatcher` as a
dependency for safety, but since version 1.4.0 the module no longer uses it (core
hook classes are used instead), so you can uninstall Hook Event Dispatcher if
nothing else needs it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** for this module. You set label
overrides directly on each field's widget in a form display mode, described in
"How to use it" below.

## Where it lives in the admin menu

Change labels adds no admin page of its own. You configure it from **Structure →
Content types → *(your type)* → Manage form display** (and the equivalent
"Manage form display" tab on other entity types), where each field's widget
settings gain the label options.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the **Manage form display** tab of the content type (or other entity
   bundle) you want to adjust.
3. Open a field's widget settings (the small gear/cog for that row).
4. Use the added options to change or hide that field's label, change its "Add
   another item" text (for multivalue fields), or replace the "Remove" button
   text (for file and image widgets).
5. To rename the form's submit button, set a different label for the entity
   form's **Save** button in the same display's settings.
6. Save the form display. The new wording appears immediately on that form for
   editors.
