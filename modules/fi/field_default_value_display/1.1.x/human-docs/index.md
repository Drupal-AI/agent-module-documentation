# Field Default Value Display — manual setup guide

**Field Default Value Display** (`field_default_value_display`) adds a **Default
value** column to Drupal's *Manage fields* overview. Out of the box, that table
shows each field's label, machine name, and field type — but not the default
value you configured. To check a field's default you normally have to open its
edit form one field at a time. This module surfaces all of those defaults
directly in the list, so you can see them at a glance.

The column appears automatically on the *Manage fields* page for every fieldable
entity type that uses Field UI — content types, taxonomy vocabularies, user
profiles, media types, and any custom entities. It knows how to render
human‑readable values for the standard field types: text, number, boolean, date,
email, link, image, entity reference, and list fields. For list fields it shows
the option *label* rather than the stored machine key; for entity reference
fields it loads and shows the referenced entity's label; for image fields it
shows the default image's filename.

This is purely an administrative convenience. It changes nothing about how your
content is stored or displayed, adds no permissions, and needs no configuration —
enabling the module is all it takes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. The Default value column
appears on its own once the module is enabled.

## Where it lives in the admin menu

Field Default Value Display adds no admin page of its own. You see it wherever
Field UI already lives — for a content type, at **Structure → Content types →
*(type)* → Manage fields** (`/admin/structure/types/manage/{type}/fields`). Look
for the new **Default value** column between the *Field type* and *Operations*
columns. The same column appears on the Manage fields page for every other
fieldable entity type.
