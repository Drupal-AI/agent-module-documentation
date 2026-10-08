# Field Group Complete — manual setup guide

**Field Group Complete** (`field_group_complete`) adds a live **complete /
incomplete** badge to Field Group sections on entity edit forms. When every
visible, required field inside a group is filled, the group's tab (or fieldset,
or details element) gets a `complete` CSS class and an accessible badge that reads
"Complete"; while requirements are still outstanding it shows as incomplete. The
badge updates in real time as the editor types.

It extends the contrib **[Field Group](https://www.drupal.org/project/field_group)**
module, which is what organizes fields into tabs, fieldsets, and details groups in
the first place. Field Group Complete layers a small amount of JavaScript on top
of those groups; it does not create groups itself, so you configure your tabs and
fieldsets in Field Group as usual and this module simply annotates them. It also
handles required radio‑button groups correctly, so a group whose only requirement
is a radio selection is judged accurately.

The value is editorial UX on long, multi‑tab forms: editors can see at a glance
which sections are finished and which still need attention before saving, which
cuts down on save‑time validation surprises. It is purely presentational —
completion is computed client‑side in the browser, no data is changed, and it adds
no routes beyond its own admin settings form and no custom permissions.

It works with zero configuration — enable it and it starts annotating Field Group
wrappers immediately. An optional settings form lets you customize the badge text,
badge visibility, and the CSS classes applied, which is handy for theming or
matching a design system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Field Group.
2. [Configuration](configuration/index.md) — the optional settings form: badge
   text, badge visibility, and custom CSS classes.

## Where it lives in the admin menu

Once enabled, Field Group Complete immediately enhances Field Group wrappers on
entity edit forms — there is nothing you must configure. Its optional settings
form sits at **Configuration → Content authoring → Field Group Complete**
(`/admin/config/content/field-group-complete`).
