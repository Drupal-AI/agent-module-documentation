# Paragraphs Type Help — manual setup guide

**Paragraphs Type Help** (`paragraphs_type_help`) lets you attach contextual help —
formatted text and an image — to a Paragraph type, and show it to editors right inside
the Paragraph's edit form (and optionally to visitors on the rendered page). It's the
answer to "how does an editor know what this Paragraph is for, or what an annotated
screenshot of the finished output looks like?" You author the guidance once, target it
at a Paragraph bundle and a specific form or view mode, and it appears wherever that
Paragraph is edited or displayed.

The help itself is a small **content entity**: each "Paragraphs Type Help" item
references a target Paragraph type, an optional form mode and view mode, a weight, a
published flag, and two fields you edit — rich **help text** and a **help image**.
Because it's a content entity, help items are translatable and revisionable, so you can
localize guidance per language and roll back changes. You manage all of them from one
admin list, and the module renders them as an "extra field" on the Paragraph's form and
view displays, ordered by weight, only when matching published help actually exists.

It depends on the **Paragraphs** module plus core **Image**, **Options**, and **Text**.
Two permissions separate "who can administer the entity type and its fields" from "who
can create and edit help items." It works the moment you create help — there's no
global settings form of key/value config — but showing help to *visitors* (as opposed
to editors) is opt-in per Paragraph view display. It also pairs nicely with the
optional **Field Group** module to wrap the help in a collapsible "Need Help?" fieldset.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — creating help items, targeting a Paragraph
   type and mode, showing help to visitors, and the permissions.

## Where it lives in the admin menu

Help items are managed at **Content → Paragraphs Type Help**
(`/admin/content/paragraphs-type-help`). The help entity's own fields and displays are
configured under **Structure → Paragraphs Type Help**
(`/admin/structure/paragraphs-type-help`).

## How to use it

Create a help item, point it at a Paragraph type (and optionally a form/view mode),
write the help text and add an image, and save. Editors immediately see it on that
Paragraph's edit form. To show help to visitors too, enable the help extra field on the
Paragraph type's *Manage display*. See [Configuration](configuration/index.md) for the
walkthrough.
