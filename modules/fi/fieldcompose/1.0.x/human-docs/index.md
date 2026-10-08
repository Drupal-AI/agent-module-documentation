# Field Compose — manual setup guide

**Field Compose** (`fieldcompose`) provides a new **field type** that lets you
define several sub-fields inside a single field, using a **YAML-based** definition,
and stores their combined values as one encoded (JSON) value in the database.
Instead of creating ten separate fields — each with its own storage table and
revision table — you describe all ten inputs in one field's settings, and the module
keeps them together as compact, structured data.

This is a good fit when you have a component with many configuration options — a
slider library, say, with a dozen toggles and text options. Modelling that with
normal fields would mean many tables and joins; Field Compose stores it as JSON in a
single field instead. The trade-off is a slight increase in CPU (values are decoded
from JSON when read) in exchange for far fewer, cheaper database operations — often
a good bargain, especially in cloud environments where database work is the
expensive part.

The YAML definition mirrors the structure of Drupal's Form API and render elements,
so each sub-field declares a `_type` (such as `checkbox` or `textfield`), a
`_title`, whether it is `_required`, and even `_states` for conditional visibility
(showing one input only when another checkbox is ticked). It depends only on core's
Field module.

One honest caveat from the maintainer: this is meant for **simple, multi-field**
composites — it is **not** a replacement for entity references, Media, or Image
fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no site-wide settings page**. Each Field Compose field is
configured through its own **field settings** (where you write the YAML), on the
entity you add it to — see "How to use it" below.

## Where it lives in the admin menu

Field Compose adds no admin configuration page of its own. You use it by adding the
**Field Compose** field type to a content type (or other fieldable entity) under
**Structure → *(entity type)* → Manage fields**.

## How to use it

1. Go to **Structure → Content types → *(your type)* → Manage fields → Add field**
   and choose the **Field Compose** field type.
2. In the field's settings, define the sub-fields with YAML. Each entry gives an
   `id`, a `_type` (a Form API element type such as `checkbox` or `textfield`), a
   `_title`, and optional keys like `_required` and `_states`. For example:

   ```yaml
   -
     id: my_bool
     _type: checkbox
     _title: Enable something
   -
     id: my_string_field
     _type: textfield
     _title: Enter something (state-dependent field)
     _required: FALSE
     _states:
       visible:
         ':input[name="$field_name$[$field_item_delta$][my_bool]"]': { checked: true }
   ```

3. Save the field. On the entity's add/edit form, editors now see the composed group
   of inputs, and their values are stored together as a single encoded value.
