# Form display field alter — manual setup guide

**Form display field alter** (`form_display_field_alter`) is a developer API that
lets code **adjust field definitions before they are used by a form display**.
Rather than overriding an entire form, a developer can tweak a field's widget
settings, label, or definition for a particular context, and have those changes
apply only when that form display is used to build an entity form. It's plumbing
for finer‑grained control of add/edit forms.

The value it unlocks is having **different form presentations for the same
bundle** — for example, one form display where a field is required and another
where it isn't — driven by per‑display overrides rather than sprawling
`hook_form_alter` code. This base module supplies the programmatic interface; it
has no content or access role of its own.

The project also ships a companion module, **Form display field settings**, that
puts a point‑and‑click layer on top of this API: with it enabled, the cogwheel
next to a field on the **Manage form display** page lets you override that field's
**label, help text, required status, and default value** for the current form
display — no code needed. Enable that companion module if you want the UI (see
Installation).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally add the "Form display field settings" companion for a UI.

There is **no configuration page** for the base module itself — it's a developer
API. If you enable the companion "Form display field settings" module, its
overrides appear per field on Manage form display, described in "How to use it"
below.

## Where it lives in the admin menu

The base module adds no admin page. When the companion **Form display field
settings** module is enabled, you work from **Structure → Content types → *(type)*
→ Manage form display**, using the cogwheel next to each field.

## How to use it

For developers, this module exposes a programmatic interface to modify field
definitions before the form‑display system uses them — apply your adjustments in
code and they take effect when the relevant form display renders.

For site builders who want the no‑code experience, enable the companion **Form
display field settings** module and then:

1. Go to **Structure → Content types → *(type)* → Manage form display** (switch to
   a specific form mode first if you want the override to apply only there).
2. Click the **cogwheel** next to a field.
3. Override the field's **label**, **help text**, **required** status, and
   **default value** as needed for this form display.
4. Click **Update**, then **Save**.

The overrides apply only when that form display is used to build the entity form,
letting you present the same bundle differently in different contexts.
