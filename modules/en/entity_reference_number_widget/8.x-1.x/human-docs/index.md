# Entity Reference Number Widget — manual setup guide

**Entity Reference Number Widget** (`entity_reference_number_widget`) provides an
entity-reference field **widget where the editor types the target entity's ID
directly as a number**, instead of using autocomplete or a select list. If you
already know the numeric ID of the entity you want to reference, this is the
fastest way to enter it.

It shines in data‑entry workflows and imports where entity IDs are already known —
for example, keying references from a spreadsheet or a legacy system. It is purely
a field widget: it has no content or access role of its own, and the reference
still respects the referenced entity's access when the field is rendered. It has no
third‑party dependencies and runs on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no site‑wide settings
form. You select it as a widget on a field's *Manage form display*, described in
"How to use it" below.

## Where it lives in the admin menu

Entity Reference Number Widget adds no admin settings page. You use it from
**Structure → Content types (or any fieldable entity) → *(bundle)* → Manage form
display**.

## How to use it

1. Go to the **Manage form display** page of an entity that has an
   entity-reference field (for example **Structure → Content types → Article →
   Manage form display**).
2. Change that field's widget to the entity-reference number/ID widget provided by
   this module.
3. Click **Update**, then **Save** the form display.

When editing content, the reference field now accepts a numeric entity ID typed
directly instead of an autocomplete search.
