# UUID Extra — manual setup guide

**UUID Extra** (`uuid_extra`) lets you show an entity's UUID on its edit form and in
its rendered output. Every content entity in Drupal (nodes, users, taxonomy terms,
media, and so on) has a `uuid` base field — a stable, non-numeric identifier that
survives across environments — but core keeps it hidden from the *Manage form
display* and *Manage display* UIs, so there is normally no way to surface it without
writing code. UUID Extra removes that restriction.

It does two things. First, it makes the `uuid` base field *display-configurable*, so
it appears as a row you can enable on both the **Manage form display** and **Manage
display** pages of any entity type that has a UUID. Second, it ships two small
plugins: a read-only UUID **widget** (a disabled text field that shows the value on
the edit form but can never be changed) and a UUID **formatter** (which prints the
raw UUID string in rendered output). That is useful for editors who need to copy an
entity's UUID, for integrators wiring up decoupled front ends, and for support or QA
staff who reference specific entities across environments or during content
staging.

This is a small developer/display module: there is no settings form, no permission,
no configuration object, and no Drush command. You use it entirely through the
standard display-configuration UIs (or by setting a `uuid` component on the display
config in code/exported config). It has no dependencies beyond Drupal core and ships
no submodules.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

UUID Extra has no admin page of its own. You work with it on the display-management
pages of each entity type, for example:

- **Structure → Content types → *[type]* → Manage form display**
  (`/admin/structure/types/manage/<type>/form-display`)
- **Structure → Content types → *[type]* → Manage display**
  (`/admin/structure/types/manage/<type>/display`)

The same *Manage form display* / *Manage display* pages exist for users, taxonomy
terms, media, and other entity types.

## How to use it

**Show the UUID on the edit form:**

1. Go to the entity's **Manage form display** page.
2. Drag the **UUID** row up out of the *Disabled* section.
3. Choose the **UUID** widget and click **Save**. The UUID now appears on the edit
   form as a read-only text field.

**Show the UUID in rendered output:**

1. Go to the entity's **Manage display** page and pick the view mode you want (for
   example *Default* or *Teaser*).
2. Enable the **UUID** row and choose the **UUID** formatter, then **Save**. The
   UUID string now renders wherever that view mode is shown.

The same steps work for any entity type that has a `uuid` key. If you manage
displays as exported configuration, this shows up as a `uuid` component (with
`type: uuid`) inside the `core.entity_form_display.*` / `core.entity_view_display.*`
config entities; remove it by dragging the field back to *Disabled*.
