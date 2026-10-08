# Media Library Media Modify — manual setup guide

**Media Library Media Modify** (`media_library_media_modify`) lets editors store
**per-placement overrides** of a referenced media item's fields, right from the
media library widget. The same reusable media entity can then appear differently
on each piece of content that references it — a different alt text, caption, or
title per article — **without ever changing the underlying media entity**. The
overrides apply only at display time, for that one reference; the canonical media
item stays untouched (and is protected: saving an override-loaded copy is blocked).

The module gives you three building blocks. A **field type**, "Media with
contextual modifications", which is an entity-reference field (to media by
default) that also stores a JSON map of overrides. A **field widget**, "Media
library extra", which extends core's Media Library widget and adds an
"Override … in context of this …" button next to each selected item, plus a few
useful widget settings. And a **Views field**, "Edit link for the Media Library",
that adds an edit button inside a media-library view. A Drush command is included
to convert an existing entity-reference field to the new modify field type.

It depends on core's **Media Library** module. There is **no admin settings
page** — you configure everything by adding the field and choosing its widget on a
bundle's *Manage fields* / *Manage form display*. It optionally integrates with
the `diff` module (to compare original vs. overridden values). One experimental
submodule, **entity_reference_entity_modify**, extends the same contextual-override
idea to non-media entity references via an autocomplete widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the submodule.

## Where it lives in the admin menu

There is no dedicated settings page. You work on a content type's (or other
entity's) field configuration: **Structure → Content types →** *your type* **→
Manage fields** and **Manage form display**
(`/admin/structure/types/manage/<bundle>/fields` and `.../form-display`).

## How to use it

### 1. Add the field

1. Go to your content type's **Manage fields** page and **Add field**.
2. Choose the field type **"Media with contextual modifications"**.
3. Configure it like a normal media reference (which media types it may reference,
   how many values, and so on) and save.

### 2. Choose the widget and its settings

On the same bundle's **Manage form display** page, set the field's widget to
**"Media library extra"**. Its settings are:

- **Form mode** — which form mode the per-item override form uses (default
  `default`). Shown only for the "Media with contextual modifications" field type.
- **Skip edit form after creating a new media item** (`no_edit_on_create`) — go
  straight back to the widget after adding a media item, without opening its edit
  form.
- **Combined edit form for newly created items** (`multi_edit_on_create`) — after
  creating several new media items, show a single form applied to all of them.
  (Mutually exclusive with the "skip edit form" option.)
- **Pre-check already-selected items** (`check_selected`) — when the library
  reopens, tick the items already in the field (only for multi-value fields).
- **Order indicator instead of checkbox** (`replace_checkbox_by_order_indicator`)
  — replace the library's selection checkbox with an order indicator, handy for
  ordered galleries (multi-value fields only).

On a "Media with contextual modifications" field the widget adds an "Override …"
button per selected item, which opens the override modal. (If you point the widget
at a plain core `entity_reference` media field instead, it just adds a simple
"Edit media item" link.)

### 3. Editing overrides

When editing content, pick media from the library as usual, then click the
**Override** button on an item to open a form where you change that placement's
field values. Those values are stored with the referencing content (on its
revision), not on the media entity — so the same image can carry different
overrides on every page that uses it.

### 4. Optional: edit link inside the media library

To let editors edit media inline from the library modal, add the Views field
**"Edit link for the Media Library"** to the media-library view's widget display.

### 5. Optional: migrate an existing field

If you already have a plain entity-reference media field and want to give it
contextual overrides, convert it with the bundled Drush command:

```bash
drush media_library_media_modify:migrate <entity_type_id> <field_name>
```

See the [`agent/`](../agent/start.md) docs for the override service API and the
read-only guard details.
