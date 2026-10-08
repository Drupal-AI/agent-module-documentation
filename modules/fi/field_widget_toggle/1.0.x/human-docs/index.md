# Field Widget Toggle — manual setup guide

**Field Widget Toggle** (`field_widget_toggle`) is a small usability improvement for
content edit forms. When a multi-value field holds a lot of entries, its widget can
stretch the form into an unwieldy wall of inputs. This module adds a **toggle
indicator** above the field's header so an editor can collapse and expand the
field's body (its values) with a single click, keeping long forms tidy.

It is purely a UX convenience — it changes nothing about how content is stored,
displayed, or accessed. Currently it targets one widget: the **Entity Reference
Autocomplete** widget (`entity_reference_autocomplete`) on multi-value fields, which
is where the author's own need arose. Support for other widgets may come later
(feature requests and patches are welcome on the project).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no dedicated settings page**. It applies to multi-value fields
using the Entity Reference Autocomplete widget, configured on the entity's
**Manage form display** — see "How to use it" below.

## Where it lives in the admin menu

Field Widget Toggle adds no admin page of its own. You work with it on
**Structure → *(your entity type)* → Manage form display**, where you set a
multi-value entity reference field to use the **Entity Reference Autocomplete**
widget.

## How to use it

1. Make sure the field you want to toggle is **multi-value** and uses the **Entity
   Reference Autocomplete** widget. Set this on the entity's **Manage form
   display** (for a content type: **Structure → Content types → *(type)* → Manage
   form display**).
2. Open an add/edit form for that entity. Above the field's header you will now see
   a toggle indicator.
3. Click the indicator to collapse the field's body (hiding the list of values);
   click it again to expand and show them. This is a display-only convenience and
   does not affect the values you have entered.
